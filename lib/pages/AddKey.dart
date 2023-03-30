import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

const primary_color = Color(0xff43479D);
const boutons_color = Color(0xffECE70E);
const white_color = Colors.white;

class AddKey extends StatefulWidget {
  const AddKey({Key? key}) : super(key: key);

  @override
  State<AddKey> createState() => _AddKeyState();
}

class _AddKeyState extends State<AddKey> {
  final platformController = TextEditingController();
  final passwordController = TextEditingController();

  void _saveData() {
    final platform = platformController.text.trim();
    final password = passwordController.text.trim();

    if (platform.isNotEmpty && password.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('keys')
          .where('platform', isEqualTo: platform)
          .get()
          .then((QuerySnapshot snapshot) {
        if (snapshot.docs.isEmpty) {
          // Aucune donnée existante pour cette plate-forme, insérez de nouvelles données
          FirebaseFirestore.instance.collection('keys').add({
            'platform': platform,
            'password': password,
            'date': FieldValue.serverTimestamp(),
            'userID': FirebaseAuth.instance.currentUser?.uid,
          }).then((value) {
            // Réinitialisez les champs de texte après avoir enregistré les données.
            platformController.clear();
            passwordController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Données enregistrées avec succès')),
            );
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Erreur lors de l\'enregistrement des données')),
            );
          });
        } else {
          // Des données existent déjà pour cette plate-forme
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Les données existent déjà pour cette plate-forme')),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la récupération des données')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Ajouter un mot de passe',
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
                    controller: platformController,
                    decoration: InputDecoration(
                      labelText: 'Saisir la plateforme',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Saisir le mot de passe',
                      // border: OutlineInputBorder(),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: boutons_color,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.all(10),
                ),
                onPressed: _saveData,
                child: Text(
                  'Sauvegarder',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
