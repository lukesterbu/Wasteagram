import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import '../models/post_dto.dart';
import '../widgets/wasteagram_scaffold.dart';

class PhotoScreen extends StatefulWidget {

  static const routeName = 'photo_screen';

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  File image;
  LocationData location;
  String url;

  final _formKey = GlobalKey<FormState>();
  final post = PostDTO();

  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    location = await locationService.getLocation();
    setState( () {});
  }

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState( () {});
  }

  Future uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('${Timestamp.now()}pic');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
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
        Image.file(
          image,
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .5,
        ),
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
      onSaved: (value) {
        post.quantity = num.parse(value);
      },
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
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          // Save the form
          _formKey.currentState.save();
          // Add image to firebase storage
          await uploadImage();
          // Create database transfer object
          post.imageURL = url;
          post.location = GeoPoint(location.latitude, location.longitude);
          // Add to database
          post.addToFirestore();
          // Navigate back to list_screen
          Navigator.of(context).pop();
        }
      },
    );
  }
}