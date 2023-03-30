import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykey/pages/Home.dart';
import 'package:mykey/pages/MailLogin.dart';
import '../services/authentificationGoogle.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  Future<void> _signInWithGoogle() async {
    try {
      UserCredential userCredential = await signInWithGoogle();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
      // L'utilisateur est connecté avec succès
    } on FirebaseAuthException catch (e) {
      // Une erreur Firebase Auth s'est produite
      print('Erreur Firebase Auth: ${e.code} - ${e.message}');
      // Affiche un message d'erreur à l'utilisateur ou enregistre l'erreur dans les journaux
    } on PlatformException catch (e) {
      // Gestion des erreurs de la plate-forme (par exemple, erreur de connexion Google)
      print('Erreur de la plate-forme: ${e.code} - ${e.message}');
      // Afficher un message d'erreur à l'utilisateur ou enregistrer l'erreur dans les journaux
      throw e;
    } catch (e) {
      // Une erreur inattendue s'est produite
      print('Erreur inattendue: $e');
      // Affiche un message d'erreur à l'utilisateur ou enregistre l'erreur dans les journaux
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            height: 250,
            child: AnimatedBuilder(
              animation: AlwaysStoppedAnimation(0),
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  child: Image.asset('assets/images/anim1.gif',
                      fit: BoxFit.contain),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 40,
            ),
            // child: Column(children: []),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 40,
            ),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.grey[300],
                    padding: EdgeInsets.all(5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MailLogin()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icons/sms.png'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Connexion par mail',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.grey[300],
                    padding: EdgeInsets.all(5),
                  ),
                  onPressed: _signInWithGoogle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icons/google.png'),
                      SizedBox(width: 10),
                      Text(
                        'Votre compte google',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
