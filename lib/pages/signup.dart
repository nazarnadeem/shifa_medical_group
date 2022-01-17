import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifa_medical_group/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:shifa_medical_group/utils/constants.dart';

import 'home.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var random = Random.secure();

    var values = List<int>.generate(4, (i) =>  random.nextInt(255));

    nameController.text="Hello";
    phoneController.text=values.join().toString();
    passwordController.text="12345";
    addressController.text="1233sdsd";

  }

  Future registration() async {
    setState(() {
      visible = true;
    });

    String name = nameController.text;
    String phone = phoneController.text;
    String password = passwordController.text;
    String address = addressController.text;

    var url = "https://humfans.com/medical_app/manage/api/user_register/add";

    var Myheaders = {
      "X-Api-Key": "B94E6C49088D75EDEA5B50E0FE98AB12",
    };
    var data = {
      'user_id': 'user_id',
      'user_name': name,
      'user_mobile': phone,
      'user_password': password,
      'user_address': address,
    };

    var response =
        await http.post(Uri.parse(url), headers: Myheaders, body: data);
    Map<String, dynamic> message = jsonDecode(response.body);
    print(message);
    var id = message['user_id'];
    if (response.statusCode == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences?.setBool("isLoggedIn", true);
      sharedPreferences.setInt('myId', id).toString();
      setState(() {
        visible = false;
        void dispose() {}
      });
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var status = sharedPreferences.getBool("isLoggedIn") ?? false;
    print(status);
    showDialog(
        context: context,
        builder: (BuildContext) {
          if (response.statusCode == 200) {
            return AlertDialog(
              title: Row(
                children: [
                  Text(
                    "Account created successfully",
                    style: TextStyle(fontSize: 13),
                  ),
                  Icon(
                    Icons.sentiment_very_satisfied_sharp,
                    color: mainColor,
                  ),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              status == true ? Home() : Signup(),
                        ),
                        (Route<dynamic> route) => false);
                    /*   Navigator.of(context).pushReplacement(
                    (MaterialPageRoute(
                      builder: (context) => status == true ? Home() : Signup(),
                    )),
                  );
                */
                  },
                  child: Text(
                    "Okay",
                    style: TextStyle(color: mainColor),
                  ),
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: Row(
                children: [
                  Text(
                    "Mobile no already registered or \n server error",
                    style: TextStyle(fontSize: 13),
                  ),
                  Icon(
                    Icons.sentiment_very_dissatisfied_sharp,size: 24,
                    color: mainColor,
                  ),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup(),
                        ),
                        (Route<dynamic> route) => false);
                    /*   Navigator.of(context).pushReplacement(
                    (MaterialPageRoute(
                      builder: (context) => status == true ? Home() : Signup(),
                    )),
                  );
                */
                  },
                  child: Text("Okay"),
                ),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.green,
        title: Text(appTitle),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 200, 10, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: nameController,
                    style: TextStyle(color: Colors.green),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 4),
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                        hintText: "Enter your full name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 5,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.green),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 4),
                        ),
                        labelText: "Phone",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                        hintText: "Enter your phone no",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 5,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.green),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 4),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 5,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    controller: addressController,
                    style: TextStyle(color: Colors.green),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 4),
                        ),
                        labelText: "Address",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                        hintText: "Enter your complete address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 5,
                          ),
                        )),
                  ),
                ),
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      registration();
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text("Submit"),
                ),
                Visibility(
                  visible: visible,
                  child: (Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        textColor: Colors.green,
                        child: Text(
                          "Login",
                        ),
                        minWidth: 0.5,
                        padding: EdgeInsets.all(0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
