import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

final List<String> categories = [
  'Electronics',
  'Books',
  'Instruments',
  'Cycles',
  'Fashion',
  'Furniture',
  'Others',
];

final List<Widget> catIcons = [
  Icon(MaterialCommunityIcons.cellphone, color: Colors.cyan[600]),
  Icon(FontAwesome.book, color: Colors.amber[600]),
  Icon(MaterialCommunityIcons.guitar_acoustic, color: Colors.blue[600]),
  Icon(FontAwesome.bicycle, color: Colors.orange[800]),
  Icon(MaterialCommunityIcons.tshirt_crew, color: Colors.green[600]),
  Icon(MaterialCommunityIcons.sofa, color: Colors.red[600]),
  Icon(MaterialCommunityIcons.unfold_more_vertical, color: Colors.purple[600]),
];
