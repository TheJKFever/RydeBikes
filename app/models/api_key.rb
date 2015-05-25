class ApiKey < ActiveRecord::Base
	before_create :generate_access_token
	validates :user_id, presence: true
	belongs_to :user

	def serializable_hash(options)
		super(:only => [:access_token])
	end

	def generate_access_token
		begin
			self.access_token = SecureRandom.hex
		end while self.class.exists?(access_token: access_token)
	end
end

