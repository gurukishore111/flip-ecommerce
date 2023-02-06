const express = require('express');
const { authRouter } = require('./routes/auth');
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');
const app = express();
require('dotenv').config();
app.use(express.json());

const PORT = 8000;

let uri = process.env.DB_URI;

mongoose
  .connect(uri)
  .then(() => {
    console.log(`DB Connection Succesful 🎉`);
  })
  .catch((e) => {
    console.log(`DB Connection failed - ${e.message}`);
  });

app.get('/', (req, res) => {
  res.status(200).json({ msg: 'Server is operational.' });
});

app.use('/api/user', authRouter);
app.use('/admin', adminRouter);

app.listen(PORT, '0.0.0.0', () => console.log(`Server listening at ${PORT}`));
