class Direccion < ActiveRecord::Base
  belongs_to :subsecretaria
  has_many :personas
end
