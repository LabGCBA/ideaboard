class Comentario < ActiveRecord::Base
  belongs_to :idea
  belongs_to :persona
  resourcify
  
  def as_json(options={})
    super(:only => [:id, :texto, :created_at],
              :include => {
                  :persona => {:only => [:nombre, :apellido, :nombre_apellido]},
            })
  end
end
