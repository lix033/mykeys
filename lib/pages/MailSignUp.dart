import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykey/pages/MailLogin.dart';

const primary_color = Color(0xff43479D);
const boutons_color = Color(0xffECE70E);
const white_color = Colors.white;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String error = "";

  Future<void> createAccount(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MailLogin()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = "Erreur de création de compte: ${e.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary_color,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset(
            'assets/images/logo1.jpg',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Creer votre compte',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    labelText: 'Votre adresse mail',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Votre mot de passe',
                    // border: OutlineInputBorder(),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MailLogin()),
                    );
                  },
                  child: Text(
                    'Se connecter?',
                    style: TextStyle(
                      color: primary_color,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: boutons_color,
                shape: StadiumBorder(),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                createAccount(_controllerEmail.text, _controllerPassword.text);
              },
              child: Text(
                'Creez un compte',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
