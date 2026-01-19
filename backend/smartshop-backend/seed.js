require('dotenv').config();
const sequelize = require('./config/database');
const Product = require('./models/Product');

// Données de test (fake products)
const fakeProducts = [
  {
    name: "iPhone 15 Pro",
    price: 999.99,
    imagePath: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium.jpg",
    desc: "Le dernier iPhone avec puce A17 Pro et caméra 48MP",
    category: "Electronics"
  },
  {
    name: "Samsung Galaxy S24",
    price: 899.99,
    imagePath: "https://images.samsung.com/is/image/samsung/p6pim/levant/2401/gallery/levant-galaxy-s24-s928-sm-s928blbemea-thumb-539573503",
    desc: "Smartphone premium avec écran AMOLED 120Hz",
    category: "Electronics"
  },
  {
    name: "MacBook Pro M3",
    price: 1999.99,
    imagePath: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-select-202310.jpg",
    desc: "Ordinateur portable professionnel avec puce M3",
    category: "Electronics"
  },
  {
    name: "Sony WH-1000XM5",
    price: 349.99,
    imagePath: "https://m.media-amazon.com/images/I/61vEu+ypsEL._AC_SL1500_.jpg",
    desc: "Casque sans fil avec réduction de bruit active",
    category: "Audio"
  },
  {
    name: "Apple Watch Series 9",
    price: 429.99,
    imagePath: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/watch-card-40-s9-202309.jpg",
    desc: "Montre connectée avec capteur de santé avancé",
    category: "Wearables"
  },
  {
    name: "iPad Air",
    price: 599.99,
    imagePath: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-air-select-wifi-blue-202203.jpg",
    desc: "Tablette légère et puissante avec puce M1",
    category: "Tablets"
  },
  {
    name: "Nintendo Switch OLED",
    price: 349.99,
    imagePath: "https://assets.nintendo.com/image/upload/f_auto/q_auto/dpr_2.0/c_scale,w_600/ncom/en_US/switch/site-design-update/hardware/switch-oled",
    desc: "Console de jeu hybride avec écran OLED",
    category: "Gaming"
  },
  {
    name: "Dell XPS 13",
    price: 1299.99,
    imagePath: "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/xps-notebooks/xps-13-9340/media-gallery/gray/notebook-xps-13-9340-gray-gallery-1.psd",
    desc: "Ultrabook compact avec écran InfinityEdge",
    category: "Computers"
  },
  {
    name: "Logitech MX Master 3S",
    price: 99.99,
    imagePath: "https://resource.logitechg.com/w_692,c_lpad,ar_4:3,q_auto,f_auto,dpr_1.0/d_transparent.gif/content/dam/gaming/en/products/mx-master-3s/gallery/mx-master-3s-gallery-graphite-1.png",
    desc: "Souris sans fil ergonomique pour professionnels",
    category: "Accessories"
  },
  {
    name: "Samsung 4K Smart TV 55\"",
    price: 799.99,
    imagePath: "https://images.samsung.com/is/image/samsung/p6pim/levant/ua55cu7000uxum/gallery/levant-crystal-uhd-cu7000-ua55cu7000uxum-thumb-537362433",
    desc: "TV 4K Ultra HD avec Tizen OS",
    category: "TV & Home Theater"
  },
  {
    name: "Canon EOS R6",
    price: 2499.99,
    imagePath: "https://i1.adis.ws/i/canon/eos-r6-rf24-105mm-f4-l-is-usm-front-on_01_425b02f89ca5407fb981ad0c5fa79f71",
    desc: "Appareil photo hybride plein format 20MP",
    category: "Cameras"
  },
  {
    name: "DJI Mini 3 Pro",
    price: 759.99,
    imagePath: "https://dji-official-fe.djicdn.com/dps/6e41e58b9ecd4c3e1f96f89e0cc6c2e7.jpg",
    desc: "Drone compact avec caméra 4K et 34 min de vol",
    category: "Drones"
  },
  {
    name: "Bose SoundLink Revolve+",
    price: 299.99,
    imagePath: "https://assets.bose.com/content/dam/cloudassets/Bose_DAM/Web/consumer_electronics/global/products/speakers/soundlink_revolve_plus_ii/product_silo_images/SLR_II_PDP_Ecom-Gallery-B01.png",
    desc: "Enceinte Bluetooth portable 360° waterproof",
    category: "Audio"
  },
  {
    name: "Kindle Paperwhite",
    price: 139.99,
    imagePath: "https://m.media-amazon.com/images/I/51QCk82iGcL._AC_SL1000_.jpg",
    desc: "Liseuse numérique avec écran haute résolution",
    category: "E-readers"
  },
  {
    name: "Dyson V15 Detect",
    price: 649.99,
    imagePath: "https://dyson-h.assetsadobe2.com/is/image/content/dam/dyson/leap-product-imagery/442/v15/gold/442-primary-gold.png",
    desc: "Aspirateur sans fil avec détection laser",
    category: "Home Appliances"
  }
];

// Fonction pour seed la base de données
const seedDatabase = async () => {
  try {
    console.log('🌱 Démarrage du seed...');

    // Supprimer toutes les données existantes
    await Product.destroy({ where: {}, truncate: true });
    console.log('🗑️  Anciennes données supprimées');

    // Insérer les nouvelles données
    await Product.bulkCreate(fakeProducts);
    console.log(`✅ ${fakeProducts.length} produits insérés avec succès !`);

    // Afficher quelques exemples
    const products = await Product.findAll({ limit: 5 });
    console.log('\n📦 Exemples de produits créés:');
    products.forEach(product => {
      console.log(`   - ${product.name} (${product.price}€) - ${product.category}`);
    });

    console.log('\n✨ Seed terminé avec succès !');
    process.exit(0);
  } catch (error) {
    console.error('❌ Erreur lors du seed:', error);
    process.exit(1);
  }
};

// Exécuter le seed
seedDatabase();
