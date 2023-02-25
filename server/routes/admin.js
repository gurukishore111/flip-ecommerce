const express = require('express');
const { admin } = require('../middleware/admin');
const { Product } = require('../models/product');
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

module.exports = adminRouter;
