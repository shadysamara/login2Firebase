import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login2_firebase/auth_helper.dart';
import 'package:login2_firebase/login_user_model.dart';
import 'package:login2_firebase/views/products/backend/products_firebase.dart';
import 'package:login2_firebase/views/products/models/product.dart';

void main() {
  runApp(MaterialApp(home: App()));
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: RaisedButton(
                      child: Text('auth'),
                      onPressed: () async {
                        ProductsFirebaseHelper.helper.getAllProducts();
                        // PickedFile pickedFile = await ImagePicker()
                        //     .getImage(source: ImageSource.camera);
                        // File file = File(pickedFile.path);
                        // Product product = Product(
                        //     descriptionAr: 'وصف',
                        //     descriptionEn: 'description',
                        //     file: file,
                        //     nameAr: 'اسم',
                        //     nameEn: 'name',
                        //     price: 50.2);
                        // ProductsFirebaseHelper.helper.addProduct(product);
                        // AuthHelper.authHelper.logout();
                        // AuthHelper.authHelper.saveUserInFirestore();
                        // print(FirebaseAuth.instance.currentUser.emailVerified);
                        // isLoading =
                        // AuthHelper.authHelper
                        //     .login('shady.samara@gmail.com', '1234567');
                      },
                    ),
                  ),
                ),
                isLoading
                    ? Positioned.fill(
                        child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ))
                    : Container()
              ],
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: Text('Loading'),
          ),
        );
      },
    );
  }
}
