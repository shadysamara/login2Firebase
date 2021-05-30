import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login2_firebase/auth_helper.dart';

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
                      onPressed: () {
                        // AuthHelper.authHelper.logout();
                        // AuthHelper.authHelper.sendVerificationEmail();
                        print(FirebaseAuth.instance.currentUser.emailVerified);
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
