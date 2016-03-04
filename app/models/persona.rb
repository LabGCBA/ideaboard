class Persona < ActiveRecord::Base
  has_many :ideas
  belongs_to :direccion
end
