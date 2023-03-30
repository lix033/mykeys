import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mykey/pages/Next.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
              'La sécurisation des données de nos jours reste la plus importante des préoccupations, c’est pour cela nous avons décidé de prendre les choses en mains.',
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
                    MaterialPageRoute(builder: (context) => NextPage()));
              },
              child: Text(
                'Continuer',
                style: TextStyle(
                    color: Colors.black, fontSize: 25, fontFamily: 'lato'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
