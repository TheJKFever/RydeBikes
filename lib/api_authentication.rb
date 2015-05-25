module ApiAuthentication
  	def self.included(base)
    	# base.before_filter :authenticate_apiKey
  	end

	def authenticate_apiKey
	  	api_key = ApiKey.where(access_token: request.headers['X-Api-Key']).first if request.headers['X-Api-Key']
	  	@user = api_key.user if api_key
	 
	  	unless @user
		    head status: :unauthorized
			return false
	  	end
	end
end