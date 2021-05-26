import 'package:flutter/material.dart';

class AvatarSelector extends StatelessWidget {
  final Function avatar;

  AvatarSelector(this.avatar);

  @override
  Widget build(BuildContext context) {
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

    return SafeArea(
      child: Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 2,
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: _imageList.length,
          itemBuilder: (context, index) => InkWell(
            child: Image.asset(_imageList[index]),
            onTap: () {
              avatar(_imageList[index]);
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
