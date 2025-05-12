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

  String apiUrl = "https://jsonplaceholder.typicode.com/users";

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    try {
      if (response.statusCode == 200) {
        final get_data = jsonDecode(response.body);
        for (var index in get_data) {
          data.add(index);
        }
        setState(() {});
        // print(data[0]['name']);
        print("Data fetched successfully");
      } else {
        print("Failed to fetch data ${response.statusCode}");
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
          title: Text('${data[index]['id']}. User Name: ${data[index]['name']}'),
          subtitle: Text("User Email: ${data[index]['email']}"),
        );
      },
    ));
  }
}
