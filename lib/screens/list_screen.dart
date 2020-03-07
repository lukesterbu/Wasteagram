import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/detail_screen.dart';
import '../screens/photo_screen.dart';
import '../widgets/wasteagram_scaffold.dart';

class ListScreen extends StatefulWidget {

  static const routeName = 'list_screen';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {


  @override
  Widget build(BuildContext context) {
    return WastegramScaffold(
      title: 'Wasteagram',
      child: postList(context),
      fab: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(PhotoScreen.routeName),
        child: Icon(Icons.add),
      )
    );
  }

  Widget postList(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index])
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: Text(document['date'].toDate().toString()),
      trailing: Text(document['quantity'].toString()),
      onTap: () {
        Navigator.of(context).pushNamed(DetailScreen.routeName);
      },
    );
  }
}