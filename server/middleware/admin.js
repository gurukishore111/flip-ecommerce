const { verifyToken } = require('../utils/generateToken');
const { User } = require('../models/user');

const admin = async (req, res, next) => {
  try {
    const token = req.header('x-auth-token');
    if (!token) {
      res.status(401).json({ msg: 'No auth token, access denied' });
    }
    const verified = verifyToken(token);
    if (!verified) {
      return res
        .status(401)
        .json({ msg: 'Token verification failed authorization denied' });
    }
    const user = await User.findById(verified.id);
    if (user.type !== 'admin') {
      return res.status(401).json({ msg: 'Access denied' });
    }
    req.user = verified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { admin };
