import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../lib/models/post.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Create Post Manually', () {
    Post post = Post(
      date: DateTime.now(),
      imageURL: 'test',
      quantity: 5,
      latitude: 27.0,
      longitude: 100.0
    );

    expect(post.imageURL, 'test');
    expect(post.quantity, 5);
    expect(post.latitude, 27.0);
    expect(post.longitude, 100.0);
  });

  test('Create Post from Firestore', () {
    // May have to change the document id if it's not there
    Firestore.instance.collection('postTest').document('aXgFEkliuuhqCnwjEGPw').get().then((DocumentSnapshot ds) {
      Post post = Post.fromFirestore(ds);

      expect(post.date, ds['date']);
      expect(post.quantity, ds['quantity']);
      expect(post.imageURL, ds['imageURL']);
      expect(post.latitude, ds['location'].latitude);
      expect(post.longitude, ds['location'].longitude);
    });
  });
}
