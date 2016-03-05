# ideaboard
Internal idea board

## Installing
Después de correr `$ bundle install` ejecutar:
```
$ rake db:migrate
```
Para seedear la base de datos.
Luego:
```
$ rake db:migrate
$ rake commontator:install
$ rake acts_as_taggable_on_engine:tag_names:collate_bin
```
Para terminar de instalar las gemas `commontator` y `act-as-taggable-on`.
Y finalmente otra vez:
```
$ rake db:migrate
```