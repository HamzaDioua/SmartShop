# SmartShop – TP Mobile Complet

## 📌 Objectif général
Ce TP consiste à **concevoir l’interface graphique d’une mini-application mobile SmartShop** avec Flutter, composée de **trois écrans principaux** :  
1. **Page d’accueil** – Liste de produits  
2. **Page de détails** – Affichage d’un produit sélectionné  
3. **Page profil** – Affichage d’informations utilisateur  

L’objectif est de mettre en œuvre la **navigation entre plusieurs interfaces**, gérer la communication entre les écrans et ajouter de l’interactivité (boutons, états, passage de paramètres).

---

## 🚀 Fonctionnalités développées
Ce TP poursuit le développement de l’application **SmartShop** réalisé lors du TP2 et ajoute les fonctionnalités suivantes :

- **SharedPreferences** : stocker les préférences de l’utilisateur  
- **SQLite** : gérer une liste persistante de favoris  
- **JSON** : charger les produits depuis un fichier JSON au lieu d’une liste écrite en dur  
- **API REST** : gestion des requêtes `GET`, `POST`, `PUT`, `DELETE` pour les produits et utilisateurs  

---

## 🛠️ Technologies utilisées
- **Frontend** : Flutter  
- **Backend** : Node.js + Express.js (API REST)  
- **Base de données** : SQLite (mobile), Oracle / MySQL (backend)  
- **Langages** : Dart, JavaScript  
- **Gestion API** : REST (CRUD)  

---

## 🖥️ Organisation du projet
- `lib/` → Code Flutter (frontend)  
- `backend/` → API Node.js + Express  
- `assets/` → Images et fichiers JSON  
- `README.md` → Ce fichier  

---

## 💻 Instructions pour lancer le projet

### Frontend Flutter
```bash
cd lib
flutter pub get
flutter run
