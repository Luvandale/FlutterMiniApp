import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setupapp/setup/login.dart';

class Home extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcome Home')),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.red,
          child: Text('Log out'),
          onPressed: ()=> _logout(context),
        ),
      ),
    );
  }

  void _logout(context) async {
    await auth.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(),
        ));
  }
}
