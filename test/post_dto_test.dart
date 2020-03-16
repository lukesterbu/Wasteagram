import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/models/post_dto.dart';

void main() {
  test('Create Post Manually', () {
    GeoPoint geoPoint = GeoPoint(27.0, 100.0);
    PostDTO post = PostDTO(
      imageURL: 'test',
      quantity: 5,
      location: geoPoint,
    );

    expect(post.date, isNotNull);
    expect(post.imageURL, 'test');
    expect(post.quantity, 5);
    expect(post.location.latitude, 27.0);
    expect(post.location.longitude, 100.0);
  });
}