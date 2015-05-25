class Api::ApiController < ApplicationController
	include ApiAuthentication
	skip_before_filter :verify_authenticity_token
	before_filter :set_headers
  	before_filter :authenticate_apiKey

	# TODO: Remove this, not sure of repercusions
	def set_headers
    	headers['Access-Control-Allow-Origin'] = '*'
    	headers['Access-Control-Expose-Headers'] = 'ETag'
    	headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    	headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    	headers['Access-Control-Max-Age'] = '86400'
	end  
end