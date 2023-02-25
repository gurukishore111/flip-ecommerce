const express = require('express');
const { auth } = require('../middleware/auth');
const { Product } = require('../models/product');
const productRouter = express.Router();
const { User } = require('../models/user');

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
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

// get all your products
productRouter.get('/:category', auth, async (req, res) => {
  console.log({ req: req.params.category });
  try {
    let product = await Product.find({ category: req.params.category });
    res.json(product);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

productRouter.get('/deal/deal-of-day', auth, async (req, res) => {
  try {
    let products = await Product.find({});
    let newProducts = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;
      for (let index = 0; index < a.ratings.length; index++) {
        const element = a.ratings[index];
        aSum += element.rating;
      }
      for (let index = 0; index < b.ratings.length; index++) {
        const element = b.ratings[index];
        bSum += element.rating;
      }
      return aSum < bSum ? 1 : -1;
    });
    if (newProducts) {
      res.json(newProducts);
    } else {
      res.status(400).json({
        msg: 'Product not found',
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
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
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

productRouter.delete('/rating/:id', auth, async (req, res) => {
  try {
    let product = await Product.findById(req.params.id);
    for (let index = 0; index < product.ratings.length; index++) {
      const ratingObj = product.ratings[index];
      console.log({ userId: ratingObj.userId, res: req.user });
      if (ratingObj.userId == req.user) {
        product.ratings.splice(index, 1);
        break;
      }
    }
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

productRouter.get('/product/:id', auth, async (req, res) => {
  console.log({ id: req.params.id });
  try {
    let product = await Product.findById(req.params.id);
    if (product) {
      res.json({ ...product._doc });
    } else {
      res.status(400).json({
        msg: 'Product not found',
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

module.exports = productRouter;
