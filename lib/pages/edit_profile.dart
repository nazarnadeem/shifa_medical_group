import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shifa_medical_group/pages/upload_profile_pic.dart';
import 'package:shifa_medical_group/utils/constants.dart';

import 'home.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  static final String uploadEndPoint =
      'https://humfans.com/medical_app/api/upload_prescription.php?user_id=';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery) as Future<File>;
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.setBool("isLoggedIn", true);
    var userId = sharedPreferences.getInt('myId').toString();
    var Myheaders = {
      "key": "B94E6C49088D75EDEA5B50E0FE98AB12",
    };
    String fullUrl = uploadEndPoint+userId;
    http.post(fullUrl, headers: Myheaders, body: {
      "prescription": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

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
                  onPressed: () {},
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
                    Icons.sentiment_very_dissatisfied_sharp,
                    size: 24,
                    color: mainColor,
                  ),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () {
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
            padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
            child: Column(
              children: [
                CircleAvatar(
                  maxRadius: 50,
                  child: Image.asset('assets/images/profile.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: MaterialButton(
                    onPressed: () {
                      chooseImage();
                    },
                    elevation: 0,
                    color: mainColor,
                    textColor: Colors.white,
                    child: Text('Change Picture'),
                  ),
                ),
                Padding(padding: EdgeInsets.all(15),
                child: showImage(),),
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
                  child: Text("Update"),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}



