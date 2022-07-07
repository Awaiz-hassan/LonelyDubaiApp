import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/login_user.dart';
import 'package:lonelydubai/Screens/main_tab_screen.dart';
import 'package:lonelydubai/Screens/tours_history.dart';
import 'package:lonelydubai/Themes/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_us.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = "";
  var emailAddress = "";
  final email = TextEditingController();
  final password = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();
  bool userLogged = false;
  bool isObscure = true;
  bool passwordVisible = true;
  bool isLoading = false;
  bool isSignUpVisible = false;
  bool isLoginVisible = false;

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? logged = prefs.getBool('user_logged');
    if (logged != null) {
      if (logged) {
        setState(() {
          userLogged = true;
          name = prefs.getString('username')!;
          emailAddress = prefs.getString('email')!;
        });
      } else {
        setState(() {
          userLogged = false;
        });
      }
    } else {
      setState(() {
        userLogged = false;
      });
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: userLogged ? AppTheme.lightPink : Colors.transparent,
        body: userLogged
            ? Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 200),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      child: const SizedBox.expand(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            margin: MediaQuery.of(context).size.shortestSide<550?const EdgeInsets.only(
                              top: 100,
                              left: 40,
                              right: 40,
                            ):const EdgeInsets.only(
                              top: 100,
                              left: 150,
                              right: 150,
                            ),
                            elevation: 3.0,
                            shadowColor: AppTheme.lightGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 30.0),
                                      child: SvgPicture.asset(
                                        "assets/icons/avatar.svg",
                                        height: 60,
                                        color: AppTheme.pink,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 100.0, left: 30, right: 30),
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 130.0, left: 30, right: 30),
                                      child: Text(
                                        emailAddress,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfile()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 35, left: 20, right: 20),
                              width: double.infinity,
                              height: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: SvgPicture.asset(
                                        "assets/icons/edit_user_icon.svg",
                                        height: 20,
                                        color: AppTheme.pink,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 45, right: 45),
                                      child: Text(
                                        "Personal Information",
                                        style: TextStyle(
                                            color: AppTheme.charcoal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ToursHistory()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              width: double.infinity,
                              height: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: SvgPicture.asset(
                                        "assets/icons/history_icon.svg",
                                        height: 20,
                                        color: AppTheme.pink,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 45, right: 45),
                                      child: Text(
                                        "Tours History",
                                        style: TextStyle(
                                            color: AppTheme.charcoal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AboutUs()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              width: double.infinity,
                              height: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: SvgPicture.asset(
                                        "assets/icons/info_circle_icon.svg",
                                        height: 20,
                                        color: AppTheme.pink,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 45, right: 45),
                                      child: Text(
                                        "About Us",
                                        style: TextStyle(
                                            color: AppTheme.charcoal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              name = "";
                              emailAddress = "";
                              setState(() {});
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainTabScreen()), (route) => false);

                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              width: double.infinity,
                              height: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: SvgPicture.asset(
                                        "assets/icons/logout_icon.svg",
                                        height: 20,
                                        color: AppTheme.pink,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 45, right: 45),
                                      child: Text(
                                        "Logout",
                                        style: TextStyle(
                                            color: AppTheme.charcoal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : SafeArea(
                child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                          constraints: const BoxConstraints(maxHeight: 55),
                          child: Image.asset(
                            "assets/images/logo.png",
                            color: Colors.black,
                          ))),
                  Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 75.0, bottom: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 300
                                          : 400,
                                  width: double.infinity,
                                  margin:MediaQuery.of(context).size.shortestSide <
                                      550
                                      ? const EdgeInsets.only(
                                      top: 40.0,
                                      bottom: 20.0,
                                      left: 40,
                                      right: 40):const EdgeInsets.only(
                                      top: 180.0,
                                      bottom: 20.0,
                                      left: 40,
                                      right: 40),
                                  child: Image.asset("assets/images/login.png"),
                                ),
                                InkWell(
                                  onTap: () {
                                    showLoginDialog();
                                  },
                                  child: Container(
                                    margin: MediaQuery.of(context).size.shortestSide <
                                        550
                                        ? const EdgeInsets.only(
                                        top: 10,
                                        left: 20,
                                        right: 20,
                                        bottom: 10.0):const EdgeInsets.only(
                                        top: 10,
                                        left: 20,
                                        right: 20,
                                        bottom: 10.0),
                                    width: double.infinity,
                                    height: 50,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            child: SvgPicture.asset(
                                              "assets/icons/user.svg",
                                              height: 20,
                                              color: AppTheme.pink,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 45, right: 45),
                                            child: Text(
                                              "Login or sign up",
                                              style: TextStyle(
                                                  color: AppTheme.charcoal,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            child: const Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              )));
  }

  showLoginDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          isLoginVisible = true;
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              //this right here
              child: Container(
                  constraints: MediaQuery.of(context).size.shortestSide<550?const BoxConstraints(maxHeight: 370):const BoxConstraints(maxHeight: 400),
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: const Text("Sign In",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/mail_icon.svg",
                                    height: 30,
                                    color: Colors.grey,
                                  )),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(left: 30.0),
                                height: 40,
                                width: double.infinity,
                                child: TextField(
                                  controller: email,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide <
                                              550
                                          ? 15.0
                                          : 17.0),
                                  cursorColor: AppTheme.black,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 0.0,
                                          right: 0.0,
                                          top: 0.0,
                                          bottom: 0.0),
                                      hintText: 'jhondoe@gmail.com',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: MediaQuery.of(context).size.shortestSide < 550
                              ? const EdgeInsets.only(top: 10.0)
                              : const EdgeInsets.only(top: 20.0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 15.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/lock_icon.svg",
                                      height: 20,
                                      color: Colors.grey,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30.0),
                                  height: 40,
                                  width: double.infinity,
                                  child: TextField(
                                    controller: password,
                                    obscureText: isObscure,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? 15.0
                                            : 17.0),
                                    cursorColor: AppTheme.black,
                                    decoration: InputDecoration(
                                        suffix: IconButton(
                                            onPressed: () {
                                              if (isObscure) {
                                                setState(() {
                                                  isObscure = false;
                                                });
                                              } else {
                                                setState(() {
                                                  isObscure = true;
                                                });
                                              }
                                            },
                                            icon: isObscure
                                                ? const Icon(
                                                    Icons
                                                        .visibility_off_outlined,
                                                    size: 20,
                                                  )
                                                : const Icon(
                                                    Icons.visibility_outlined,
                                                    size: 20,
                                                  )),
                                        contentPadding: const EdgeInsets.only(
                                            left: 0.0,
                                            right: 0.0,
                                            top: 0.0,
                                            bottom: 3.0),
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const SizedBox(
                        //       height: 20,
                        //       width: 20,
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(
                        //             top: 20.0, bottom: 10.0, left: 20.0),
                        //         child: Text(
                        //           "Forgot Password ?",
                        //           style: TextStyle(
                        //               color: Colors.grey,
                        //               fontSize: MediaQuery.of(context)
                        //                           .size
                        //                           .shortestSide <
                        //                       550
                        //                   ? 14
                        //                   : 16),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          margin: const EdgeInsets.only(top: 20.0),
                          child: TextButton(
                            onPressed: () {
                              if (email.text.trim().isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(email.text.trim())) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Enter valid email!", Colors.red);

                                return;
                              }
                              if (password.text.trim().isEmpty) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Enter valid password!", Colors.red);

                                return;
                              }
                              loginUser(email.text.toString(),
                                  password.text.toString());
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 15
                                          : 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                primary: Colors.white,
                                backgroundColor: AppTheme.pink),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "Don't have an account ?",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 15
                                        : 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (isLoginVisible) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                            showSignUpDialog();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, top: 10.0, bottom: 10.0),
                            child: Text(
                              "Create new one",
                              style: TextStyle(
                                  color: AppTheme.pink,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 15
                                          : 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            );
          });
        }).then((_) => isSignUpVisible = false);
  }

  showSignUpDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          isSignUpVisible = true;
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              //this right here
              child: Container(
                  constraints:MediaQuery.of(context).size.shortestSide<550? const BoxConstraints(maxHeight: 370):const BoxConstraints(maxHeight: 440),
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: const Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/mail_icon.svg",
                                    height: 30,
                                    color: Colors.grey,
                                  )),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(left: 30.0),
                                height: 40,
                                width: double.infinity,
                                child: TextField(
                                  controller: emailController,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide <
                                              550
                                          ? 15.0
                                          : 17.0),
                                  cursorColor: AppTheme.black,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 0.0,
                                          right: 0.0,
                                          top: 0.0,
                                          bottom: 0.0),
                                      hintText: 'jhondoe@mail.com',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: MediaQuery.of(context).size.shortestSide < 550
                              ? const EdgeInsets.only(top: 10.0)
                              : const EdgeInsets.only(top: 20.0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 15.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/person.svg",
                                      height: 20,
                                      color: Colors.grey,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30.0),
                                  height: 40,
                                  width: double.infinity,
                                  child: TextField(
                                    controller: nameController,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? 15.0
                                            : 17.0),
                                    cursorColor: AppTheme.black,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 0.0,
                                            right: 0.0,
                                            top: 0.0,
                                            bottom: 0.0),
                                        hintText: 'Jhondoe',
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: MediaQuery.of(context).size.shortestSide < 550
                              ? const EdgeInsets.only(top: 10.0)
                              : const EdgeInsets.only(top: 20.0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 15.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/lock_icon.svg",
                                      height: 20,
                                      color: Colors.grey,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30.0),
                                  height: 40,
                                  width: double.infinity,
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: passwordVisible,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? 15.0
                                            : 17.0),
                                    cursorColor: AppTheme.black,
                                    decoration: InputDecoration(
                                        suffix: IconButton(
                                            onPressed: () {
                                              if (passwordVisible) {
                                                setState(() {
                                                  passwordVisible = false;
                                                });
                                              } else {
                                                setState(() {
                                                  passwordVisible = true;
                                                });
                                              }
                                            },
                                            icon: passwordVisible
                                                ? const Icon(
                                                    Icons
                                                        .visibility_off_outlined,
                                                    size: 20,
                                                  )
                                                : const Icon(
                                                    Icons.visibility_outlined,
                                                    size: 20,
                                                  )),
                                        contentPadding: const EdgeInsets.only(
                                            left: 0.0,
                                            right: 0.0,
                                            top: 0.0,
                                            bottom: 0.0),
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: MediaQuery.of(context).size.shortestSide < 550
                              ? const EdgeInsets.only(top: 10.0)
                              : const EdgeInsets.only(top: 20.0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 15.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/lock_icon.svg",
                                      height: 20,
                                      color: Colors.grey,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30.0),
                                  height: 40,
                                  width: double.infinity,
                                  child: TextField(
                                    controller: confirmPassword,
                                    obscureText: passwordVisible,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? 15.0
                                            : 17.0),
                                    cursorColor: AppTheme.black,
                                    decoration: InputDecoration(
                                        suffix: IconButton(
                                            onPressed: () {
                                              if (passwordVisible) {
                                                setState(() {
                                                  passwordVisible = false;
                                                });
                                              } else {
                                                setState(() {
                                                  passwordVisible = true;
                                                });
                                              }
                                            },
                                            icon: passwordVisible
                                                ? const Icon(
                                                    Icons
                                                        .visibility_off_outlined,
                                                    size: 20,
                                                  )
                                                : const Icon(
                                                    Icons.visibility_outlined,
                                                    size: 20,
                                                  )),
                                        contentPadding: const EdgeInsets.only(
                                            left: 0.0,
                                            right: 0.0,
                                            top: 0.0,
                                            bottom: 0.0),
                                        hintText: 'Confirm Password',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          margin:
                              const EdgeInsets.only(top: 30.0, bottom: 50.0),
                          child: TextButton(
                            onPressed: () {
                              if (nameController.text.isEmpty) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Enter your name!", Colors.red);

                                return;
                              }

                              if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text.trim()) ||
                                  emailController.text.isEmpty) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Enter valid email!", Colors.red);

                                return;
                              }
                              if (passwordController.text.isEmpty) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Enter valid password!", Colors.red);

                                return;
                              }

                              if (confirmPassword.text.isEmpty) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Enter valid password!", Colors.red);
                                return;
                              }

                              if (passwordController.text.trim().length < 5 ||
                                  confirmPassword.text.trim().length < 5) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Choose a strong password!", Colors.red);

                                return;
                              }
                              if (passwordController.text !=
                                  confirmPassword.text) {
                                showMessageDialog("assets/icons/error.svg",
                                    "Passwords should be same!", Colors.red);

                                return;
                              }

                              registerUser(
                                  nameController.text.toString().trim(),
                                  emailController.text.toString().trim(),
                                  passwordController.text.toString().trim());
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                primary: Colors.white,
                                backgroundColor: AppTheme.pink),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          });
        }).then((_) => isSignUpVisible = false);
  }

  showLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          isLoading = true;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: SizedBox(
                height: MediaQuery.of(context).size.shortestSide<550? 200: 300,
                child: Center(
                    child: Lottie.asset('assets/animations/loading.json',
                        height: MediaQuery.of(context).size.shortestSide<550? 60.0:100))),
          );
        }).then((_) => isLoading = false);
  }

  registerUser(String fullName, String emailAddress, String passKey) async {
    showLoadingDialog();
    var client = http.Client();
    String registerUrl =
        "https://lonelydubai.com/booking/public/api/createUser?name=$fullName&email=$emailAddress&password=$passKey&conf_password=$passKey&roles=guest";
    try {
      var response = await client.post(Uri.parse(registerUrl));
      if (response.statusCode == 201) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (isSignUpVisible) {
          Navigator.of(context, rootNavigator: true).pop();
          showLoginDialog();
        }
        showMessageDialog("assets/icons/success.svg",
            "User Registered!\n Please login to continue", Colors.green);
      } else if (response.statusCode == 401) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        showMessageDialog(
            "assets/icons/error.svg", "Email already exists!", Colors.red);
      }
    } on Exception {
      if (isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      showMessageDialog("assets/icons/error.svg", "Server Error", Colors.red);
    }
  }

  showMessageDialog(String imagePath, String message, Color color) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
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

  loginUser(String email, String password) async {
    showLoadingDialog();
    String loginUrl =
        "https://lonelydubai.com/booking/public/api/login?email=$email&password=$password";
    var client = http.Client();

    try {
      var response = await client.post(Uri.parse(loginUrl));
      if (response.statusCode == 200) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        var jsonString = response.body;
        LoginUser loginUser;
        loginUser = loginUserFromJson(jsonString);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('key', loginUser.success);
        await prefs.setString('username', loginUser.name);
        await prefs.setString('email', loginUser.email);
        await prefs.setInt('id', loginUser.userId);
        await prefs.setBool('user_logged', true);
        setState(() {
          userLogged = true;
          name = prefs.getString('username')!;
          emailAddress = prefs.getString('email')!;
        });
        if (isLoginVisible) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      } else if (response.statusCode == 401) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
          showMessageDialog("assets/icons/error.svg",
              "Incorrect username/password", Colors.red);
        }
      } else {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
          showMessageDialog("assets/icons/error.svg",
              "Unable to login.\nPlease try again later!", Colors.red);
        }
      }
    } on Exception {
      if (isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      showMessageDialog("assets/icons/error.svg", "Server error", Colors.red);
    }
  }
}
