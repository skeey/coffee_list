import 'package:coffee_list/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;

  SignUp({ this.toggleView });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String name = '';
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  Future handleSubmit() async {
    if (_formkey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);
      if(this.mounted && result == null){
        setState(() => loading = false);
        setState(() => error = 'Please supply a valid name, email and password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown[400], width: 2.0)
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  )
                ),
                textInputAction: TextInputAction.next,
                focusNode: _nameFocus,
                onFieldSubmitted: (term) {
                  _nameFocus.unfocus();
                  FocusScope.of(context).requestFocus(_emailFocus);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'The name can not be empty';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown[400], width: 2.0)
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  )
                ),
                textInputAction: TextInputAction.next,
                focusNode: _emailFocus,
                onFieldSubmitted: (term) {
                  _emailFocus.unfocus();
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'The email can not be empty';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown[400], width: 2.0)
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  )
                ),
                focusNode: _passwordFocus,
                validator: (val) {
                  if (val.length < 6) {
                    return 'Enter a password with six or more characters long';
                  }
                  return null;
                },
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
                onFieldSubmitted: (term) {
                  handleSubmit();
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.brown[400],
                child: loading ? Container(
                  width: 15.0,
                  height: 15.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.brown[100]),
                    strokeWidth: 2,
                  ),
                ) : Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: handleSubmit,
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}