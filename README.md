# Project release SupFamily for 3APL course

Projet SUPINFO réalisé par :
- Axel KIMMEL (295114)
- Robin PIERRAT (293042)
- Clément TEYSSANDIER (292621)

Pour lancer le projet, il suffit de télécharger le projet, l'extraire, puis lancer le fichier ``SupFamily.xcworkspace``.

-----------------

### Liste des fonctionnalités

- Login/Logout
- Mise à jour de la position toutes les minutes
- Liste des membres venant de l'API et de la base de données
- Ajouter/Supprimer des membres
- Les données sont sauvegardées dans une base de données
- Vérification de la connection à internet
- Affichage sur Google Map

-----------------

### Fonctionnalités détaillées


- Login/Logout

Pour se connecter à l'application, il suffit de renseigner ses identifiants, donc dans ce cas avec 
comme identifiant ``admin``, et comme mot de passe ``admin.

L'application se connecte à internet (à l'API), pour vérifier les informations rentrées. 
Si elles sont correctes l'application redirige l'utilisteur vers la page principale.

```insérer screen login```

Pour se déconnecter, ``..........``

Cela ferme la connection à la base de données, coupe l'actualisation de l'emplacement de l'utilisateur 
et le redirige ver la page de connection.

```insérer screen du bouton déconnecter```

- Mise à jour de la position toutes les minutes

Une fois connecté, l'application demande à l'utilisateur s'il l'autorise à utiliser sa position,
si c'est le cas, l'application envoie automatiquement la position de l'utilisateur à l'API
et la sauvegarde dans la base de données. La méthode est lancée dans le ``ViewController``.

- Liste des membres venant de l'API et de la base de données

Une fois connecté, ``...``
refrech ``...``


- Ajouter/Supprimer des membres

Une fois connecté, il est possible de supprimer des membres suivis en cliquant sur le bouton à 
coté de son nom ``insérer screen ligne membre à supprimer``. 

Une fois ceci fait, le membre est supprimé dans l'API, ainsi que dans la base de données.

Il est également possible d'ajouter des membres, en cliquant sur le bouton dans la barre inférieure.
L'utilisateur est invité à renseigner les informations du membre à ajouter. Une fois ceci fait,
le membre est ajouté dans l'API et dans la base de données. ``insérer screen ajout membre``

- Les données sont sauvegardées dans une base de données

Lors de la première connection à l'application, une base de données et les différentes tables sont créées. 
Les données de l'utilisateur et de ses membres, sont ajoutées à cette base de données.

Lors des différentes actions, tel que l'ajout ou la suppression d'un membre, la mise à jour de la position
de l'utilisateur ou d'un membre, les changements sont enregistrés dans une base de données SQLite.

- Vérification de la connection à internet

```.......```

- Affichage sur Google Map

Il est possible de voir la position de l'utilisateur, ainsi que celle des membres de sa famille sur 
une carte Google Map, sous forme de points rouge, indiquant le nom et le prénom de la personne.
``insérer screen map affichage``
