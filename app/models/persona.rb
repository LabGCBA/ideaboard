class Persona < ActiveRecord::Base
  has_many :ideas, dependent: :destroy
  belongs_to :direccion
end
