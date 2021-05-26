import 'package:campus_share/Widgets/avatar_selector.dart';
import 'package:campus_share/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _avatar = '';
  String _email = '';
  String _password = '';
  String _username = '';
  var _isLoginSelected = true;
  var _isLoading = false;

  void selectedAvatar(String image) {
    final pickedFile = image;
    setState(() {
      if (pickedFile != '') {
        _avatar = pickedFile;
        print(_avatar);
      } else {
        print('No avatar selected');
      }
    });
  }

  void changeForm() {
    setState(() {
      _isLoginSelected = !_isLoginSelected;
    });
  }

  void submit() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLoginSelected ? Text('SIGN-IN') : Text('SIGN-UP'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                  child: _isLoginSelected
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 90),
                          child: Text(
                            'CAMPUS SHARE',
                            style: TextStyle(fontSize: 34),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    AvatarSelector(selectedAvatar),
                              ),
                            );
                          },
                          child: _avatar == ''
                              ? Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: 60),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text('Select Avatar'),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 60),
                                  child: Image.asset(_avatar),
                                ),
                        )),
              _isLoginSelected
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        onSaved: (val) {
                          _username = val;
                        },
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onSaved: (val) {
                    _email = val;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onSaved: (val) {
                    _password = val;
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    submit();
                    if (!_isLoginSelected) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                        email: _email,
                        password: _password,
                        pImage: _avatar,
                        username: _username,
                      );
                      if (result == null) {
                        print('error creating firebase user');
                      }
                    } else {
                      submit();
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email: _email, password: _password);
                      if (result == null) {
                        print('error signing in user');
                      }
                    }
                  },
                  child: _isLoginSelected
                      ? _isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )
                      : _isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isLoginSelected ? Text('New User?') : Text('Exixting User?'),
                  TextButton(
                    onPressed: changeForm,
                    child: _isLoginSelected
                        ? Text('Create account')
                        : Text('Login'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
