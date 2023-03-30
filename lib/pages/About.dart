import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

const primary_color = Color(0xff43479D);
const boutons_color = Color(0xffECE70E);

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'MyKeys\n1.0.1\n@2023 DreamerCode',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
