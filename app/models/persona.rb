class Persona < ActiveRecord::Base
  has_many :ideas, dependent: :destroy
  belongs_to :direccion
  attr_accessible :identity_url
end
