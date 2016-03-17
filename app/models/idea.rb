class Idea < ActiveRecord::Base
  belongs_to :persona
  acts_as_voteable
  validates :texto, presence: true
end
