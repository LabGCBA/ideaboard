class Estado < ActiveRecord::Base
  belongs_to :idea
  belongs_to :persona
end
