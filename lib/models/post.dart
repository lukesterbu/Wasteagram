import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';

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
      latitude: (document['location'] == null) ? null : document['location'].latitude,
      longitude: (document['location'] == null) ? null : document['location'].longitude
    );
  }

  String getFormattedDate() {
    return formatDate(this.date, [DD, ', ', M, ' ', d, ', ', yyyy]);
  }
}