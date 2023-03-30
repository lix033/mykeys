import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mykey/pages/SocialPage.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(55),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/logo1.jpg'),
              height: 350,
              width: 350,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Stocker tout vos mot de passe en un lieu sure et protéger par le secret de la confidentialité.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'lato',
                fontSize: 19,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfffECE70E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(150, 50),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SocialPage()));
              },
              child: Text(
                'Connectez-vous',
                style: TextStyle(
                    color: Colors.black, fontSize: 22, fontFamily: 'lato'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
