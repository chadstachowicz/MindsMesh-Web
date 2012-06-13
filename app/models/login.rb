class Login < ActiveRecord::Base
  belongs_to :user
  attr_accessible :auth_s, :permissions_s, :provider, :uid

  def self.auth!(auth)
    raise "invalid facebook login" if auth.nil?
    login = Login.find_or_initialize_by_provider_and_uid(auth["provider"], auth["uid"].to_s)

    login.auth_s = auth.to_json
    #login.permissions = "email"
    if login.new_record?
      user = login.build_user
      user.name      = auth["info"]["name"]
      user.photo_url = auth["info"]["image"]
    end
    login.save!
    login
  end
end
