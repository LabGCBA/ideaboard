class Estado < ActiveRecord::Base
  belongs_to :idea
  belongs_to :persona
  
  def as_json(options={})
    super(:only => [:texto, :created_at],
            :include => {
            :persona => {:only => [:nombre]},
            })
  end
end
