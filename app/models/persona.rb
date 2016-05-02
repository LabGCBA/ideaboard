class Persona < ActiveRecord::Base
  rolify
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable
  
  has_many :ideas, dependent: :destroy
  has_many :estados
  has_many :comentarios
  belongs_to :direccion

  # attr_accessible :nombre, :email, :direccion, :password, :identity_url
  
  validates :email, uniqueness: true, presence: true
  after_create { add_role :usuario if self.roles.blank? }
  
  def self.from_omniauth(auth, signed_in_resource=nil)
      persona = Persona.where(uid: auth.uid).first
      Rails.logger.debug("### Trying to fetch person by uid: #{auth.uid}")
      
      if persona
          return persona
      else
          persona = Persona.where(email: auth.info.email).first
          Rails.logger.debug("### Trying to fetch person by email: #{auth.info.email}")
          
          if persona
              return persona
          else
              Persona.create(
                  name: auth.extra.raw_info.name,
                  provider: auth.provider,
                  uid: auth.uid,
                  email: auth.info.email,
                  password: Devise.friendly_token[0,20]
              )
          end
      end
  end
  
  def nombre_apellido
      self.nombre.to_s + " " + self.apellido.to_s
  end
end
