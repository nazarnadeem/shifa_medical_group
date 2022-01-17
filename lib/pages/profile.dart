import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifa_medical_group/pages/home.dart';
import 'package:shifa_medical_group/pages/prescriptions.dart';
import 'package:shifa_medical_group/utils/constants.dart';
import 'edit_profile.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

Future<Data> fetchData(int id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences?.setBool("isLoggedIn", true);
  var userId = sharedPreferences.getInt('myId').toString();
  String baseUrl =
      'https://humfans.com/medical_app/api/user_profile.php?user_id=';
  String fullUrl = baseUrl + userId;
  final response = await http.get(Uri.parse(fullUrl));
  print(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Data.fromJson(jsonDecode(response.body));
    return Data.fromJson(
      json.decode(response.body),
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Data');
  }
}

class Data {
  final String userName;
  final String userPhone;
  final String userAddress;
  final String userImage;

  Data({
    @required this.userName,
    @required this.userPhone,
    @required this.userAddress,
    @required this.userImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userName: json['name'],
      userPhone: json['mobile'],
      userAddress: json['address'],
      userImage: json['image'],
    );
  }
}

class Profile extends StatefulWidget {
  int id;

  Profile({this.id});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Data> userData;

  @override
  void initState() {
    super.initState();
    userData = fetchData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.green,
        title: Text("Shifa Medical Group"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  iconSize: 40,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Prescriptions(),
                        ));
                  },
                  icon: Icon(
                    Icons.file_copy,
                    color: Colors.green,
                  ),
                  iconSize: 30,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  iconSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: FutureBuilder<Data>(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Text(snapshot.data.userName);
                return ListView(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                        "Welcome " + snapshot.data.userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green),
                      )),
                    ),
                    Center(
                      child: GestureDetector(
                        child: CircleAvatar(
                          maxRadius: 60,
                          child: Image.network(snapshot.data.userImage, errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/profile.png');
                          },),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            title: Text(
                              snapshot.data.userName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            title: Text(
                              snapshot.data.userPhone,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            title: Text(
                              snapshot.data.userAddress,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                        },
                        elevation: 0,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        color: mainColor,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Kindly Login");
              }
              // By default, show a loading spinner.
              return Center(
                child: const CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
