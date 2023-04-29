# RocketDeliveryBackend

## Installation

### Prerequisites
-  Ruby 3.1.x

### Setup
-  Clone the repository
-  Run `bundle install`
-  Run `rails db:create`
-  Run `rails db:migrate`
-  Run `rails db:seed`
-  Run `rails s`

### Create a .env file in the root directory and add the following variables
TWILIO_ACCOUNT_SID=
TWILIO_AUTH_TOKEN=
NOTIFY_API_KEY=
NOTIFY_X_ClientId=
NOTIFY_X_Secretkey=
NOTIFY_X_EMAIL_FROM=



# Documents de recherche

## Base de données relationnelles et SQL

### Qu'est-ce que SQL ?
- SQL (Structured Query Language) est un langage de requête structuré, c'est-à-dire qu'il permet de manipuler des données dans une base de données relationnelle. Il permet de créer, modifier et supprimer des données dans une base de données relationnelle. Il permet également de récupérer des données dans une base de données relationnelle. C'est un language dit déclaratif ce qui veut dire que  l'on décrit le résultat souhaité sans spécifier de quelle façon l'obtenir.

### Quelle est la principale différence entre SQLite et MySQL?
- SQLite stocke les données dans un fichier. MySQL stocke les données dans un serveur. SQLite est donc plus simple à mettre en place et à utiliser que MySQL. SQLite est plus adapté pour des applications mobiles ou web simples. MySQL, quand à lui, est plus adapté pour des applications web plus complexes.

### Quels sont les clés primaires et étrangères?
- Une clé primaire est une colonne ou un ensemble de colonnes qui identifie de manière unique une ligne dans une table. Une clé étrangère est une colonne ou un ensemble de colonnes qui identifie de manière unique une ligne dans une autre table. Une clé étrangère est une clé primaire d'une autre table. Example: la clé primaire de la table `users` est `id`. La clé étrangère de la table `customer` est `user_id`.

### Quels sont les différents types de relations qui peuvent être trouvés dans une base de données relationnelle ? Donnez un exemple pour chaque type.
- Les relations sont les liens qui existent entre les tables. Il existe 3 types de relations: les relations (1-1), les relations (1-n) et les relations (n-n). 
- Les relations 1-1 sont des relations où une ligne de la table A est reliée à une et une seule ligne de la table B. 
ex: la table `users` a une relation 1-1 avec la table `customers` car un utilisateur peut être un client mais un client n'est pas forcément un utilisateur.
- Les relations 1-n sont des relations où une ligne de la table A est reliée à plusieurs lignes de la table B. 
ex: la table `users` a une relation 1-n avec la table `orders` car un utilisateur peut passer plusieurs commandes mais une commande ne peut être passée que par un utilisateur.
- Les relations n-n sont des relations où plusieurs lignes de la table A sont reliées à plusieurs lignes de la table B.
ex: la table `products` a une relation n-n avec la table `orders` car un produit peut être commandé plusieurs fois et une commande peut contenir plusieurs produits.

## CONSTRUCTION DE LA BASE DE DONNÉES

### Identifiez une paire de tables qui ont une relation de plusieurs à un. Expliquez pourquoi elles ont une telle relation.
- La table `orders` et la table `users` ont une relation de plusieurs à un car une commande peut être passée par un seul utilisateur mais un utilisateur peut passer plusieurs commandes.

### Identifiez une paire de tables qui ont une relation de un à un. Expliquez pourquoi elles ont une telle relation.
- La table `users` et la table `customers` ont une relation de un à un car un utilisateur peut être un client mais un client n'est pas forcément un utilisateur.

### Identifiez une relation de plusieurs à plusieurs dans le diagramme. Quelles tables sont impliquées et pourquoi?
- La table `products` et la table `orders` ont une relation de plusieurs à plusieurs car un produit peut être commandé plusieurs fois et une commande peut contenir plusieurs produits.




 
