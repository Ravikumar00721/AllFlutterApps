import 'package:flutter/material.dart';
import 'package:chatapp_ravikumar/Models/usermodels.dart';
import 'package:chatapp_ravikumar/Models/firebasehelper.dart';
import 'package:chatapp_ravikumar/Screens/homescreen.dart';
import 'package:chatapp_ravikumar/Screens/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    UserModel? thisUserModel =
        await Firebasehelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
          MyAppLoggedIn(userModel: thisUserModel, firebaseuser: currentUser));
    } else {
      runApp(const MyApp());
    }
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseuser;

  const MyAppLoggedIn(
      {Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(userModel: userModel, firebaseuser: firebaseuser),
    );
  }
}
