// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/omment/test.dart';
import 'package:health_and_doctor_appointment/screens/signIn.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: _signUp(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUp() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/vector-doc2.jpg',
                scale: 3.5,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                'Sign up',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              focusNode: f1,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _displayName,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Name',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f1.unfocus();
                FocusScope.of(context).requestFocus(f2);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the Name';
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Email',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f2.unfocus();
                if (_passwordController.text.isEmpty) {
                  FocusScope.of(context).requestFocus(f3);
                }
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Email';
                } else if (!emailValidate(value)) {
                  return 'Please enter correct Email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f3,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Password',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f3.unfocus();
                if (_passwordConfirmController.text.isEmpty) {
                  FocusScope.of(context).requestFocus(f4);
                }
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Password';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                } else {
                  return null;
                }
              },
              obscureText: true,
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f4,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              controller: _passwordConfirmController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Confirm Password',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f4.unfocus();
              },
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Password';
                } else if (value.compareTo(_passwordController.text) != 0) {
                  return 'Password not Matching';
                } else {
                  return null;
                }
              },
              obscureText: true,
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      checkInternetConnection2(context);
                      _registerAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    elevation: 2,
                    backgroundColor: Colors.indigo[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              child: const Divider(
                thickness: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () => _pushPage(context, SignIn()),
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.indigo[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Navigator.pop(context);
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(f2);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Error!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Email already Exists",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text("Loading..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool emailValidate(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _registerAccount() async {
    User? user;
    // UserCredential credential;

    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      await user?.sendEmailVerification();
      FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'doctorid': user.uid,
        'name': _displayName.text,
        'birthDate': null,
        'email': user.email,
        'phone': null,
        'bio': null,
        'city': null,
      }, SetOptions(merge: true));

      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      Navigator.push(
          context, MaterialPageRoute(builder: (contex) => const SignIn()));
    } catch (error) {
      if (error.toString().compareTo(
              '[firebase_auth/email-already-in-use] The email address is already in use by another account.') ==
          0) {
        showAlertDialog(context);
      }
    }

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
        Navigator.push(
            context, MaterialPageRoute(builder: (contex) => const SignIn()));
      }
    } else {}
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
