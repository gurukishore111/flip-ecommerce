const express = require('express');
const app = express();

const PORT = 8000;

app.get('/', (req, res) => {
  res.status(200).json({ msg: 'Server is operational.' });
});

app.listen(PORT, '0.0.0.0', () => console.log(`Server listening at ${PORT}`));
