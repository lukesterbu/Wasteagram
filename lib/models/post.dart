import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  DateTime date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  Post({this.date, this.imageURL, this.quantity, this.latitude, this.longitude});

  factory Post.fromFirestore(DocumentSnapshot document) {
    return Post(
      date: document['date'].toDate(),
      imageURL: document['imageURL'],
      quantity: document['quantity'],
      latitude: document['location'].latitude,
      longitude: document['location'].longitude
    );
  }
}