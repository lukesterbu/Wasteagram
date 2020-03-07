import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class PostDTO {
  Timestamp date;
  String imageURL;
  GeoPoint location;
  int quantity;

  PostDTO({this.imageURL, this.quantity}) {
    this.date = Timestamp.now();
    _setLocation();
  }

  void _setLocation() async {
    Location location = new Location();
    LocationData locationData = await location.getLocation();
    this.location = GeoPoint(locationData.latitude, locationData.longitude);
  }
}