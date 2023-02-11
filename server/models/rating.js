const mongoose = require('mongoose');

const ratingSchema = mongoose.Schema({
  userId: {
    type: String,
    required: true,
    ref: 'User',
  },
  rating: {
    type: Number,
    required: true,
  },
  username: {
    type: String,
    required: true,
  },
  review: {
    type: String,
    required: true,
  },
});

module.exports = { ratingSchema };
