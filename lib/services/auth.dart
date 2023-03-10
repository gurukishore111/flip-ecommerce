import 'dart:convert';
import 'package:flip/components/Common/BotttomNav.dart';
import 'package:flip/components/Common/SnackBar.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/helpers/error_handing.dart';
import 'package:flip/models/User.dart';
import 'package:flip/providers/user.dart';
import 'package:flip/screens/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // signup the user
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created! Login with the same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // signin the user
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/signin'),
        body: json.encode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
      );
      // print(res.body);
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNav.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData({
    BuildContext? context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/token'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": token!
        },
      );
      var response = jsonDecode(res.body);

      if (response == true) {
        // get User Data
        http.Response userRes = await http.get(
          Uri.parse('$uri/api/user/'),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8",
            "x-auth-token": token
          },
        );
        var userProvider = Provider.of<UserProvider>(context!, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context!, e.toString());
    }
  }

  Future<void> saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/user/save-address/'),
        body: jsonEncode({'address': address}),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              address: jsonDecode(response.body)['address'],
            );
            userProvider.setUserFromModal(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/user/order/'),
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalSum
        }),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Your order has been placed!');
            User user = userProvider.user.copyWith(
              cart: [],
            );
            userProvider.setUserFromModal(user);
            Navigator.of(context).pop();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
