import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading=false;
  void _submitForm(
    String username,
    String useremail,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    setState(() {
      isLoading=true;
    });
    AuthResult authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: useremail,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: useremail,
          password: password,
        );
        Firestore.instance.collection('users').document(authResult.user.uid).setData({
          'username':username,
          'email':useremail,
        });
      }
    } on PlatformException catch (err) {
      var message = "An error occurred. Please check your credentials.";
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        isLoading=false;
      });
    } catch(err){
      print(err);
      setState(() {
        isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitForm,isLoading));
  }
}
