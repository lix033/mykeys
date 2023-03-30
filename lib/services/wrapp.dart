import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mykey/pages/Home.dart';
import 'package:mykey/pages/SocialPage.dart';
import 'package:mykey/pages/Welcome.dart';

class Wrappp extends StatefulWidget {
  const Wrappp({super.key});

  @override
  State<Wrappp> createState() => _WrapppState();
}

class _WrapppState extends State<Wrappp> {
  User? user;

  @override
  void initState() {
    super.initState();
    // Vérifier si l'utilisateur est connecté au démarrage de l'application
    FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {
      setState(() {
        user = currentUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Welcome();
    } else {
      return Home();
    }
  }
}
