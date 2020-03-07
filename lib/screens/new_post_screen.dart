import 'package:flutter/material.dart';
import '../widgets/wasteagram_scaffold.dart';

class NewPostScreen extends StatelessWidget {

  static const routeName = 'new_post_screen';

  @override
  Widget build(BuildContext context) {
    return WastegramScaffold(
      title: 'Wasteagram',
      child: Placeholder(),
    );
  }
}