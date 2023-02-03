const express = require('express');
const { User } = require('../models/user');
const generateToken = require('../utils/generateToken');
const authRouter = express.Router();

authRouter.post('/signup', async (req, res) => {
  const { email, name, password } = req.body;
  try {
    let existingUser = await User.findOne({ email: email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: 'User with same email already exists!' });
    }
    let user = new User({
      email,
      name,
      password,
    });
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({
      error: error?.message
        ? error.message
        : 'Something went wrong while creating the account',
    });
  }
});

authRouter.post('/signin', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (user && (await user.matchPassword(password))) {
      res.json({
        ...user._doc,
        token: generateToken(user._id),
      });
    } else {
      res.status(400).json({ msg: 'Invalid email or password' });
    }
  } catch (error) {
    res.status(500).json({
      error: error?.message
        ? error.message
        : 'Something went wrong while creating the account',
    });
  }
});

module.exports = { authRouter };
