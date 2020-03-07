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

    final Post post = ModalRoute.of(context).settings.arguments;

    return WastegramScaffold(
      title: 'Wasteagram',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(post.getFormattedDateYear(), style: TextStyle(fontSize: 24.0)),
            SizedBox(height: 10.0),
            imageLoading(context, post),
            SizedBox(height: 10.0),
            Text('Items: ${post.quantity.toString()}', style: TextStyle(fontSize: 24.0)),
            SizedBox(height: 10.0),
            Text('(${post.latitude}, ${post.longitude})')
          ],
        ),
      )
    );
  }

  Widget imageLoading(BuildContext context, Post post) {
    return Image.network(
      post.imageURL.toString(),
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.width * .5,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .5,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                  : null,
            )
          )
        );
      },
    );
  }
}