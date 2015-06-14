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

  	def validates_has_payment_and_good_standing
    	puts "validates_has_payment_and_good_standing received: " + @user.name.to_s
    	if @user.status != User.status[:goodstanding]
    		return render json: { error: "Users's status is: #{user.status}. Please contact us to resolve this issue" }, status: 401
    	end
		if @user.braintree_token.nil?
    		return render json: { error: 'User has not added a payment method. Please add a valid payment method.' }, status: 401
    	end
	    begin
	      @customer = Braintree::Customer.find(@user.braintree_token)
	      # Check if customer has any payment_method
	      if @customer.payment_methods.empty?
	      	return render json: { error: 'Braintree customer account created, but no payment added. Please add a valid payment method.'}, status: 401
	      end
	    rescue Braintree::NotFoundError
	      return render json: { error: 'User has not added a payment method. Please add a valid payment method.' }, status: 401
	    end
	end

	def get_default_payment_method
		begin
			@customer = Braintree::Customer.find(@user.braintree_token)
			# get default payment_method of customer
			@customer.payment_methods.each do |payment|
				return payment if payment.default?
			end
		rescure Braintree::NotFoundError
	      	return render json: { error: 'User has not added a payment method. Please add a valid payment method.' }, status: 401
	    end
	end
end