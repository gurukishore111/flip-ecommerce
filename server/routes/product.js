const express = require('express');
const { auth } = require('../middleware/auth');
const { Product } = require('../models/product');
const productRouter = express.Router();
const { User } = require('../models/user');

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

productRouter.post('/rating', auth, async (req, res) => {
  try {
    const { id, rating, review } = req.body;
    let product = await Product.findById(id);
    for (let index = 0; index < product.ratings.length; index++) {
      const ratingObj = product.ratings[index];
      console.log({ userId: ratingObj.userId, res: req.user });
      if (ratingObj.userId == req.user) {
        product.ratings.splice(index, 1);
        break;
      }
    }
    const user = await User.findById(req.user);

    const ratingSchema = {
      userId: req.user,
      rating,
      username: user.name,
      review: review,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({
      error: error?.message
        ? error.message
        : 'Something went wrong while creating the account',
    });
  }
});

module.exports = productRouter;
