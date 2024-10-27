import 'package:chatapp_ravikumar/Screens/homescreen.dart';
import 'package:chatapp_ravikumar/Screens/signupscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp_ravikumar/Models/usermodels.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Check for empty fields before attempting login
  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      print("Please fill in all fields");
    } else {
      signIn(email, password);
    }
  }

  // Sign in function with Firebase Auth and navigation upon success
  void signIn(String email, String password) async {
    try {
      // Sign in user with email and password
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        String uid = credential.user!.uid;

        // Fetch user data from Firestore
        DocumentSnapshot userData =
            await FirebaseFirestore.instance.collection("users").doc(uid).get();

        UserModel userModel =
            UserModel.fromMap(userData.data() as Map<String, dynamic>);

        print("Login Successful");

        // Navigate to HomeScreen on successful login
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    userModel: userModel,
                    firebaseuser: credential.user!,
                  )),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes for better error messages
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Incorrect password.");
      } else {
        print("Error: ${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Chat App",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                    color: Color.fromARGB(255, 5, 175, 187),
                    child: Text("Log In"),
                    onPressed: () {
                      checkValues();
                    })
              ],
            ),
          ),
        ),
      )),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't Have an Account?",
              style: TextStyle(fontSize: 16),
            ),
            CupertinoButton(
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }));
                })
          ],
        ),
      ),
    );
  }
}
