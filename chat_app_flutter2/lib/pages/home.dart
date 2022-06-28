import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/massages.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["chats"];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(),
          ),
          Padding(
            padding:
                size.width > 600 ? EdgeInsets.all(25.0) : EdgeInsets.all(16.0),
            child: const Text(
              "Chat with \nyour friends",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('Load Data'),
            onPressed: readJson,
          ),
          _items.isNotEmpty
              ? Expanded(
                  child: Container(
                    height: 537,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0))),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(_items[index]["userName"]),
                          subtitle: Text(_items[index]["massage"]),
                          leading: Image.network(_items[index]["img"]),
                        );
                      },
                    ),
                  ),
                )
              : Container(),
          /*
          _items.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.network(
                            _items[index]["img"],
                          ),
                          title: Text(_items[index]["userName"]),
                          subtitle: Text(_items[index]["massage"]),
                        ),
                      );
                    },
                  ),
                )
              : Container(),*/
        ],
      ),
    );
  }
}
