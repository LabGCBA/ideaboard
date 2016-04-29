class Idea < ActiveRecord::Base
  belongs_to :persona
  belongs_to :categoria
  belongs_to :etapa
  has_many :estados
  has_many :comentarios
  
  validates :texto, presence: true
  
  acts_as_voteable
  resourcify
end
