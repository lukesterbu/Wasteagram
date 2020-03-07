import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/wasteagram_scaffold.dart';

class PhotoScreen extends StatefulWidget {

  static const routeName = 'photo_screen';

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  File image;

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState( () {});
  }

  @override
  Widget build(BuildContext context) {
    return WastegramScaffold(
      title: 'Wasteagram',
      child: imagePicker(context),
    );
  }

  Widget imagePicker(BuildContext context) {
    if (image == null) {
      return RaisedButton(
        child: Text('Select Photo'),
        onPressed: () {
          getImage();
        }
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(image),
          SizedBox(height: 40),
          RaisedButton(
            child: Text('Post It!'),
            onPressed: () {

            },
          )
        ],
      );
    }
  }
}