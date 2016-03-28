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

Subsecretaria.create(nombre: "Anon")

Direccion.create(nombre: "Anon", subsecretaria: Subsecretaria.find(1))

Persona.create(nombre: "Anon", email: "anon@anon.com", direccion: Direccion.find(1), password: 12345678)

Categoria.create(nombre: "Comida/Bebida")
Categoria.create(nombre: "Capacitaciones")
Categoria.create(nombre: "Recreación")
Categoria.create(nombre: "Edificio")
Categoria.create(nombre: "Comunicación")
Categoria.create(nombre: "Beneficios")
Categoria.create(nombre: "Insumos")

Idea.create(texto: "Quisiera una máquina de café gratis", persona: Persona.find(1), categoria: Categoria.find(1))


