import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/all_tours.dart';
import 'package:lonelydubai/Model/login_user.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/AppConstants.dart';
import '../Themes/app_theme.dart';
import 'main_tab_screen.dart';

class BookTour extends StatefulWidget {
  AllTours bookTour;

  BookTour(this.bookTour, {Key? key}) : super(key: key);

  @override
  _BookTourState createState() => _BookTourState();
}

class _BookTourState extends State<BookTour> {
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nOPController = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();
  bool userLogged = false;
  bool isObscure = true;
  bool passwordVisible = true;
  bool isSignUpVisible = false;
  bool isLoginVisible = false;

  late String date;
  late DateTime selectedDate;
  bool isLoading = false;

  @override
  initState() {
    selectedDate = DateTime.now();
    date = selectedDate.toString().substring(0, 10);
    userLoggedIn();
    super.initState();
  }

  void userLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    var logged = prefs.getBool('user_logged');
    if (logged != null) {
      if (logged) {
        userLogged = true;
        setState(() {});
      } else {
        userLogged = false;
        setState(() {});
      }
    } else {
      userLogged = false;
      setState(() {});
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppTheme.pink, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: AppTheme.charcoal, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: AppTheme.pink, // button text color
                  ),
                )),
            child: child!,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 31)));
    if (picked != null && picked != date) {
      setState(() {
        selectedDate = picked;
        date = picked.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  widget.bookTour.postTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.shortestSide < 550
                          ? 16
                          : 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                )),
                userLogged
                    ? IconButton(
                        icon: Icon(Icons.person_sharp),
                        onPressed: () {
                          AppConstants.showProfileOnTop = true;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MainTabScreen()),
                              (route) => false);
                        },
                      )
                    : const SizedBox(
                        height: 50,
                        width: 50,
                      )
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/form_image.png",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.shortestSide < 550
                        ? 260.0
                        : 300.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Book your tour now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 16
                                  : 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15
                                  : 17),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.shortestSide < 550
                              ? 0
                              : 3),
                      height: MediaQuery.of(context).size.shortestSide < 550
                          ? 45
                          : 50,
                      child: TextField(
                        controller: _fullNameController,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 15.0
                                    : 17.0),
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: 'Jhon Doe',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15.0
                                  : 17.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.shortestSide < 550
                          ? 45.0
                          : 50.0,
                      child: TextField(
                        controller: _phoneNumberController,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 15.0
                                    : 17.0),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(13),
                          FilteringTextInputFormatter.digitsOnly,
                          NumberTextInputFormatter()
                        ],
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: '+000000000',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Tour Date",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15.0
                                  : 17.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Card(
                      color: Colors.white,
                      elevation: 2.0,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                              color: Colors.white, width: 1.5)),
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide < 550
                              ? 45.0
                              : 50.0,
                          margin: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.shortestSide < 550
                                      ? 0.0
                                      : 5.0),
                          child: SizedBox.expand(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, left: 10.0, right: 10.0),
                              child: Text(
                                date.toString(),
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            550
                                        ? 15.0
                                        : 17.0,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Number of persons",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15.0
                                  : 17.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      height: MediaQuery.of(context).size.shortestSide < 550
                          ? 45.0
                          : 50.0,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.shortestSide < 550
                              ? 0.0
                              : 3.0),
                      child: TextField(
                        controller: _nOPController,
                        style: const TextStyle(fontSize: 15.0),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly,
                          LimitRangeTextInputFormatter(1, 50),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        onSubmitted: (value) {},
                        cursorColor: AppTheme.black,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            border: InputBorder.none,
                            hintText: 'X Persons',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.shortestSide < 550
                            ? 35.0
                            : 40.0,
                        width: MediaQuery.of(context).size.shortestSide < 550
                            ? 120.0
                            : 180.0,
                        margin: const EdgeInsets.only(top: 10, bottom: 30.0),
                        child: TextButton(
                          onPressed: () {
                            if (_fullNameController.text.isEmpty) {
                              showMessageDialog("assets/icons/error.svg",
                                  "Enter your full name!", Colors.red);
                              return;
                            }

                            if (_phoneNumberController.text.isEmpty ||
                                _phoneNumberController.text.length < 13) {
                              showMessageDialog("assets/icons/error.svg",
                                  "Enter valid phone number!", Colors.red);
                              return;
                            }

                            if (_nOPController.text.isEmpty) {
                              showMessageDialog("assets/icons/error.svg",
                                  "Enter number of persons!", Colors.red);
                              return;
                            }

                            bookTour(
                                _fullNameController.text.toString(),
                                _phoneNumberController.text.toString(),
                                widget.bookTour.postTitle,
                                date,
                                _nOPController.text.toString(),
                                widget.bookTour.tourPrice[0],
                                widget.bookTour.tourBookingPrice[0].isEmpty?widget.bookTour.tourPrice[0]:widget.bookTour.tourBookingPrice[0]);
                          },
                          child: Text(
                            "Book Tour",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 15.0
                                        : 17.0,
                                fontWeight:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              primary: Colors.white,
                              backgroundColor: AppTheme.pink),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
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
                  borderRadius: BorderRadius.circular(15.0)),
              //this right here
              child: Container(
                  constraints: MediaQuery.of(context).size.shortestSide < 550
                      ? const BoxConstraints(maxHeight: 370)
                      : const BoxConstraints(maxHeight: 400),
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
                  constraints: MediaQuery.of(context).size.shortestSide < 550
                      ? const BoxConstraints(maxHeight: 370)
                      : const BoxConstraints(maxHeight: 440),
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
                height:
                    MediaQuery.of(context).size.shortestSide < 550 ? 200 : 300,
                child: Center(
                    child: Lottie.asset('assets/animations/loading.json',
                        height: MediaQuery.of(context).size.shortestSide < 550
                            ? 60.0
                            : 100))),
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

  bookTour(String name, String phoneNumber, String tourName, String date,
      String numOfPersons, String tour_price, String booking_price) async {
    var client = http.Client();
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('key');
    if (token == null) {
      showLoginDialog();
      return;
    }

    var totalPrice = int.parse(numOfPersons) * int.parse(tour_price);
    var bookingPrice = int.parse(numOfPersons) * int.parse(booking_price);
    var profit = totalPrice - bookingPrice;
    showLoadingDialog();
    client
        .post(
      Uri.parse(
          "https://lonelydubai.com/booking/public/api/createCustomer?customer_name=$name&mobile_no=$phoneNumber&tours=$tourName&number_of_person=$numOfPersons&date=$date&status=in-processing&payment=$totalPrice&profite=$profit&booking_price=$bookingPrice"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      encoding: Encoding.getByName("utf-8"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        if (isLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        showMessageDialog("assets/icons/success.svg",
            "Tour Booked!\n Our team will update you soon.", Colors.green);
      }
    });
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex++;
    }

    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}
