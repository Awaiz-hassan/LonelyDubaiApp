import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Themes/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/update_user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password = TextEditingController();
  final _confPassword = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfPass = true;
  bool isLoading = false;
  int userId = -1;

  @override
  void initState() {
    getUSerDetails();
    super.initState();
  }

  showLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          isLoading = true;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
                height: 200,
                child: Center(
                    child: Lottie.asset('assets/animations/loading.json',
                        height: 60.0))),
          );
        }).then((_) => isLoading = false);
  }

  showMessageDialog(String imagePath, String message, Color color) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: SvgPicture.asset(
                          imagePath,
                          height: 45,
                          color: color,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 40, left: 20, right: 20),
                          child: Text(
                            message,
                            style:
                                TextStyle(fontSize: 16, color: AppTheme.black),
                            textAlign: TextAlign.center,
                          )),
                    )
                  ],
                )),
          );
        });
  }

  void updateUserDetails(
      int userId, String fullName, String email, String password) async {
    showLoadingDialog();
    final prefs = await SharedPreferences.getInstance();
    var token= prefs.getString("key");
    var client = http.Client();

    try {
      String url =
          "https://lonelydubai.com/booking/public/api/updateUser/$userId?name=$fullName&email=$email&password=$password&conf_password=$password";
      var response = await client.post(Uri.parse(url),headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      print("status        "+response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonString = response.body;
        UpdateUser updateUser = updateUserFromJson(jsonString);
        if (updateUser.code == 200) {
          if (isLoading) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          await prefs.setString('username', _fullNameController.text.trim());
          await prefs.setString('email', _emailController.text.trim());
          showMessageDialog("assets/icons/success.svg", "User details updated!",
              Colors.green);
        } else if (updateUser.code == 300) {
          if (isLoading) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showMessageDialog(
              "assets/icons/error.svg", "Email already exists!", Colors.red);
        } else {
          if (isLoading) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showMessageDialog(
              "assets/icons/error.svg", "Error updating user!!", Colors.red);
        }
      } else {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        showMessageDialog(
            "assets/icons/error.svg", "Error updating user!", Colors.red);
      }
    } on Exception {
      if (isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  void getUSerDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var logged = prefs.getBool('user_logged');
    if (logged != null) {
      if (logged) {
        userId = prefs.getInt('id')!;
        _fullNameController.text = prefs.getString('username')!;
        _emailController.text = prefs.getString('email')!;
        print("user_id    "+userId.toString());
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppTheme.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Flexible(
                    child: Text(
                  "Personal Information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.shortestSide < 550
                          ? 16
                          : 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                )),
                const SizedBox(
                  height: 50,
                  width: 50,
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 60.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Full Name",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: _fullNameController,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 15.0
                                        : 17.0),
                            cursorColor: AppTheme.pink,
                            decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 0.0,
                                    right: 50.0,
                                    top: 10.0,
                                    bottom: 5.0),
                                hintText: 'Jhon Doe',
                                hintStyle: TextStyle(color: Colors.grey)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: _emailController,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 15.0
                                        : 17.0),
                            cursorColor: AppTheme.pink,
                            decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 0.0,
                                    right: 50.0,
                                    top: 10.0,
                                    bottom: 5.0),
                                hintText: 'jhondoe@gmail.com',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: _password,
                                  obscureText: _obscurePass,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide <
                                              550
                                          ? 15.0
                                          : 17.0),
                                  cursorColor: AppTheme.pink,
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 0.0,
                                          right: 50.0,
                                          top: 10.0,
                                          bottom: 5.0),
                                      hintText: 'New Password',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        if (_obscurePass) {
                                          setState(() {
                                            _obscurePass = false;
                                          });
                                        } else {
                                          setState(() {
                                            _obscurePass = true;
                                          });
                                        }
                                      },
                                      icon: _obscurePass
                                          ? const Icon(
                                              Icons.visibility_off_outlined,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.visibility_outlined,
                                              size: 20,
                                            )))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: _confPassword,
                                  obscureText: _obscureConfPass,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide <
                                              550
                                          ? 15.0
                                          : 17.0),
                                  cursorColor: AppTheme.pink,
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 0.0,
                                          right: 50.0,
                                          top: 10.0,
                                          bottom: 5.0),
                                      hintText: 'Confirm Password',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        if (_obscureConfPass) {
                                          setState(() {
                                            _obscureConfPass = false;
                                          });
                                        } else {
                                          setState(() {
                                            _obscureConfPass = true;
                                          });
                                        }
                                      },
                                      icon: _obscureConfPass
                                          ? const Icon(
                                              Icons.visibility_off_outlined,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.visibility_outlined,
                                              size: 20,
                                            )))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 30),
                      child: TextButton(
                        onPressed: () {
                          if (_fullNameController.text.isEmpty) {
                            showMessageDialog("assets/icons/error.svg",
                                "Enter Full Name!", Colors.red);
                            return;
                          }
                          if (_emailController.text.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_emailController.text.trim())) {
                            showMessageDialog("assets/icons/error.svg",
                                "Enter Valid Email!", Colors.red);
                            return;
                          }
                          if (_password.text.trim().isNotEmpty) {
                            if (_password.text.trim().length < 5 ||
                                _confPassword.text.trim().length < 5) {
                              showMessageDialog("assets/icons/error.svg",
                                  "Choose a strong password!", Colors.red);
                              return;
                            }

                            if (_password.text.trim() !=
                                _confPassword.text.trim()) {
                              showMessageDialog(
                                  "assets/icons/error.svg",
                                  "New and Confirm passwords should be same!",
                                  Colors.red);
                              return;
                            }
                          }


                          updateUserDetails(
                              userId,
                              _fullNameController.text.trim(),
                              _emailController.text.trim(),
                              _password.text.trim());
                        },
                        child: const Text("Update User"),
                        style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            primary: Colors.white,
                            backgroundColor: AppTheme.pink),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
