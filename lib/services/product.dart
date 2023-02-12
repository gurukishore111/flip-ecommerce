import 'package:flip/helpers/error_handing.dart';
import 'package:flip/models/Product.dart';
import 'dart:convert';
import 'package:flip/components/Common/SnackBar.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/User.dart';
import 'package:flip/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductServices {
  Future<List<Product>> fetchProductsByCategory({
    required BuildContext context,
    required String category,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/product/$category'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": user.token
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> searchProduct({
    required BuildContext context,
    required String query,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/product/search/$query'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": user.token
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<void> rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
    required String review,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(Uri.parse('$uri/product/rating'),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8",
            "x-auth-token": user.token
          },
          body: jsonEncode({
            "id": product.id!,
            "rating": rating,
            "review": review,
          }));
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Thanks for your rating');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> deleteRating({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccessCallback,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/product/rating/${product.id}'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": user.token
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Review removed successfully');
            onSuccessCallback();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future fetchProductsById({
    required BuildContext context,
    required String id,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    var products;
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/product//product/$id'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": user.token
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            products = Product.fromJson(
              jsonEncode(
                jsonDecode(response.body),
              ),
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  Future<List<Product>> fetchDealOfTheDay({
    required BuildContext context,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/product/deal/deal-of-day'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": user.token
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<void> addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(Uri.parse('$uri/user/add-cart'),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8",
            "x-auth-token": userProvider.user.token
          },
          body: jsonEncode({
            "id": product.id!,
          }));
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(cart: jsonDecode(response.body)['cart']);
            showSnackBar(context, 'Product successfully added to cart');
            userProvider.setUserFromModal(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
