import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostDTO {
  Timestamp date;
  String imageURL;
  GeoPoint location;
  int quantity;

  PostDTO({this.imageURL, this.location, this.quantity}) {
    this.date = Timestamp.now();
  }

  void addToFirestore() {
    Firestore.instance.collection('posts').add({
      'date': this.date,
      'imageURL': this.imageURL,
      'location': this.location,
      'quantity': this.quantity
    });
  }
}