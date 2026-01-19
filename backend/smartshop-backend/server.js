require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const sequelize = require('./config/database');
const productRoutes = require('./routes/productRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors()); // Autoriser les requêtes cross-origin (important pour Flutter)
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Route de test
app.get('/', (req, res) => {
  res.json({
    message: '🚀 Bienvenue sur SmartShop API',
    version: '1.0.0',
    endpoints: {
      products: '/api/products',
      health: '/health'
    }
  });
});

// Route de santé
app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    timestamp: new Date().toISOString()
  });
});

// Routes API
app.use('/api', productRoutes);

// Gestion des routes non trouvées
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Route non trouvée'
  });
});

// Gestion des erreurs globales
app.use((error, req, res, next) => {
  console.error('Erreur globale:', error);
  res.status(500).json({
    success: false,
    message: 'Erreur interne du serveur',
    error: error.message
  });
});

// Synchroniser la base de données et démarrer le serveur
const startServer = async () => {
  try {
    // Synchroniser les modèles avec la base de données
    await sequelize.sync({ alter: false }); // alter: true pour mettre à jour automatiquement
    console.log('✅ Base de données synchronisée');

    // Démarrer le serveur
    app.listen(PORT, () => {
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      console.log(`🚀 Serveur SmartShop API lancé avec succès !`);
      console.log(`📡 URL: http://localhost:${PORT}`);
      console.log(`📝 Documentation: http://localhost:${PORT}/`);
      console.log(`💚 Santé: http://localhost:${PORT}/health`);
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    });
  } catch (error) {
    console.error('❌ Erreur lors du démarrage du serveur:', error);
    process.exit(1);
  }
};

startServer();

module.exports = app;
