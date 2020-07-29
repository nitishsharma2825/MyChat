import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitForm,this.isLoading);
  final Function submitForm;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey=GlobalKey<FormState>();
  bool isLogin = true;
  String _username;
  String _useremail;
  String _userpass;

  void _trySubmit(){
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState.save();
      widget.submitForm(_username,_useremail,_userpass,isLogin,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value){
                        if(value.isEmpty||!value.contains('@')){
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Id'),
                      onSaved: (value){
                        _useremail=value;
                      },
                ),
                    if(!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value){
                        if(value.isEmpty||value.length<4){
                          return 'Username should be atleat contain 4 characters.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value){
                        _username=value;
                      },
                ),
                    TextFormField(
                      key: ValueKey('Password'),
                      validator: (value){
                        if(value.isEmpty||value.length<4){
                          return 'Password should be atleast 4 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (value){
                        _userpass=value;
                      },
                ),
                    SizedBox(
                  height: 12,
                ),
                    if(widget.isLoading)
                      CircularProgressIndicator(),
                    if(!widget.isLoading)
                    RaisedButton(
                        onPressed: _trySubmit,
                        child: Text(isLogin?'Login':'SignUp'),
                ),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            isLogin=!isLogin;
                          });
                        },
                       child: Text(isLogin?'Create new account':'I already have an account'),
                        textColor: Theme.of(context).primaryColor,
                )
              ],
            )),
          ),
        ),
      ),
    );
    ;
  }
}
