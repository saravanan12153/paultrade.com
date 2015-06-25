class User < ActiveRecord::Base
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  after_create :send_welcome
  after_create :subscribe

  has_many :subscribers, dependent: :destroy
  has_many :posts, through: :subscribers
  has_many :comments, dependent: :destroy
  validates_presence_of :name

  def subscribe

    @list_id = ENV['MAILCHIMP_LIST_ID']
    gb = Gibbon::API.new

    gb.lists.subscribe({
                           :id => @list_id,
                           :email => {:email => self.email},
                           :merge_vars => {:FNAME => self.name}
                       })

  end

  def send_welcome
    MyMailer.new_user(self).deliver
  end

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
