import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'UserUpdatePage.dart';
import 'db/MyDb.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<ProfilePage> {

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  TextEditingController mobilenmberController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  List<Map> slist = [];
  MyDb mydb = new MyDb();
  bool _validateaddress = false;
  String mobileStr = '';
  String addressStr = '';
  bool _validatename = false;
  bool _validatelastname = false;
  bool _validateemail = false;
  bool _validatemobilenumber = false;
  bool _validateDate = false;
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String nameStr = '';
  String lastnameStr = '';
  String mailStr = '';
  String dateStr = '';

  @override
  void initState() {
    mydb.open();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile Page"),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50,left: 20,right: 20),
                  child: TextField(
                    controller: firstNameController,
                    maxLength: 20,
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp("[a-z A-Z]")),
                    ],
                    keyboardType: TextInputType.text,
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
                        labelText: 'First Name'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller: lastNameController,
                    maxLength: 20,
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp("[a-z A-Z]")),
                    ],
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        value.isEmpty
                            ? _validatelastname = true
                            : _validatelastname = false;
                      });
                    },
                    decoration: InputDecoration(
                      counter: Offstage(),
                      errorText: _validatelastname
                          ? lastnameStr
                          : null,
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          new RegExp('[\\ |\\"]'))
                    ],
                    onChanged: (value) {
                      setState(() {
                        value.isEmpty
                            ? _validateemail = true
                            : _validateemail = false;
                      });
                    },
                    decoration: InputDecoration(
                        counter: Offstage(),
                        border: OutlineInputBorder(),
                        errorText: _validateemail ? mailStr : null,

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
                    controller: dateInputController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050));

                      if (pickedDate != null) {
                        dateInputController.text =
                            DateFormat('yyyy-MM-dd').format(
                                pickedDate);
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                //   child: TextFormField(
                //     // controller: TextEditingController(text: evuserpassword.toString()),
                //     controller: passwordController = TextEditingController(text: evuserpassword.toString()),
                //     obscureText: hidePass,
                //     // the bool we declared earlier
                //     decoration: InputDecoration(
                //       labelText: 'Password',
                //       counter: Offstage(),
                //       border: OutlineInputBorder(),
                //       suffixIcon: IconButton(
                //         icon: Icon(Icons.visibility),
                //         onPressed: () {
                //           showandhide();
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                //   child: TextFormField(
                //     obscureText: hidePass,
                //     controller: confirmpasswordController = TextEditingController(text: evuserpassword.toString()),
                //     decoration: InputDecoration(
                //       labelText: 'Confirm Password',
                //       counter: Offstage(),
                //       border: OutlineInputBorder(),
                //       suffixIcon: IconButton(
                //         icon: Icon(Icons.visibility),
                //         onPressed: () {
                //           showandhide();
                //         },
                //       ),
                //     ),
                //   ),
                //
                // ),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller: mobilenmberController,
                    maxLength: 10,
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp("[0-9]")),
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        value.isEmpty
                            ? _validatemobilenumber = true
                            : _validatemobilenumber = false;
                      });
                    },
                    decoration: InputDecoration(
                        counter: Offstage(),
                        errorText: _validatemobilenumber
                            ? mobileStr
                            : null,
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                        hintText: 'Mobile Number'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextField(
                    controller: addressController,
                   maxLength: 20,
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp("[a-z A-Z]")),
                    ],
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        value.isEmpty

                            ? _validateaddress = true
                            : _validateaddress = false;
                      });
                    },
                    decoration: InputDecoration(
                        counter: Offstage(),
                        errorText: _validateaddress ? addressStr : null,
                        border: OutlineInputBorder(),
                        labelText: 'Address'),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      margin: EdgeInsets.only(top: 30, bottom: 30,left: 10,right: 10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: MaterialButton(
                        onPressed: () {
                          RegExp regex = new RegExp(pattern);

                          _validateInput(regex);

                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
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
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => UserUpadatePage()));
                        },
                        child: Text(
                          'User List',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )


              ],
            )));
  }



  void getvalue() async{
    int? a = await mydb.db?.rawInsert("INSERT INTO user_profiles (firstname, lastname, email,dateofbirth,mobilenumber,address) VALUES (?, ?, ?, ?, ?, ?);",
        [firstNameController.text, lastNameController.text, emailController.text,dateInputController.text,mobilenmberController.text,addressController.text]) ; //add student from form to database



    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User details added.")));
    print("bdjgdgjdjd"+a.toString());

    if(a==null){

    }else{

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => UserUpadatePage()));
    }
    // firstNameController.text = "";
    // lastNameController.text = "";
    // emailController.text = "";
    // dateInputController.text = "";
    // mobilenmberController.text = "";
    // addressController.text = "";


  }

  void _validateInput(RegExp regex) {
    if(firstNameController.text.isEmpty){
      setState(() {
        nameStr = "First Name can\'t be empty";
        firstNameController.text.isEmpty ? _validatename = true : _validatename = false;
      });
    }else if(lastNameController.text.isEmpty){
      setState(() {
        lastnameStr = "Last Name can\'t be empty";
        lastNameController.text.isEmpty ? _validatelastname = true : _validatelastname = false;
      });
    }
    else if (emailController.text.isEmpty) {
      setState(() {
        mailStr = "Email can\'t be empty ";
        emailController.text.isEmpty ? _validateemail = true : _validateemail = false;
      });
    } else if (!regex.hasMatch(emailController.text)) {
      mailStr = "Enter a valid email";
      setState(() {
        (!regex.hasMatch(emailController.text))
            ? _validateemail = true
            : _validateemail = false;
      });
    }
    else if (mobilenmberController.text.isEmpty) {
      mobileStr = "Mobile Number can\'t be empty must be 10 digits";
      setState(() {

        mobilenmberController.text.length < 10
            ? _validatemobilenumber = true
            : _validatemobilenumber = false;
      });
    }
    else if (dateInputController.text.isEmpty) {
      print('emty*******');
      var snackBar = SnackBar(
          content: Text("Please select the date of birth".toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        dateStr = "Date can\'t be empty ";
        dateInputController.text.isEmpty ? _validateDate = true : _validateDate =
        false;
      });

    }
    else if (addressController.text.isEmpty) {
      setState(() {
        addressStr = "Address can\'t be empty";
        addressController.text.isEmpty ? _validateaddress = true : _validateaddress = false;
      });
    }else{
      getvalue();
    }

  }
}