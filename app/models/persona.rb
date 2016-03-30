class Persona < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ideas, dependent: :destroy
  has_many :estados
  has_many :comentarios
  belongs_to :direccion
  # attr_accessible :nombre, :email, :direccion, :password, :identity_url
  acts_as_voter
  validates :email, uniqueness: true, presence: true
  
  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.baid = auth.uid.to_s
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  end
end
