import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List<dynamic> data = [];

  Future<void> _fetchData() async {
    String api_url = "https://jsonplaceholder.typicode.com/users";
    try {
      final response = await http.get(Uri.parse(api_url));
      // print(response.body);
      if (response.statusCode == 200) {
        final get_data = jsonDecode(response.body);
        for (var index in get_data) {
          data.add(index);
        }
        // print(get_data["name"]);
        print("Data fetched successfully");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${data[index]["id"]}. name goes here ${data[index]["name"]}"),
              subtitle: Text("username goes here ${data[index]["username"]}"),
            );
          }),
    );
  }
}
