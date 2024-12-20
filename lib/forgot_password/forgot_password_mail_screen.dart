// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/screens/signIn.dart';

class ForgotPasswordMailScreen extends StatefulWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  State<ForgotPasswordMailScreen> createState() =>
      _ForgotPasswordMailScreenState();
}

// form submit button
class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const FormButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.indigo[900],
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        onPressed: onPress,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _ForgotPasswordMailScreenState extends State<ForgotPasswordMailScreen> {
  final email1 = TextEditingController();
  final password1 = TextEditingController();
  final newpassword1 = TextEditingController();
  String password = '';
  final bool _isLoading = false; // Variable to track the loading state
  bool get isLoading => _isLoading;
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  FocusNode f2 = FocusNode();

  Future<void> restpassword(
      String email, String code, String newpassword) async {
    try {
      email = email1.text;
      code = password1.text;
      newpassword = newpassword1.text;
      await FirebaseAuth.instance.confirmPasswordReset(
        code: code,
        newPassword: newpassword,
      );
      await auth.sendPasswordResetEmail(email: email);
      _pushPage(context, SignIn());
    } catch (error) {
      if (error.toString().compareTo(
              '[firebase_auth/email-already-in-use] The email address is already in use by another account.') ==
          0) {
        showAlertDialog(context);
        print(
            "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      }
    }
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
        "Email not found",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/vector-doc2.jpg',
                  scale: 3.5,
                ),
                Icon(
                  Icons.password_outlined,
                  size: 50,
                ),
                Text(
                  // 'نسيت كلمة السر?',
                  'Forget Password ?',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Don\'t worry enter your registered email id to receive password reset link',
                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: email1,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
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
                          validator: (value) {
                            if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value ?? "")) {
                              return "Invalid Email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          controller: newpassword1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
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
                          validator: (value) {
                            if (value!.length < 7) {
                              return 'Password is fewer than seven characters';
                            } else {
                              return null;
                            }
                          },
                          obscureText: isPasswordVisible ? false : true,
                          onSaved: (value) => setState(() => password = value!),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  restpassword(email1.text, password1.text,
                                      newpassword1.text);
                                } else {}
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
                                "Continue",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
