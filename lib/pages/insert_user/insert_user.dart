import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertUserPage extends StatefulWidget {
  InsertUserPage(this.map);

  Map? map;

  @override
  State<InsertUserPage> createState() => _InsertUserPageState();
}

class _InsertUserPageState extends State<InsertUserPage> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var dobController = TextEditingController();

  var cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.map == null ? '' : widget.map!['name'];
    dobController.text = widget.map == null ? '' : widget.map!['Dob'];
    cityController.text = widget.map == null ? '' : widget.map!['City'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
                decoration: InputDecoration(hintText: 'Enter Name'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter Valid Name";
                  }
                },
                controller: nameController),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter Dob'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Enter Valid Dob";
                }
              },
              controller: dobController,
            ),
            TextFormField(
                decoration: InputDecoration(hintText: 'Enter City'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter Valid City";
                  }
                },
                controller: cityController),
            TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.map == null) {
                      insertUser()
                          .then((value) => Navigator.of(context).pop(true));
                    } else {
                      updateUser(widget.map!['id'])
                          .then((value) => Navigator.of(context).pop(true));
                    }
                  }
                },
                child: Text('Submit'))
          ])),
    );
  }

  Future<void> updateUser(id) async {
    Map map = {};
    map["name"] = nameController.text;
    map["Dob"] = dobController.text;
    map["City"] = cityController.text;

    var response1 = await http.put(
        Uri.parse('https://638029948efcfcedacfe0228.mockapi.io/api/user/$id'),
        body: map);
    print(response1.body);
  }

  Future<void> insertUser() async {
    Map map = {};
    map["name"] = nameController.text;
    map["Dob"] = dobController.text;
    map["City"] = cityController.text;

    var response1 = await http.post(
        Uri.parse('https://638029948efcfcedacfe0228.mockapi.io/api/user'),
        body: map);
    print(response1.body);
  }
}
