import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/wasteagram_scaffold.dart';

class PhotoScreen extends StatefulWidget {

  static const routeName = 'photo_screen';

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  File image;
  final _formKey = GlobalKey<FormState>();

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
      return Form(
        key: _formKey,
        child: formLayout(context)
      );
    }
  }

  Widget formLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.file(image),
        SizedBox(height: 40),
        // Number of items field
        numItems(context),
        postButton(context),
      ],
    );
  }

  Widget numItems(BuildContext context) {
    return TextFormField(
      autofocus: true,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a quantity of items!';
        }
        else if (num.parse(value) == 0) {
          return 'Please enter a quantity greater than 0!';
        }
        return null;
      },
    );
  }

  Widget postButton(BuildContext context) {
    return RaisedButton(
      child: Text('Post It!'),
      onPressed: () {
        // Get Form Data
        // Create database transfer object
        // Add to database
        // Navigate back to list_screen
        Navigator.of(context).pop();
      },
    );
  }
}