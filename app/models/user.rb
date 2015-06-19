class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :subscribers, dependent: :destroy
  has_many :posts, through: :subscribers
  has_many :comments, dependent: :destroy
  validates_presence_of :name

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider =>  access_token.provider, :uid => access_token.uid).first

    if user
      return user
    else
      registered_user = User.where(:email => data.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
            name: access_token.extra.raw_info.name,
            provider: access_token.provider,
            email: data.email,
            uid: access_token.uid,
            image: data.image,
            password: Devise.friendly_token[0,20]
        )
      end
    end
  end

end
