import 'package:campus_share/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _avatar = 'assets/png-96/avatar-96x96-456332.png';
  String _email = '';
  String _password = '';
  String _username = '';
  var _isLoginSelected = true;
  var _isLoading = false;
  var _usernameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  Future<void> _showAlert(String error) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(
          error,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _isLoading = false;
              });
            },
          ),
        ],
      ),
    );
  }

  void changeForm() {
    setState(() {
      _isLoginSelected = !_isLoginSelected;
      _emailController.clear();
      _usernameController.clear();
      _passwordController.clear();
    });
  }

  void submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      if (!_isLoginSelected) {
        await _auth
            .registerWithEmailAndPassword(
          email: _email,
          password: _password,
          pImage: _avatar,
          username: _username,
        )
            .catchError((onError) {
          _showAlert(onError.toString());
        });
      } else {
        await _auth
            .signInWithEmailAndPassword(email: _email, password: _password)
            .catchError((onError) {
          _showAlert(onError.toString());
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Campus Share',
                            style: GoogleFonts.openSans(
                              fontSize: 36,
                              color: Colors.blueGrey[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'Welcome,',
                          style: GoogleFonts.openSans(
                            fontSize: 26,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        Text(
                          _isLoginSelected
                              ? 'Provide login details to continue.'
                              : 'Provide details to register and continue.',
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isLoginSelected
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey[900],
                                  width: 2,
                                ),
                                gapPadding: 1,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey[400],
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                gapPadding: 1,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red[700],
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                gapPadding: 1,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red[700],
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                gapPadding: 1,
                              ),
                              labelText: 'Username',
                            ),
                            onSaved: (val) {
                              _username = val;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blueGrey[900],
                            width: 2,
                          ),
                          gapPadding: 1,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey[400],
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          gapPadding: 1,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red[700],
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          gapPadding: 1,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red[700],
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          gapPadding: 1,
                        ),
                        labelText: 'Email',
                      ),
                      onSaved: (val) {
                        _email = val;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[900],
                          width: 2,
                        ),
                        gapPadding: 1,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey[400],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        gapPadding: 1,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red[700],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        gapPadding: 1,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red[700],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        gapPadding: 1,
                      ),
                      labelText: 'Password',
                    ),
                    onSaved: (val) {
                      _password = val;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 5) {
                        return 'Password should be atleast 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _isLoginSelected ? 'Sign In' : 'Sign Up',
                        style: GoogleFonts.openSans(
                          fontSize: 24,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.blueGrey[900],
                          shape: CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        onPressed: () async {
                          submit();
                        },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLoginSelected ? 'New User?' : 'Existing User?',
                        style: GoogleFonts.openSans(),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: changeForm,
                        child: Text(
                          _isLoginSelected ? 'Create account' : 'Sign in',
                          style: GoogleFonts.openSans(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
