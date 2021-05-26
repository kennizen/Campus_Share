import 'dart:io';
import 'package:campus_share/providers/ad_provider.dart';
import 'package:path/path.dart' as path;
import 'package:campus_share/models/advertisement.dart';
import 'package:campus_share/services/auth.dart';
import 'package:campus_share/services/database_services.dart';
import 'package:campus_share/store/locations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SellShareInfo extends StatefulWidget {
  final String _cat;
  final double _isShare;
  final String receivedAdid;

  SellShareInfo(this._cat, this._isShare, this.receivedAdid);

  @override
  _SellShareInfoState createState() => _SellShareInfoState();
}

class _SellShareInfoState extends State<SellShareInfo> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  var _locations = locations;
  var _dropDownVal = '';
  var _isLoading = false;
  var _isInit = true;

  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(
      source: src,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        initImageUrl = '';
        _image = File(pickedFile.path);
      } else {
        print('NO image selected');
      }
    });
  }

  Future<String> uploadFile(File _image) async {
    String returnURL;
    Reference storageReference = FirebaseStorage.instance
        .ref('Advertisments/${path.basename(_image.path)}');
    UploadTask uploadTask = storageReference.putFile(_image);
    setState(() {
      _isLoading = true;
    });
    await uploadTask.whenComplete(() async {
      await storageReference.getDownloadURL().then((fileURL) {
        returnURL = fileURL;
      });
    });
    return returnURL;
  }

  var ad = Advertisement(
    adid: null,
    category: '',
    contactinfo: '',
    description: '',
    location: '',
    timestamp: null,
    title: '',
    imageUrl: null,
    price: 0,
    markassold: false,
    reportcount: 0,
    sellerid: null,
  );

  String contactinfo = '';
  String description = '';
  String location = '';
  String title = '';
  double price;
  String initPrice = '';
  String initImageUrl = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      if (widget.receivedAdid != null) {
        final provider = Provider.of<Advertisements>(context).userAds;
        final foundAd = provider
            .firstWhere((element) => element.adid == widget.receivedAdid);
        ad = foundAd;
        contactinfo = ad.contactinfo;
        description = ad.description;
        location = ad.location;
        title = ad.title;
        initPrice = ad.price.toString();
        initImageUrl = ad.imageUrl;
      }
    }
    _isInit = false;
  }

  void submitForm() async {
    _formKey.currentState.save();
    String url = await uploadFile(_image);
    ad = Advertisement(
      adid: Uuid().v4().toString(),
      category: widget._cat,
      contactinfo: contactinfo,
      description: description,
      location: location,
      timestamp: DateTime.now(),
      title: title,
      imageUrl: url,
      price: price,
      markassold: ad.markassold,
      reportcount: ad.reportcount,
      sellerid: _auth.authUser.currentUser.uid,
    );
    await DatabaseService(uid: _auth.authUser.currentUser.uid).createAd(ad);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: initImageUrl != ''
                      ? Image.network(initImageUrl)
                      : _image == null
                          ? Center(child: Text('No image selected.'))
                          : Image.file(
                              _image,
                              fit: BoxFit.contain,
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        child: Icon(Icons.add_a_photo),
                        onPressed: () => getImage(ImageSource.camera),
                      ),
                      SizedBox(width: 25),
                      OutlinedButton(
                        child: Icon(Icons.add_photo_alternate),
                        onPressed: () => getImage(ImageSource.gallery),
                      ),
                    ],
                  ),
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
                    });
                  },
                  onSaved: (_) {
                    location = _dropDownVal;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a location';
                    }
                    return null;
                  },
                  hint: widget.receivedAdid != null
                      ? Text(location)
                      : Text('Select location'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: title,
                  maxLength: 70,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    labelText: 'Ad title*',
                  ),
                  onSaved: (val) {
                    title = val;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: description,
                  maxLength: 2000,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    labelText: 'Ad descrpition*',
                  ),
                  onSaved: (val) {
                    description = val;
                  },
                  textInputAction: TextInputAction.newline,
                ),
                widget._isShare == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          initialValue: initPrice,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                            labelText: 'Ad price*',
                          ),
                          onSaved: (val) {
                            val == null || val == ''
                                ? price = 0
                                : price = double.parse(val);
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                TextFormField(
                  initialValue: contactinfo,
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLength: 500,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    labelText: 'Contact Info (Phone/email/others)*',
                  ),
                  onSaved: (val) {
                    contactinfo = val;
                  },
                  textInputAction: TextInputAction.newline,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    child:
                        _isLoading ? CircularProgressIndicator() : Text('POST'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        submitForm();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
