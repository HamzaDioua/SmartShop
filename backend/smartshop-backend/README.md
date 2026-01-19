# 🛍️ SmartShop API

API REST pour l'application mobile SmartShop développée avec Node.js, Express et MySQL.

## 📋 Prérequis

- **Node.js** (version 14 ou supérieure)
- **MySQL** (version 5.7 ou supérieure)
- **npm** ou **yarn**

## 🗄️ Configuration de la base de données MySQL

Ouvrez MySQL Workbench et exécutez les commandes suivantes :

```sql
-- 1. Créer la base de données
CREATE DATABASE smartshop;

-- 2. Créer un utilisateur dédié
CREATE USER 'smartshop_user'@'localhost' IDENTIFIED BY 'smartshop2003';

-- 3. Donner tous les privilèges sur la DB
GRANT ALL PRIVILEGES ON smartshop.* TO 'smartshop_user'@'localhost';

-- 4. Appliquer les changements
FLUSH PRIVILEGES;
```

## 🚀 Installation

```bash
# Installer les dépendances
npm install
```

## ⚙️ Configuration

Le fichier `.env` contient déjà la configuration par défaut :

```env
DB_HOST=localhost
DB_USER=smartshop_user
DB_PASSWORD=smartshop2003
DB_NAME=smartshop
DB_DIALECT=mysql
PORT=3000
```

## 🏃 Démarrage

```bash
# Démarrer le serveur
npm start

# OU en mode développement (avec rechargement automatique)
npm run dev
```

Le serveur démarre sur : **http://localhost:3000**

## 🌱 Seed des données

Pour remplir la base de données avec des produits de test :

```bash
npm run seed
```

⚠️ **Attention** : Cette commande supprime toutes les données existantes dans la table Products.

## 📡 Endpoints de l'API

### Base URL
```
http://localhost:3000/api
```

### 1. Créer un produit
- **Méthode** : `POST`
- **URL** : `/products`
- **Body (JSON)** :
```json
{
  "name": "iPhone 15 Pro",
  "price": 999.99,
  "imagePath": "https://example.com/image.jpg",
  "desc": "Description du produit",
  "category": "Electronics"
}
```
- **Réponse** :
```json
{
  "success": true,
  "message": "Produit créé avec succès",
  "data": { ... }
}
```

### 2. Récupérer tous les produits
- **Méthode** : `GET`
- **URL** : `/products`
- **Réponse** :
```json
{
  "success": true,
  "count": 15,
  "data": [ ... ]
}
```

### 3. Récupérer un produit par ID
- **Méthode** : `GET`
- **URL** : `/products/:id`
- **Exemple** : `/products/1`
- **Réponse** :
```json
{
  "success": true,
  "data": { ... }
}
```

### 4. Mettre à jour un produit
- **Méthode** : `PUT`
- **URL** : `/products/:id`
- **Body (JSON)** : (inclure uniquement les champs à modifier)
```json
{
  "price": 899.99,
  "desc": "Description mise à jour"
}
```
- **Réponse** :
```json
{
  "success": true,
  "message": "Produit mis à jour avec succès",
  "data": { ... }
}
```

### 5. Supprimer un produit
- **Méthode** : `DELETE`
- **URL** : `/products/:id`
- **Réponse** :
```json
{
  "success": true,
  "message": "Produit supprimé avec succès"
}
```

## 🧪 Tester l'API

### Avec cURL

```bash
# Récupérer tous les produits
curl http://localhost:3000/api/products

# Créer un produit
curl -X POST http://localhost:3000/api/products \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Product","price":99.99,"category":"Test"}'

# Récupérer un produit par ID
curl http://localhost:3000/api/products/1

# Mettre à jour un produit
curl -X PUT http://localhost:3000/api/products/1 \
  -H "Content-Type: application/json" \
  -d '{"price":79.99}'

# Supprimer un produit
curl -X DELETE http://localhost:3000/api/products/1
```

### Avec Postman

Importez la collection Postman fournie ou créez vos propres requêtes en utilisant les endpoints ci-dessus.

## 📁 Structure du projet

```
smartshop-backend/
├── config/
│   └── database.js          # Configuration de la connexion MySQL
├── controllers/
│   └── productController.js # Logique métier des produits
├── models/
│   └── Product.js           # Modèle Sequelize du produit
├── routes/
│   └── productRoutes.js     # Routes de l'API
├── .env                     # Variables d'environnement
├── package.json             # Dépendances et scripts
├── server.js                # Point d'entrée du serveur
├── seed.js                  # Script de seed des données
└── README.md                # Documentation
```

## 🛠️ Technologies utilisées

- **Node.js** - Runtime JavaScript
- **Express.js** - Framework web
- **Sequelize** - ORM pour MySQL
- **MySQL2** - Driver MySQL
- **CORS** - Gestion des requêtes cross-origin
- **dotenv** - Gestion des variables d'environnement
- **body-parser** - Parsing des requêtes HTTP

## 🔧 Dépannage

### Erreur de connexion MySQL
- Vérifiez que MySQL est démarré
- Vérifiez les credentials dans le fichier `.env`
- Assurez-vous que la base de données `smartshop` existe

### Port déjà utilisé
- Modifiez le PORT dans `.env`
- Ou arrêtez l'application utilisant le port 3000

### Erreur lors du seed
- Assurez-vous que le serveur n'est pas en cours d'exécution
- Vérifiez que la base de données est accessible

## 📝 Licence

ISC

## 👨‍💻 Auteur

Hamza
