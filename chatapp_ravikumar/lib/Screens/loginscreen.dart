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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackBar("Please fill in all fields");
    } else {
      signIn(email, password);
    }
  }

  void signIn(String email, String password) async {
    try {
      // Attempt to sign in with email and password
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        String uid = credential.user!.uid;

        // Print UID to the terminal for debugging
        print("User UID: $uid");

        try {
          // Attempt to fetch user data from Firestore
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .get();

          // Check if document exists
          if (userData.exists) {
            // Check if the data is not null and valid
            if (userData.data() != null) {
              // Convert the Firestore document to your model
              UserModel userModel =
                  UserModel.fromMap(userData.data() as Map<String, dynamic>);

              print("Login Successful");
              print("User UID: $uid");

              // Navigate to HomeScreen with the retrieved user data
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    userModel: userModel,
                    firebaseuser: credential.user!,
                  ),
                ),
              );
            } else {
              // Handle case where the document exists but data is null
              showSnackBar("User data is empty. Please try again.");
            }
          } else {
            // Handle case where the document does not exist
            showSnackBar("User data not found in Firestore. Please try again.");
          }
        } catch (e) {
          // Handle errors specific to Firestore data retrieval
          print("Error retrieving user data: $e");
          showSnackBar("An error occurred while fetching user data.");
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      if (e.code == 'user-not-found') {
        showSnackBar("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showSnackBar("Incorrect password.");
      } else {
        showSnackBar("Authentication error: ${e.message}");
      }
    } catch (e) {
      // Handle any other exceptions
      print("Unexpected error: $e");
      showSnackBar("An unexpected error occurred. Please try again.");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CupertinoButton(
                    color: const Color.fromARGB(255, 5, 175, 187),
                    child: const Text("Log In"),
                    onPressed: () {
                      checkValues();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't Have an Account?",
              style: TextStyle(fontSize: 16),
            ),
            CupertinoButton(
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
