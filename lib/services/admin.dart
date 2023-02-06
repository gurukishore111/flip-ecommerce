import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flip/components/Common/SnackBar.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/helpers/error_handing.dart';
import 'package:flip/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flip/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    VoidCallback? onCallBack,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary = CloudinaryPublic('gk1', 'cboo8mrm');
      List<String> imagesUrls = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imagesUrls,
        category: category,
        price: price,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": user.token
        },
        body: product.toJson(),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          if (onCallBack != null) {
            onCallBack();
          }
          showSnackBar(context, 'Product added successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      if (onCallBack != null) {
        onCallBack();
      }
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/products'),
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

  void deleteProduct({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/product/$id'),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": user.token
        },
      );
      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
