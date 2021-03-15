import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:setupapp/pages/home.dart';
import 'package:setupapp/setup/login.dart';

class Signup extends StatefulWidget {
  Signup({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignupState createState() => new _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Center(child: new Text('create account')),
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
                          child: Text('Register'),
                          color: Colors.green,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                          },
                          child: Text('Log in'),
                          color: Colors.blue,
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

  Future<void> _submit()  async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
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
