class Idea < ActiveRecord::Base
  belongs_to :persona
  belongs_to :categoria
  acts_as_voteable
  validates :texto, presence: true
end
