class Etapa < ActiveRecord::Base
    has_many :ideas
    
    validates :nombre, presence: true
    resourcify
end
