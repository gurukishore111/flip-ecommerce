const express = require('express');
const { auth } = require('../middleware/auth');
const { Order } = require('../models/order');
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
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

userRouter.delete('/remove-cart/:id', auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post('/save-address', auth, async (req, res) => {
  try {
    let { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    return res.json(user);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

userRouter.post('/order', auth, async (req, res) => {
  try {
    let { cart, totalPrice, address } = req.body;
    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res.status(400).json({ msg: `${product.name} is out of stock` });
      }
    }
    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();
    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    return res.json(order);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

userRouter.get('/orders', auth, async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
