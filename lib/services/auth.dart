import 'dart:convert';

import 'package:flip/components/common/SnackBar.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/helpers/error_handing.dart';
import 'package:flip/models/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      print(res.body);
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Login Successful');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
