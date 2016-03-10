class Persona < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ideas, dependent: :destroy
  belongs_to :direccion
<<<<<<< HEAD
  attr_accessible :nombre, :email, :direccion, :password, :identity_url
=======
>>>>>>> 8b97590496aab964466aa19c581a869132544870
  acts_as_voter
end
