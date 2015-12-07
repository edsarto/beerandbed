class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :bookings,     foreign_key: 'client_id', dependent: :destroy
  has_many :beds,  foreign_key: 'owner_id',  dependent: :destroy

  has_one :address
  has_one :score

  has_many :credit_cards, dependent: :destroy

  validates_presence_of :first_name, :last_name

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  has_attached_file :insurance,
    styles: { large: "1000x1000", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :insurance,
    content_type: /\Aimage\/.*\z/

  process_in_background :picture
  process_in_background :insurance

  after_create :send_welcome_email

  def self.find_for_facebook_oauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    return user if user

    user = new(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0,20],
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      token: auth.credentials.token,
      token_expiry: Time.at(auth.credentials.expires_at)
    )

    user.picture = auth.info.image.gsub('http', 'https') if auth.info.image
    user.save

    user
  end

  def update_mangopay_profile
    params = {
      "Email" => self.email,
      "FirstName" => self.first_name,
      "LastName" => self.last_name,
      "Birthday" => 467909843,
      "Nationality" => "FR",
      "CountryOfResidence" => "FR"
    }

    begin
      if self.mangopay_user_id
        response = MangoPay::NaturalUser.update(self.mangopay_user_id, params)
        puts 'update'
      else
        response = MangoPay::NaturalUser.create(params)
        puts 'create'
      end
    rescue MangoPay::ResponseError => e
    end

    self.mangopay_user_id = response["Id"]
    self.save
  end

  def create_or_update_wallet
    self.update_mangopay_profile

    params = {
      "Owners" => ["#{self.mangopay_user_id}"],
      "Description" => "airgabion Wallet #{self.email}",
      "Currency" => "EUR"
    }

    begin
      if self.mangopay_wallet_id
        response = MangoPay::Wallet.update(self.mangopay_wallet_id, params)
      else
        response = MangoPay::Wallet.create(params)
      end
    rescue MangoPay::ResponseError => e
    end

    self.mangopay_wallet_id = response["Id"]
    self.save
  end


protected

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end
end
