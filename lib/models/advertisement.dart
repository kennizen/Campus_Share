import 'package:flutter/material.dart';

class Advertisement {
  final String adid;
  final String title;
  final String description;
  final String location;
  final double price;
  final String sellerid;
  bool markassold;
  final String category;
  int reportcount;
  final String contactinfo;
  final DateTime timestamp;
  final String imageUrl;

  Advertisement({
    @required this.adid,
    @required this.category,
    @required this.contactinfo,
    @required this.description,
    @required this.location,
    this.markassold,
    this.price,
    this.reportcount,
    @required this.sellerid,
    @required this.timestamp,
    @required this.title,
    @required this.imageUrl,
  });
}
