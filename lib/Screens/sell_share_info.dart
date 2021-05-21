import 'dart:io';

import 'package:campus_share/store/locations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellShareInfo extends StatefulWidget {
  final String _cat;
  final bool _isShare;

  SellShareInfo(this._cat, this._isShare);

  @override
  _SellShareInfoState createState() => _SellShareInfoState();
}

class _SellShareInfoState extends State<SellShareInfo> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  var _locations = locations;
  var _dropDownVal = '';

  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('NO image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget._cat),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: _image == null
                      ? Center(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.camera),
                              onPressed: () => getImage(ImageSource.camera),
                            ),
                            IconButton(
                              icon: Icon(Icons.image),
                              onPressed: () => getImage(ImageSource.gallery),
                            ),
                          ],
                        ))
                      : Image.file(_image),
                ),
                Text('Ad Location*'),
                DropdownButtonFormField<String>(
                    items: _locations
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _dropDownVal = val;
                        print(_dropDownVal);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a location';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                TextFormField(
                  maxLength: 70,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    labelText: 'Ad title*',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 2000,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    labelText: 'Ad descrpition*',
                  ),
                  textInputAction: TextInputAction.newline,
                ),
                widget._isShare
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                            labelText: 'Ad price*',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLength: 500,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    labelText: 'Contact Info (Phone/email/others)*',
                  ),
                  textInputAction: TextInputAction.newline,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
            child: Text('POST'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                print('validated');
              }
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
