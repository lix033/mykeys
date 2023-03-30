import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mykey/pages/SocialPage.dart';
import '../services/couleurs.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  User? user;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SocialPage()),
        (route) => false,
      );
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 200,
              child: AnimatedBuilder(
                animation: AlwaysStoppedAnimation(0),
                builder: (BuildContext context, Widget? child) {
                  return SizedBox(
                    child: Image.asset('assets/images/profil.gif',
                        fit: BoxFit.contain),
                  );
                },
              ),
            ),
            Text(
              'Bienvenue, ${user?.displayName ?? 'Utilisateur'}',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'lato',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Email: ${user?.email ?? 'non renseignée'}',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'lato',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: boutons_color,
              ),
              onPressed: signOut,
              child: Text(
                'Deconnexion',
                style: TextStyle(
                  color: noir_color,
                  fontFamily: 'lato',
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
