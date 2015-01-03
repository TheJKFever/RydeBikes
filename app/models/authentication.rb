class Authentication < ActiveRecord::Base
  # attr_accessible :provider, :token, :uid, :user_id
  # TODO: turn into strong params
  belongs_to :user
end