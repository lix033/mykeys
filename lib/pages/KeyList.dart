import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyList extends StatefulWidget {
  const KeyList({Key? key}) : super(key: key);

  @override
  _KeyListState createState() => _KeyListState();
}

class _KeyListState extends State<KeyList> {
  bool _loading = true;
  List<Map<String, dynamic>> _keys = [];

  late ClipboardData _clipboardData;

  @override
  void initState() {
    super.initState();
    _loadKeys();
  }

  Future<void> _loadKeys() async {
    setState(() {
      _loading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final keys = await FirebaseFirestore.instance
          .collection('keys')
          .where('userID', isEqualTo: user.uid)
          .orderBy('date', descending: true)
          .get();
      //...

      setState(() {
        _keys = keys.docs
            .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
            .toList();

        _loading = false;
      });
    }
  }

  Future<void> _deleteKey(Map<String, dynamic> key) async {
    setState(() {
      _keys.remove(key);
    });
    await FirebaseFirestore.instance.collection('keys').doc(key['id']).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _keys.isEmpty
              ? Center(child: Text('Aucune donnée disponible'))
              : ListView.builder(
                  itemCount: _keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    final key = _keys[index];

                    return SizedBox(
                      // height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          tileColor: Colors.grey[100],
                          minVerticalPadding: 40,
                          title: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      key['platform'],
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(key['password']),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Icon(Icons.copy),
                                onTap: () {
                                  setState(() {
                                    _clipboardData =
                                        ClipboardData(text: key['password']);
                                  });
                                  Clipboard.setData(_clipboardData);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Mot de passe copié avec succès.')));
                                },
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red[300],
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text(
                                            'Voulez-vous vraiment supprimer cet élément ?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('Annuler'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await _deleteKey(key);
                                            },
                                            child: Text('Supprimer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
