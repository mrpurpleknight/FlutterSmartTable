import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/communication/request_data.dart';
import 'package:throttling/throttling.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final Debouncing _deb = Debouncing(duration: Duration(milliseconds: 700));

  @override
  Widget build(BuildContext context) {
    RequestData requestData = Provider.of<RequestData>(context, listen: false);
    TextEditingController controller = TextEditingController();
    return Card(
      child: new ListTile(
        leading: Icon(Icons.search),
        title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: (value) {
              _deb.debounce(() {
                requestData.searchString = controller.text;
              });
            }),
        trailing: new IconButton(
          icon: new Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              controller.text = '';
            });
            requestData.searchString = null;
          },
        ),
      ),
    );
  }
}
