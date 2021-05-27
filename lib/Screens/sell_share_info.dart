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
  final Function manualReset;

  SellShareInfo(this._cat, this._isShare, this.receivedAdid, this.manualReset);

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
  var _isImageSelected = true;

  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(
      source: src,
      maxHeight: 500,
      imageQuality: 50,
    );
    setState(() {
      if (pickedFile != null) {
        initImageUrl = '';
        _image = File(pickedFile.path);
        _isImageSelected = true;
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
  double price = 0;
  String initImageUrl = '';
  String initPrice = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      if (widget.receivedAdid != null) {
        final provider = Provider.of<Advertisements>(context).userAds;
        final foundAd = provider
            .firstWhere((element) => element.adid == widget.receivedAdid);
        ad = foundAd;
        initImageUrl = ad.imageUrl;
        initPrice = ad.price.toString();
      }
    }
    _isInit = false;
  }

  void submitForm() async {
    _formKey.currentState.save();
    String url;
    if (_image != null) {
      url = await uploadFile(_image);
    }

    if (ad.adid == null) {
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
    } else {
      ad = Advertisement(
        adid: ad.adid,
        category: widget._cat,
        contactinfo: contactinfo,
        description: description,
        location: location,
        timestamp: ad.timestamp,
        title: title,
        imageUrl: _image == null ? initImageUrl : url,
        price: price,
        markassold: ad.markassold,
        reportcount: ad.reportcount,
        sellerid: ad.sellerid,
      );
      setState(() {
        _isLoading = true;
      });
      await DatabaseService(uid: _auth.authUser.currentUser.uid).updateAd(ad);
      setState(() {
        _isLoading = false;
      });
      widget.manualReset();
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.blueGrey[900], //change your color here
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            widget._cat,
            style: Theme.of(context).textTheme.headline2,
          ),
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
                _isImageSelected
                    ? Container()
                    : Text(
                        'Please select an image',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 12,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[900],
                          elevation: 0,
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        onPressed: () => getImage(ImageSource.camera),
                      ),
                      SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[900],
                          elevation: 0,
                        ),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                        ),
                        onPressed: () => getImage(ImageSource.gallery),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Ad Location*',
                  style: TextStyle(color: Colors.grey[700]),
                ),
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
                  onSaved: (value) {
                    if (ad.location != '') {
                      value = ad.location;
                      location = value;
                    } else {
                      location = _dropDownVal;
                    }
                  },
                  validator: (value) {
                    if (ad.location != '') {
                      value = ad.location;
                    }
                    if (value == null || value.isEmpty) {
                      return 'Please select a location';
                    }
                    return null;
                  },
                  hint: Text(
                    widget.receivedAdid != null
                        ? ad.location
                        : 'Select location',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: ad.title,
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
                  initialValue: ad.description,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
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
                            price = double.parse(val);
                          },
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                double.parse(value) <= 10) {
                              return 'Price must be more than 10 rupees';
                            }
                            return null;
                          },
                        ),
                      ),
                TextFormField(
                  initialValue: ad.contactinfo,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact info';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            ad.adid == null ? 'POST' : 'UPDATE',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                    onPressed: () {
                      if (ad.adid == null && _image == null) {
                        setState(() {
                          _isImageSelected = false;
                        });
                        return;
                      }
                      if (_formKey.currentState.validate()) {
                        submitForm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.blueGrey[900],
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
