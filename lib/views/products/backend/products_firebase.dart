import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:login2_firebase/views/products/models/product.dart';

class ProductsFirebaseHelper {
  ProductsFirebaseHelper._();
  static ProductsFirebaseHelper helper = ProductsFirebaseHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final String usersCollectionName = 'Products';

  Future<String> addProduct(Product product) async {
    File file = product.file;
    String uploadedImageUrl = await uploadProductImage(file);
    product.imageUrl = uploadedImageUrl;
    firestore.collection(usersCollectionName).add(product.toMap());
  }

  Future<String> uploadProductImage(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String fullPath = 'products/$fileName';
    Reference refrence = storage.ref(fullPath);
    TaskSnapshot task = await refrence.putFile(file);
    String imageUrl = await refrence.getDownloadURL();
    return imageUrl;
  }

  Future<List<Product>> getAllProducts() async {}
  editProduct(String id) async {}
  deleteProduct(String id) async {}
}
