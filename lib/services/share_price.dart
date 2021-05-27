import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SharePrice {
  final double price;

  SharePrice(this.price);

  Widget priceShare() {
    if (price == 0) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              FontAwesome.handshake_o,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Sharing',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey[900],
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Icon(
          FontAwesome.rupee,
          size: 20,
        ),
        Text(
          price.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey[900],
          ),
        ),
      ],
    );
  }
}
