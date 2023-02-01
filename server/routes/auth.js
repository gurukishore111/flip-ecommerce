const express = require('express');
const { User } = require('../models/user');
const authRouter = express.Router();

authRouter.post('/signup', async (req, res) => {
  const { email, name, password } = req.body;
  try {
    let existingUser = await User.findOne({ email: email });
    if (existingUser) {
      return res
        .status(400)
        .json({ error: 'User with same email already exists!' });
    }
    let user = new User({
      email,
      name,
      password,
    });
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(400).json({
      error: error?.message
        ? error.message
        : 'Something went wrong while creating the account',
    });
  }
});

module.exports = { authRouter };
