## RAILS CRUD

L'une des particularités de Rails est le fait que nous pouvons générer à la fois des contrôleurs et des modèles qui inclut les spécificités + type de données des colonnes.

Nous avons auparavant créer des tableaux sur ActiveRecord ainsi que leurs timestamps

Exemple : 
```bash
 rake db:timestamps
```


```bash
rails generate model Restaurant name:string rating:integer
  invoke  active_record
      create    db/migrate/20211025184841_create_restaurants.rb
      create    app/models/restaurant.rb
      invoke    test_unit
      create      test/models/restaurant_test.rb
      create      test/fixtures/restaurants.yml
```


Migration 

```bash
 rails db:migrate
```
