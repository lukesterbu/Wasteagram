import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../widgets/wasteagram_scaffold.dart';

class DetailScreen extends StatefulWidget {

  static const routeName = 'detail_screen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  DateTime date;
  Image image;
  int items;
  LocationData locationData;

  @override
  void initState() {
    super.initState();
    getNumItems();
    retrieveLocation();
  }

  void getNumItems() {
    items = 0;
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {});
  }

  @override
  Widget build(BuildContext context) {
    return WastegramScaffold(
      title: 'Wasteagram',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Date'),
          Placeholder(),
          numItems(context),
          location(context)
        ],
      )
    );
  }

  Widget numItems(BuildContext context) {
    return Text('Items: $items');
  }

  Widget location(BuildContext context) {
    if (locationData == null) {
      return CircularProgressIndicator();
    } else {
      return Text('(${locationData.latitude}, ${locationData.longitude})');
    }
  }
}