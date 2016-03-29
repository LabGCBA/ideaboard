# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require File.expand_path('../../app/models/subsecretaria', __FILE__)
require File.expand_path('../../app/models/direccion', __FILE__)
require File.expand_path('../../app/models/persona', __FILE__)
require File.expand_path('../../app/models/idea', __FILE__)

subsecretarias = 2
direcciones = 4
ideas = 5

subsecretarias.times do |i|
  Subsecretaria.create(nombre: "Subsecretaría #{i + 1}")
end

direcciones.times do |i|
  Direccion.create(nombre: "Dirección #{i + 1}", subsecretaria: Subsecretaria.find(1 + rand(subsecretarias)))
end

Persona.create(nombre: "Juan Pérez", email: "juan@perez.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Martín Fernández", email: "martin@fernandez.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Miguel Gómez", email: "miguel@gomez.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Fernando González", email: "fernando@gonzalez.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Esteban Martínez", email: "esteban@martinez.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Hannah Montana", email: "hannah@montana.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Laurel Lance", email: "laurel@lance.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Felicity Smoak", email: "felicity@smoak.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Iris West", email: "iris@west.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Barry Allen", email: "barry@allen.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678)
Persona.create(nombre: "Admin", email: "admin@mail.com", direccion: Direccion.find(1 + rand(direcciones)), password: 12345678, admin: true)

personas = Persona.count

Categoria.create(nombre: "Comida/Bebida")
Categoria.create(nombre: "Capacitaciones")
Categoria.create(nombre: "Recreación")
Categoria.create(nombre: "Edificio")
Categoria.create(nombre: "Comunicación")
Categoria.create(nombre: "Beneficios")
Categoria.create(nombre: "Insumos")

ideas.times do |i|
  Idea.create(texto: "Quisiera que haya dispensers de alcohol en gel", persona: Persona.find(1 + rand(personas).round), categoria: Categoria.find(4))
  Idea.create(texto: "Una parrilla en la terraza!", persona: Persona.find(1 + rand(personas).round), categoria: Categoria.find(4))
  Idea.create(texto: "Me gustaría que no falte detergente en la cocina.", persona: Persona.find(1 + rand(personas).round), categoria: Categoria.find(7))
  Idea.create(texto: "Free snacks!", persona: Persona.find(1 + rand(personas).round), categoria: Categoria.find(6))
  Idea.create(texto: "Estaría bueno que pongan un tele en el comedor...!", persona: Persona.find(1 + rand(personas).round), categoria: Categoria.find(4))
end

totalIdeas = Idea.count

totalIdeas.times do |i|
  Estado.create(texto: "Lo está viendo el Ministro.", idea: Idea.find(i + 1), persona: Persona.last)
  Comentario.create(texto: "Me encanta!", idea: Idea.find(i + 1), persona: Persona.find(1 + rand(personas).round))
  Comentario.create(texto: "A mí no tanto.", idea: Idea.find(i + 1), persona: Persona.find(1 + rand(personas).round))
  Comentario.create(texto: "Podría ser, pero preferiría que se prioricen otras cosas.", idea: Idea.find(i + 1), persona: Persona.find(1 + rand(personas).round))
end
