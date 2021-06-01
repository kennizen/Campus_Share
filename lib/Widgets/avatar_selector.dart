import 'package:campus_share/services/auth.dart';
import 'package:campus_share/services/database_services.dart';
import 'package:flutter/material.dart';

class AvatarSelector extends StatefulWidget {
  @override
  _AvatarSelectorState createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  AuthService _auth = AuthService();

  var _imageList = [
    'assets/png-96/avatar-96x96-456317.png',
    'assets/png-96/avatar-96x96-456318.png',
    'assets/png-96/avatar-96x96-456319.png',
    'assets/png-96/avatar-96x96-456321.png',
    'assets/png-96/avatar-96x96-456322.png',
    'assets/png-96/avatar-96x96-456323.png',
    'assets/png-96/avatar-96x96-456324.png',
    'assets/png-96/avatar-96x96-456325.png',
    'assets/png-96/avatar-96x96-456326.png',
    'assets/png-96/avatar-96x96-456327.png',
    'assets/png-96/avatar-96x96-456328.png',
    'assets/png-96/avatar-96x96-456329.png',
    'assets/png-96/avatar-96x96-456330.png',
    'assets/png-96/avatar-96x96-456331.png',
    'assets/png-96/avatar-96x96-456321.png',
  ];

  String _selectedImage = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Avatar selection',
            style: Theme.of(context).textTheme.headline2,
          ),
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.blueGrey[900],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedImage == ''
                            ? Colors.blueGrey[900]
                            : Colors.transparent,
                      ),
                      child: _selectedImage == ''
                          ? Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )
                          : Image.asset(_selectedImage),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 2,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _imageList.length,
                    itemBuilder: (context, index) => InkWell(
                      child: Image.asset(_imageList[index]),
                      onTap: () {
                        setState(() {
                          _selectedImage = _imageList[index];
                        });
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  primary: Colors.blueGrey[900],
                  elevation: 0,
                ),
                onPressed: () async {
                  if (_selectedImage == '') {
                    return;
                  }
                  await DatabaseService().updateProfileImage(
                    _auth.authUser.currentUser.uid,
                    _selectedImage,
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  'UPDATE AVATAR',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
