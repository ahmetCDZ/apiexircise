import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ApiExercise());
}

class ApiExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedItem;
  var data;
  var parsed;
  var apiKey = 'AIzaSyADWf-GbpG6mCOSa2zTIQiLQdZKihhwbkg';
  List<String> lastStatus = [];

  Future<void> myGif(String word) async {
    data = await http.get(Uri.parse(
        "https://tenor.googleapis.com/v2/search?q=$selectedItem&key=AIzaSyADWf-GbpG6mCOSa2zTIQiLQdZKihhwbkg&client_key=my_test_app&limit=8"));
    parsed = jsonDecode(data.body);
    lastStatus.clear();
    setState(() {});
  }

  @override
  void initState() {
    myGif('Batman');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ahmet'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  selectedItem = value;
                },
              ),
              Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: ListView(
                    children: [
                      ElevatedButton(
                          onPressed: (() async {
                            await myGif(selectedItem);

                            lastStatus =
                                parsed['results'][1]['media_formats']['mp4'];
                          }),
                          child: Text('Gif Getir')),
                      Container(
                        child: Image(image: NetworkImage(data)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
