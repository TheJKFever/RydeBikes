class User < ActiveRecord::Base
	@@service_type = {
		:membership => 'membership',
		:payperuse 	=> 'pay_per_use',
		:compt 		=> 'compt'
	}

	def self.service_type
		@@service_type
	end

	before_create do |user|
		user.api_key = ApiKey.create(user_id: user.id)
	end

	validates :email, :presence => true

	# validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+edu)\z/i, 
		# :message => "email must end in .edu", :unless => :admin
	# validate :validate_network, :unless => :admin

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
			:recoverable, :rememberable, :trackable, :validatable,
			:omniauthable

	# attr_accessible :email, :password, :password_confirmation, :remember_me
	# TODO: make this into strong parameters
	belongs_to :address
	has_many :payments
	has_many :rides
	has_many :authentications
	belongs_to :network
	has_one :api_key
	has_many :intersts

	def serializable_hash(options={})
		super({ only: [:name, :phone, :service_type, :email, :picture] }.merge(options || {}))
	end

	def find_or_initialize_by_omniauth(auth)
		user = find_or_initialize_by_email(auth['info']['email'])
		user.name = auth['info']['name']
		user.picture = auth['info']['image']
		authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['extension']['token'])
	end

	def apply_omniauth(auth)
		# use cases:
		# - new user sign up through omniauth (already checked email)
		# - old user first time sign up through provider
		# - old user logged in already, connecting provider
		fb_email = auth['info']['email'].downcase
		if (new_record?)
			self.email = fb_email
			self.name = auth['info']['name']
		else
			if (self.email != fb_email)
				# emails are not the same, if fb is valid, update
				if (valid_email(fb_email))
					self.email = fb_email
				end
			end
			# self.name = auth['info']['name'] # no need to update name
		end
		self.picture = auth['info']['image']
		self.authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['extension']['token'])
	end

	def valid_password
		return valid_password?(self.password)
	end

	def valid_email
		return valid_email?(self.email)
	end

	def valid_email?(email)
		return true if :admin
		return !(email.to_s =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+edu)\z/i).nil?
	end

	def validate_network
		domain = self.email.match(/(?<=@)(.*)(?=.edu)/).to_s.downcase
		self.network = Network.find_by_domain(domain)
		errors[:base] << "Invalid Network" if self.network.nil?
	end
end
