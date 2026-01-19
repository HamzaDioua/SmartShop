const Product = require('../models/Product');

// Créer un nouveau produit
exports.createProduct = async (req, res) => {
  try {
    const { name, price, imagePath, desc, category } = req.body;

    // Validation des champs obligatoires
    if (!name || !price) {
      return res.status(400).json({
        success: false,
        message: 'Le nom et le prix sont obligatoires'
      });
    }

    const product = await Product.create({
      name,
      price,
      imagePath,
      desc,
      category
    });

    res.status(201).json({
      success: true,
      message: 'Produit créé avec succès',
      data: product
    });
  } catch (error) {
    console.error('Erreur lors de la création du produit:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la création du produit',
      error: error.message
    });
  }
};

// Récupérer tous les produits
exports.getAllProducts = async (req, res) => {
  try {
    const products = await Product.findAll({
      order: [['createdAt', 'DESC']]
    });

    res.status(200).json({
      success: true,
      count: products.length,
      data: products
    });
  } catch (error) {
    console.error('Erreur lors de la récupération des produits:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des produits',
      error: error.message
    });
  }
};

// Récupérer un produit par ID
exports.getProductById = async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findByPk(id);

    if (!product) {
      return res.status(404).json({
        success: false,
        message: `Produit avec l'ID ${id} non trouvé`
      });
    }

    res.status(200).json({
      success: true,
      data: product
    });
  } catch (error) {
    console.error('Erreur lors de la récupération du produit:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération du produit',
      error: error.message
    });
  }
};

// Mettre à jour un produit
exports.updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, price, imagePath, desc, category } = req.body;

    const product = await Product.findByPk(id);

    if (!product) {
      return res.status(404).json({
        success: false,
        message: `Produit avec l'ID ${id} non trouvé`
      });
    }

    // Mettre à jour seulement les champs fournis
    if (name !== undefined) product.name = name;
    if (price !== undefined) product.price = price;
    if (imagePath !== undefined) product.imagePath = imagePath;
    if (desc !== undefined) product.desc = desc;
    if (category !== undefined) product.category = category;

    await product.save();

    res.status(200).json({
      success: true,
      message: 'Produit mis à jour avec succès',
      data: product
    });
  } catch (error) {
    console.error('Erreur lors de la mise à jour du produit:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la mise à jour du produit',
      error: error.message
    });
  }
};

// Supprimer un produit
exports.deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findByPk(id);

    if (!product) {
      return res.status(404).json({
        success: false,
        message: `Produit avec l'ID ${id} non trouvé`
      });
    }

    await product.destroy();

    res.status(200).json({
      success: true,
      message: 'Produit supprimé avec succès'
    });
  } catch (error) {
    console.error('Erreur lors de la suppression du produit:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la suppression du produit',
      error: error.message
    });
  }
};
