const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

// Définition du modèle Product
const Product = sequelize.define('Product', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING(255),
    allowNull: false,
    validate: {
      notEmpty: {
        msg: 'Le nom du produit ne peut pas être vide'
      }
    }
  },
  price: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
    validate: {
      isDecimal: {
        msg: 'Le prix doit être un nombre décimal'
      },
      min: {
        args: [0],
        msg: 'Le prix doit être positif'
      }
    }
  },
  imagePath: {
    type: DataTypes.TEXT,
    allowNull: true
  },
  desc: {
    type: DataTypes.TEXT,
    allowNull: true
  },
  category: {
    type: DataTypes.STRING(100),
    allowNull: true
  }
}, {
  tableName: 'Products',
  timestamps: true, // Ajoute createdAt et updatedAt
});

module.exports = Product;
