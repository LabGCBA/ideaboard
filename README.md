# ideaboard
Internal idea board

## Installing
Después de correr `$ bundle install` ejecutar:
```
$ rake db:create
$ rake db:migrate
```
Luego:
```
$ rake commontator:install
$ rake acts_as_taggable_on_engine:tag_names:collate_bin
$ rails generate semantic_ui:install
```
Para terminar de instalar las gemas, `commontator`, `act-as-taggable-on` y `less-rails-semantic_ui`.
Y finalmente otra vez:
```
$ rake db:migrate
$ rake db:seed
```