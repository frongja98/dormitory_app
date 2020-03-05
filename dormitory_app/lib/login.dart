import 'package:dormitorycpfapp/models/User.dart';
import 'package:dormitorycpfapp/services/AuthService.dart';
import 'package:dormitorycpfapp/models//User.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  User user = User();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              _buildForm(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() => Card(
        margin: EdgeInsets.only(top: 88, left: 30, right: 30),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _logo(),
                SizedBox(
                  height: 22,
                ),
                _buildUsernameInput(),
                SizedBox(
                  height: 8,
                ),
                _buildPasswordInput(),
                SizedBox(
                  height: 28,
                ),
                _buildSubmitButton(),
                _buildForgotPasswordButton(),
              ],
            ),
          ),
        ),
      );

  Widget _logo() => Image.asset(
        ("assets/Logo_home.png"),
        fit: BoxFit.cover,
      );

  Widget _buildUsernameInput() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'example@gmail.com',
          icon: Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: _validateEmail,
        onSaved: (String value) {
          user.Username = value;
        },
        onFieldSubmitted: (String value) {},
      );

  Widget _buildPasswordInput() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
          icon: Icon(Icons.lock),
        ),
        obscureText: true,
        validator: _validatePassword,
        onSaved: (String value) {
          user.Password = value;
        },
      );

  Widget _buildSubmitButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: _submit,
          child: Text(
            "Login".toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _buildForgotPasswordButton() => Container(
        child: FlatButton(
          splashColor: Colors.blue.shade500,
          onPressed: () {},
          child: Text(
            "Forgot password?",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );

  void _submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      authService.login(user: user).then((result) {
        if (result) {
          //todo
        } else {
          _showAlertDialog();
        }
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Username or Password is incorrect."),
            content: Text("Pleae Try Again."),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "The Enail is Empty.";
    }
    if (!isEmail(value)) {
      return "The Email must be a valid email.";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return "The Password must be at least 8 charactors.";
    }
    return null;
  }
}
