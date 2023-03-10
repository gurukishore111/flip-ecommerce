import 'package:flip/models/User.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    name: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModal(User user) {
    _user = user;
    notifyListeners();
  }
}
