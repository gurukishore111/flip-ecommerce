const express = require('express');
const { auth } = require('../middleware/auth');
const { Product } = require('../models/product');
const productRouter = express.Router();

// get all your products
productRouter.get('/:category', auth, async (req, res) => {
  console.log({ req: req.params.category });
  try {
    let product = await Product.find({ category: req.params.category });
    res.json(product);
  } catch (error) {
    res.status(500).json({
      error: error?.message
        ? error.message
        : 'Something went wrong while creating the account',
    });
  }
});

// get all your products
productRouter.get('/search/:query', auth, async (req, res) => {
  const keyword = req.params.query
    ? {
        name: {
          $regex: req.params.query,
          $options: 'i',
        },
      }
    : {};

  try {
    let product = await Product.find({ ...keyword });
    res.json(product);
  } catch (error) {
    res.status(500).json({
      error: error?.message
        ? error.message
        : 'Something went wrong while creating the account',
    });
  }
});

// delete by id

module.exports = productRouter;
