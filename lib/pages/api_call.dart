import 'dart:convert';

import 'package:api_demo/pages/insert_user/insert_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiCall extends StatefulWidget {
  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return InsertUserPage(null);
              },
            )).then((value) {
              if (value == true) {
                setState(() {});
              }
            });
          },
        )
      ]),
      body: FutureBuilder<http.Response>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: jsonDecode(snapshot.data!.body.toString()).length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  (jsonDecode(snapshot.data!.body.toString())[
                                  index]['name'])
                                      .toString(),
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                  (jsonDecode(snapshot.data!.body.toString())[
                                  index]['City'])
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),

                            ],
                          ),
                        ),
                        InkWell(
                          child: Icon(
                              (!getBoolFromDynamic(snapshot.data!, index))
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              color: Colors.amber),
                          onTap: () async {
                            http.Response res = await updateFavorite(
                                (jsonDecode(snapshot.data!.body.toString())[
                                index]['id']),
                                !getBoolFromDynamic(snapshot.data!, index));
                            if (res.statusCode == 200) {
                              setState(() {});
                            }
                          },
                        ),
                        InkWell(
                          child: Icon(Icons.delete, color: Colors.red.shade300),
                          onTap: () {
                            showDeleteAlert((jsonDecode(
                                snapshot.data!.body.toString())[index]['id']));
                          },
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey.shade300)
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: getDataFromWebServer(),
      ),
    );
  }

  void showDeleteAlert(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert!'),
          content: Text('Are you sure want to delete this record?'),
          actions: [
            TextButton(
              onPressed: () async {
                http.Response res = await deleteUserFromWeb(id);
                if (res.statusCode == 200) {
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  bool getBoolFromDynamic(data, index) {
    try {
      return jsonDecode(data.body.toString())[index]['IsFavorite'] as bool;
    } catch (e) {
      try {
        return
          jsonDecode(data.body.toString())[index]['IsFavorite']
              .toString()
              .toLowerCase() == 'true';
      } catch (e) {
        return false;
      }
    }
  }


  Future<http.Response> deleteUserFromWeb(id) async {
    var response = await http.delete(
        Uri.parse('https://638029948efcfcedacfe0228.mockapi.io/api/user/$id'));
    return response;
  }

  Future<http.Response> updateFavorite(id, value) async {
    Map<String, dynamic> map = {};
    map["IsFavorite"] = value.toString();
    var response = await http.put(
        Uri.parse('https://638029948efcfcedacfe0228.mockapi.io/api/user/$id'),
        body: map);
    return response;
  }

  Future<http.Response> getDataFromWebServer() async {
    var response = await http
        .get(Uri.parse('https://638029948efcfcedacfe0228.mockapi.io/api/user'));
    return response;
  }
}
