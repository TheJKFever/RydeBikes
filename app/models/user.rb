class User < ActiveRecord::Base
  STATUS = {
    :outstanding => 'Outstanding balance',
    :goodstanding => 'In good standing'
  }

  # :lockable, :timeoutable, :confirmable, :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable

  attr_accessor :login

  belongs_to :network
  belongs_to :address
  has_many :authentications
  has_many :intersts
  has_many :rides
  has_many :trans, class_name: 'Transactions'

  validates_presence_of :status
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }
  # validates_confirmation_of :password, :if => :password_required?
  # validates_length_of :password, :within => password_length, :allow_blank => true
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  # validates_format_of     :email, with: Devise.config.email_regexp, allow_blank: true, if: :email_changed?
  # validates_presence_of :password, :if => :password_required?
  # validates_confirmation_of :password, :if => :password_required?
  # validates_length_of :password, :within => password_length, :allow_blank => true

  # Validates university email
  # validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+edu)\z/i, 
    # :message => "email must end in .edu", :unless => :admin
  # validate :validate_network, :unless => :admin

  def generate_new_api_key
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(:access_token => access_token)
    save(validate: false)
  end

  def apply_omniauth(provider, auth)
    # TODO: user provider to save different information for different providers
    # use cases:
    # - new user sign up through omniauth
    #       already checked email for duplicate record
    # - old user first time sign up through provider
    # - old user logged in already, connecting provider
    email = auth['info']['email'].downcase if email.blank?
    # confirm!
    name = auth['info']['name'] if name.blank?
    self.picture = auth['info']['image']
    self.authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['extension']['token'])
  end

  # retreives user by either email or username
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions.each { |k,v| v.downcase! }
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["username = :value OR email = :value", { :value => login }]).first
    else
      conditions[:email] if conditions[:email]
      where(conditions.to_hash).first
    end
  end

  def validates_payment_and_good_standing
    return true if (valid_payment_method? && in_good_standing?)
    return false
  end

  # ensure that any profile information that is required is not blank
  def has_basic_profile_info?
    return false if name.blank? || email.blank?
    return true
  end

  def serializable_hash(options={})
    super({ :only => [:id, :name, :phone, :email, :picture, :access_token]}.merge(options || {}))
  end

  # NOT BEING USED ANYWHWERE...
  # def find_or_initialize_by_omniauth(auth)
  #   user = find_or_initialize_by_email(auth['info']['email'])
  #   user.name = auth['info']['name']
  #   user.picture = auth['info']['image']
  #   authentications.build(
  #     :provider => auth['provider'], 
  #     :uid => auth['uid'], 
  #     :token => auth['extension']['token'])
  # end

  ## BRAINTREE METHODS
  #
  # Braintree stores actual payment methods, authorizations, and defaults
  # too access the braintree information
  # SERVER SIDE: 
  #   customer = Braintree::Customer.find(braintree_id)
  # CLIENT SIDE:
  #   render Braintree::ClientToken.generate(:customer_id => braintree_id)
  #   then use client sdk to communicate with Braintree
  def valid_payment_method?
    raise NoPaymentMethodException, "User has not added a payment method. Please add a valid payment method." if braintree_id.nil?
    @customer = get_braintree_customer
    # Check if customer has any payment_method
    if @customer.payment_methods.empty?
      return render json: { error: 'Braintree customer account created, but no payment added. Please add a valid payment method.'}, status: :unauthorized
    end
  end

  def in_good_standing?
    raise NoPaymentMethodException, "Users has a status of: #{status}. Please contact us to resolve this issue." if status != STATUS[:goodstanding]
  end

  # returns braintree payment_method object or nil
  def get_default_payment_method
    @customer = get_braintree_customer
    return nil if @customer.nil?
    # get default payment_method of customer
    @customer.payment_methods.each do |payment|
      return payment if payment.default?
    end
  end  

  # returns braintree customer object or nil
  def get_braintree_customer
    return Braintree::Customer.find(braintree_id)
  rescue Braintree::NotFoundError
    update_attributes(:braintree_id => nil)
    self.errors[:base] << "Invalid Braintree token. Please update payment methods."
    return nil
  end

  # def valid_email
  #   return valid_email?(self.email)
  # end

  # def valid_email?(email)
  #   return true if :admin
  #   return !(email.to_s =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+edu)\z/i).nil?
  # end

  # def validate_network
  #   domain = self.email.match(/(?<=@)(.*)(?=.edu)/).to_s.downcase
  #   self.network = Network.find_by_domain(domain)
  #   errors[:base] << "Invalid Network" if self.network.nil?
  # end

  class NoPaymentMethodException < Exception
  end
  class OutStandingBalanceException < Exception
  end
end
