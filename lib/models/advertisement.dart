import 'package:flutter/material.dart';

class Advertisement {
  final String adid;
  final String title;
  final String description;
  final String location;
  final double price;
  bool markassold;
  final String category;
  int reportcount;
  final String contactinfo;
  final DateTime timestamp;
  final String imageUrl;
  final String sellerid;

  Advertisement({
    @required this.adid,
    @required this.category,
    @required this.contactinfo,
    @required this.description,
    @required this.location,
    this.markassold,
    this.price,
    this.reportcount,
    @required this.timestamp,
    @required this.title,
    this.imageUrl,
    this.sellerid,
  });
}
