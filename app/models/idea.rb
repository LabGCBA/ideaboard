class Idea < ActiveRecord::Base
  belongs_to :persona
  belongs_to :categoria
  has_many :estados
  has_many :comentarios
  acts_as_voteable
  validates :texto, presence: true
end
