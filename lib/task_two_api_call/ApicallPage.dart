import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Api/Api.dart';


class ApicallPage extends StatefulWidget {
  @override
  _ApicallPageState createState() => _ApicallPageState();
}

class _ApicallPageState extends State<ApicallPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _validatename = false;
  bool _validateemail = false;

  String? nameStr = '';
  String? emailStr = '';


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Apicall"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    value.isEmpty
                        ? _validatename = true
                        : _validatename = false;
                  });
                },
                decoration: InputDecoration(
                    counter: Offstage(),
                    errorText: _validatename ? nameStr : null,
                    border: OutlineInputBorder(),
                    labelText: 'Name'),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextField(

                controller: emailController,
                onChanged: (value) {
                  setState(() {
                    value.isEmpty
                        ? _validateemail = true
                        : _validateemail = false;
                  });
                },
                decoration: InputDecoration(
                  counter: Offstage(),
                  errorText: _validateemail ? emailStr : null,
                  border: OutlineInputBorder(),
                  labelText: 'Email',

                ),
              ),
            ),
            Container(
              child:ElevatedButton(
                onPressed: (){
                  _postData();
                },
               child:Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _postData()async {
    String url = Api.URL_JSON_POST;
    print("url********* ${url}");

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    Map data = {
      "title": nameController.text,
      "body": emailController.text
    };
    final postRequestJson = jsonEncode(data);
    /*Check Internet Connecticity*/
    print('*****postRequestJsont***** $postRequestJson');
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //await pr.show();
        /*Internet Present make Login request*/
        final postResponse = await http.post(Uri.parse(url),
            headers: headers, body: postRequestJson);
        // check the status code in response
        print("*****postResponse*****" + postResponse.body);
        Map<String, dynamic> data =
        new Map<String, dynamic>.from(json.decode(postResponse.body));
        print("reesponse**** $data");
      if(postResponse.statusCode == 201){
        String datssa = data["title"].toString();
        String aaa = data["body"].toString();
        var snackBar = SnackBar(content: Text("Title :"+ datssa.toString()+" "+"body :"+aaa.toString()));
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        var snackBar = SnackBar(content: Text("Title :"+ data.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
