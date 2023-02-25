const express = require('express');
const { auth } = require('../middleware/auth');
const { User } = require('../models/user');
const { generateToken, verifyToken } = require('../utils/generateToken');
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
      error: error?.message ? error.message : ' Something went wrong ',
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
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

authRouter.post('/token', async (req, res) => {
  try {
    const token = req.header('x-auth-token');
    if (!token) return res.json(false);
    const verified = verifyToken(token);
    if (!verified) return res.json(false);
    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

authRouter.get('/', auth, async (req, res) => {
  try {
    const user = await User.findById(req.user);
    console.log(user);
    res.json({ ...user._doc, token: req.token });
  } catch (error) {
    res.status(500).json({
      error: error?.message ? error.message : ' Something went wrong ',
    });
  }
});

module.exports = { authRouter };
