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
ideas = 30

subsecretarias.times do |i|
  Subsecretaria.create(nombre: "Subsecretaría #{i + 1}")
end

direcciones.times do |i|
  Direccion.create(nombre: "Dirección #{i + 1}", subsecretaria: Subsecretaria.find(1 + rand(subsecretarias)))
end

Persona.create(nombre: "Juan Pérez", email: "juan@perez.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Martín Fernández", email: "martin@fernandez.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Miguel Gómez", email: "miguel@gomez.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Fernando González", email: "fernando@gonzalez.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Esteban Martínez", email: "esteban@martinez.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Hannah Montana", email: "hannah@montana.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Laurel Lance", email: "laurel@lance.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Felicity Smoak", email: "felicity@smoak.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Iris West", email: "iris@west.com", direccion: Direccion.find(1 + rand(direcciones)))
Persona.create(nombre: "Barry Allen", email: "barry@allen.com", direccion: Direccion.find(1 + rand(direcciones)))

personas = Persona.count

ideas.times do |i|
  Idea.create(texto: "En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero, adarga antigua, rocín flaco y galgo corredor #{i + 1}", persona: Persona.find(1 + rand(personas)))
end
