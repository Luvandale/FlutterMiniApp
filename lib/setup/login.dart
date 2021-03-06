import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:setupapp/pages/home.dart';
import 'package:setupapp/setup/signup.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Center(child: new Text('Log in')),
          backgroundColor: Colors.orange,
        ),
        body: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email:'),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                    validator: (input) =>
                        !input.contains('@') ? 'Not a valid Email' : null,
                    onSaved: (input) => _email = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password:'),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                    validator: (input) => input.length < 8
                        ? 'You need at least 8 characters'
                        : null,
                    onSaved: (input) => _password = input,
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            return _submit();
                          },
                          child: Text('Log in'),
                          color: Colors.blue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Text('Register'),
                          color: Colors.green,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: _email, password: _password))
          .user;
      // read = auth.signInWithEmailAndPassword(email: _email, password: _password);
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }

      print(_email);
      print(_password);
    }
  }
}
