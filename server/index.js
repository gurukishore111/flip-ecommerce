const express = require('express');
const { authRouter } = require('./routes/auth');
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');
const app = express();
const morgan = require('morgan');

require('dotenv').config();
app.use(express.json());
app.use(morgan('tiny'));

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
app.use('/product', productRouter);
app.use('/user', userRouter);

app.listen(PORT, '0.0.0.0', () => console.log(`Server listening at ${PORT}`));
