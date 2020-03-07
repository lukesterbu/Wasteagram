import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/wasteagram_scaffold.dart';

class DetailScreen extends StatefulWidget {

  static const routeName = 'detail_screen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  Image image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Post args = ModalRoute.of(context).settings.arguments;

    return WastegramScaffold(
      title: 'Wasteagram',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(args.date.toString()),
          Placeholder(),
          Text(args.quantity.toString()),
          Text('(${args.latitude}, ${args.longitude})')
        ],
      )
    );
  }
}