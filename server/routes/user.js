const express = require('express');
const { auth } = require('../middleware/auth');
const { Product } = require('../models/product');
const userRouter = express.Router();
const { User } = require('../models/user');

userRouter.post('/add-cart', auth, async (req, res) => {
  try {
    let { id } = req.body;
    console.log({ id: id }, 'add-cart');
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product: product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let index = 0; index < user.cart.length; index++) {
        const cartItem = user.cart[index];
        if (cartItem.product._id.equals(product._id)) {
          isProductFound = true;
        }
      }
      if (isProductFound) {
        let existingProduct = user.cart.find((item) => {
          return item.product._id.equals(product._id);
        });
        console.log({ existingProduct });
        existingProduct.quantity += 1;
      } else {
        user.cart.push({ product: product, quantity: 1 });
      }
    }
    user = await user.save();
    return res.json(user);
  } catch (error) {
    res.status(500).json({
      error: error?.message
        ? error.message
        : 'Something went wrong while creating the account',
    });
  }
});

module.exports = userRouter;
