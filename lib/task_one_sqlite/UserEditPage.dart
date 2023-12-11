
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sampleapp/task_one_sqlite/ProfilePage.dart';
import 'db/MyDb.dart';


class UserEditPage extends StatefulWidget {
  int mobilenumber;
  UserEditPage({required this.mobilenumber}); //constructor for class
  @override
  _UserEditPageState createState() => _UserEditPageState();

}

class _UserEditPageState extends State<UserEditPage> {

  TextEditingController firstNameControllers = new TextEditingController();
  TextEditingController lastNameControllers = new TextEditingController();
  TextEditingController emailControllers = new TextEditingController();
  TextEditingController dateInputControllers = TextEditingController();
  TextEditingController mobilenmberControllers = new TextEditingController();
  TextEditingController addressControllers = new TextEditingController();

  List<Map> slist = [];
  MyDb mydb = new MyDb();
  bool hidePass = true;
  bool _validatemobilenumber = false;
  bool _validateaddress = false;
  String mobileStr = '';
  String addressStr = '';
  int? userid =null;

  String? useremail;
  String?  userfirstname;
  String?  userlastname;
  String?   usermobilenumber;
  String?   useraddress;
  String?   userdateofbirth;

  bool _validatename = false;
  bool _validatelastname = false;
  bool _validateemail = false;
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  // Declare the variable
  String nameStr = '';
  String lastnameStr = '';
  String mailStr = '';

  @override
  void initState() {
    mydb.open();
    Future.delayed(Duration(milliseconds: 500), () async {

      var data = await mydb.getUserdetails(widget.mobilenumber); //widget.rollno is passed paramater to this class
      print("dataddd"+data.toString());
      if(data != null){
        setState(() {
          // userid = data["id"];
          userfirstname = data["firstname"];
          userlastname = data["lastname"].toString() ;
          useremail= data["email"];
          userdateofbirth = data["dateofbirth"];
          usermobilenumber = data["mobilenumber"].toString();
          useraddress = data["address"];
          print("userfirstnameasc"+userfirstname.toString());
          print("Nrffffffffffffffffd " + widget.mobilenumber.toString());
        });



      }else{
        print("No any data with id: " + widget.mobilenumber.toString());
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Page"),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [


                Container(
                  margin: EdgeInsets.only(top: 50,left: 20,right: 20),
                  child: TextField(
                    controller:firstNameControllers = TextEditingController(text: userfirstname.toString()),
                    maxLength: 20,
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp("[a-z A-Z]")),
                    ],
                    keyboardType: TextInputType.text,
                    // onChanged: (value) {
                    //   setState(() {
                    //     value.isEmpty
                    //         ? _validatename = true
                    //         : _validatename = false;
                    //   });
                    // },
                    decoration: InputDecoration(
                        counter: Offstage(),
                      //  errorText: _validatename ? nameStr : null,
                        border: OutlineInputBorder(),
                        labelText: 'First Name'),
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller:lastNameControllers = TextEditingController(text: userlastname.toString()),
                    maxLength: 20,
                    // inputFormatters: [
                    //   new FilteringTextInputFormatter.allow(
                    //       RegExp("[a-z A-Z]")),
                    // ],
                    keyboardType: TextInputType.text,
                    // onChanged: (value) {
                    //   setState(() {
                    //     value.isEmpty
                    //         ? _validatelastname = true
                    //         : _validatelastname = false;
                    //   });
                    // },
                    decoration: InputDecoration(
                      counter: Offstage(),
                      // errorText: _validatelastname
                      //     ? lastnameStr
                      //     : null,
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller:emailControllers = TextEditingController(text: useremail.toString()),

                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          new RegExp('[\\ |\\"]'))
                    ],
                    // onChanged: (value) {
                    //   setState(() {
                    //     value.isEmpty
                    //         ? _validateemail = true
                    //         : _validateemail = false;
                    //   });
                    // },
                    decoration: InputDecoration(
                        counter: Offstage(),
                        border: OutlineInputBorder(),
                      //  errorText: _validateemail ? mailStr : null,

                        labelText: 'Email ID'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Date of Birth',
                      suffixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green, width: 1)),
                    ),
                    controller:dateInputControllers = TextEditingController(text: userdateofbirth.toString()),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050));

                      if (pickedDate != null) {
                        dateInputControllers.text =
                            DateFormat('yyyy-MM-dd').format(
                                pickedDate);
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller:mobilenmberControllers = TextEditingController(text: usermobilenumber.toString()),

                    maxLength: 10,
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp("[0-9]")),
                    ],
                    keyboardType: TextInputType.number,
                    // onChanged: (value) {
                    //   setState(() {
                    //     value.isEmpty
                    //         ? _validatemobilenumber = true
                    //         : _validatemobilenumber = false;
                    //   });
                    // },
                    decoration: InputDecoration(
                        counter: Offstage(),
                        // errorText: _validatemobilenumber
                        //     ? mobileStr
                        //     : null,
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                        hintText: 'Mobile Number'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller:addressControllers = TextEditingController(text: useraddress.toString()),

                    maxLength: 20,
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp("[a-z A-Z]")),
                    ],
                    keyboardType: TextInputType.text,
                    // onChanged: (value) {
                    //   setState(() {
                    //     value.isEmpty
                    //
                    //         ? _validateaddress = true
                    //         : _validateaddress = false;
                    //   });
                    // },
                    decoration: InputDecoration(
                        counter: Offstage(),
                       // errorText: _validateaddress ? addressStr : null,
                        border: OutlineInputBorder(),
                        labelText: 'Address'),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.only(top: 30, bottom: 30,left: 10,right: 10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    onPressed: () {
                      getvalue();
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

              ],
            )));
  }

  showandhide() {
    setState(() {
      hidePass = !hidePass;
    });
  }

  void getvalue() async{

    mydb.db?.rawInsert("UPDATE user_profiles SET firstname = ?, lastname = ?, email = ?, dateofbirth = ?, mobilenumber = ?, address = ? WHERE mobilenumber= ?",
        [firstNameControllers.text, lastNameControllers.text, emailControllers.text,dateInputControllers.text,mobilenmberControllers.text,addressControllers.text,usermobilenumber]);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User details updated.")));
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ProfilePage()));

    // firstNameController.text = "";
    // lastNameController.text = "";
    // emailController.text = "";
    // dateInputController.text = "";
    // mobilenmberController.text = "";
    // addressController.text = "";

    //
    // slist = (await mydb.db?.rawQuery('SELECT * FROM user_profiles ORDER BY firstname;'))!;
    // print("sdfsdcfsd"+slist.toString());

  }
}