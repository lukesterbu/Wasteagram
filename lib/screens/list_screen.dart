import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../screens/detail_screen.dart';
import '../screens/photo_screen.dart';
import '../widgets/wasteagram_scaffold.dart';

class ListScreen extends StatefulWidget {

  static const routeName = 'list_screen';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  int totalWasted;

  @override
  void initState() {
    super.initState();
    setNumberOfWasted();
  }

  void setNumberOfWasted() {
    Firestore.instance.collection('posts').snapshots().listen( (snapshot) {
      int tempWasted = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['quantity']);
      setState(() { totalWasted = tempWasted; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WastegramScaffold(
      title: 'Wasteagram - $totalWasted',
      child: postList(context),
      fab: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(PhotoScreen.routeName),
        child: Icon(Icons.camera_alt),
      )
    );
  }

  Widget postList(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index])
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    Post post = Post.fromFirestore(document);
    return ListTile(
      title: Text(post.getFormattedDate()),
      trailing: Text(post.quantity.toString()),
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailScreen.routeName,
          arguments: post
        );
      },
    );
  }
}