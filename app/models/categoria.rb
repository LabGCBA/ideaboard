class Categoria < ActiveRecord::Base
  has_many :ideas
  self.table_name = :categorias
end
