import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sampleapp/task_one_sqlite/ProfilePage.dart';

import 'UserEditPage.dart';
import 'db/MyDb.dart';


class UserUpadatePage extends StatefulWidget {
  @override
  _UserUpadatePageState createState() => _UserUpadatePageState();

}

class _UserUpadatePageState extends State<UserUpadatePage> {

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  TextEditingController mobilenmberController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  List<Map> slists = [];
  MyDb mydb = new MyDb(); //mydb new object from db.dart
  bool hidePass = true;
  bool _validatemobilenumber = false;
  bool _validateaddress = false;
  String mobileStr = '';
  String addressStr = '';

  bool _validatename = false;
  bool _validatelastname = false;
  bool _validateemail = false;
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  // Declare the variable
  String nameStr = '';
  String lastnameStr = '';
  String mailStr = '';
  String dateStr = '';
  String distStr = '';

  @override
  void initState() {
    mydb.open();
    getUi();
    super.initState();

  }
  void getUi() async{


    Future.delayed(Duration(milliseconds: 500),() async {
      //use delay min 500 ms, because database takes time to initilize.
      if(mydb.db==null){

      }else{
        slists = (await mydb.db?.rawQuery('SELECT * FROM user_profiles'))!;
      }

      setState(() { });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Edit User details"),
    ),
    body:
    SingleChildScrollView(
      child: Container(
        child: slists.length == 0?Text("No any students to show."): //show message if there is no any student
        Column(  //or populate list to Column children if there is student data.
          children: slists.map((stuone){
            return Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    width: double.infinity,
                    height: 30,
                    child: Text("First name : "+stuone["firstname"]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    width: double.infinity,
                    height: 30,
                    child: Text("Last name : "+stuone["lastname"]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    width: double.infinity,
                    height: 30,
                    child: Text("Email : "+stuone["email"]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    width: double.infinity,
                    height: 30,
                    child: Text("Date of birth : "+stuone["dateofbirth"]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    width: double.infinity,
                    height: 30,
                    child: Text("Mobilenumber :"+stuone["mobilenumber"].toString()),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    width: double.infinity,
                    height: 30,
                    child: Text("Address : "+stuone["address"]),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                       //navigate to edit page, pass student roll no to edit
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => UserEditPage(mobilenumber:stuone["mobilenumber"])));

                      }, icon: Icon(Icons.edit)),


                      IconButton(onPressed: () async {
                        if(mydb.db==null){

                        }else{
                          mydb.db?.rawDelete("DELETE FROM user_profiles WHERE id = ?", [stuone["id"]]);
                          //delete student data with roll no.
                          print("Data Deleted");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Data Deleted")));

                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => ProfilePage()));
                        }
                      }, icon: Icon(Icons.delete, color:Colors.red))
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ),
    );
  }




}