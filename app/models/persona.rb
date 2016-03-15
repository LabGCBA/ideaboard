class Persona < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ideas, dependent: :destroy
  belongs_to :direccion
  attr_accessible :nombre, :email, :direccion, :password, :identity_url
  acts_as_voter
end
