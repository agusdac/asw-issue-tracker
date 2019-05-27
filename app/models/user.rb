class User < ActiveRecord::Base
  has_many :issues
  has_many :assigned_issues, class_name: 'Issue'
   has_many :votes, dependent: :destroy
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.imageurl = auth.info.image
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.uid
      user.uid = auth.uid
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  has_many :comments, dependent: :destroy
  has_many :watches, dependent: :destroy
end
