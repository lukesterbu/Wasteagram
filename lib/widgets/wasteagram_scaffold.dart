import 'package:flutter/material.dart';

class WastegramScaffold extends StatelessWidget {
  const WastegramScaffold({Key key, this.title, this.child, this.fab}) : super(key : key);

  final String title;
  final Widget child;
  final Widget fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Center(
        child: child
      ),
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}