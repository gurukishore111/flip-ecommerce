const express = require('express');
const { admin } = require('../middleware/admin');
const { Product } = require('../models/product');
const { Order } = require('../models/order');

const adminRouter = express.Router();

// add the new product
adminRouter.post('/add-product', admin, async (req, res) => {
  try {
    const { name, description, quantity, images, category, price } = req.body;
    let product = new Product({
      name,
      description,
      quantity,
      images,
      category,
      price,
    });
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

// get all your products
adminRouter.get('/products', admin, async (req, res) => {
  try {
    let product = await Product.find({});
    res.json(product);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

// delete by id
adminRouter.delete('/product/:id', admin, async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);
    if (product) {
      await product.remove();
      res.json({ msg: 'Product removed' });
    } else {
      res.status(404).json({ msg: 'Product not found' });
    }
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

adminRouter.get('/orders', admin, async (req, res) => {
  try {
    let order = await Order.find({});
    res.json(order);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

adminRouter.post('/change-order-status', admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get('/analytics', admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    // CATEGORY WISE ORDER FETCHING
    let mobileEarnings = await fetchCategoryWiseProduct('Mobiles');
    let essentialEarnings = await fetchCategoryWiseProduct('Essentials');
    let applianceEarnings = await fetchCategoryWiseProduct('Appliances');
    let booksEarnings = await fetchCategoryWiseProduct('Books');
    let fashionEarnings = await fetchCategoryWiseProduct('Fashion');

    let earnings = {
      totalEarnings,
      mobileEarnings,
      essentialEarnings,
      applianceEarnings,
      booksEarnings,
      fashionEarnings,
    };

    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    'products.product.category': category,
  });

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = adminRouter;
