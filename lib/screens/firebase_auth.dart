import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/screens/register.dart';
import 'package:health_and_doctor_appointment/screens/signIn.dart';

class FireBaseAuth extends StatefulWidget {
  const FireBaseAuth({super.key});

  @override
  FireBaseAuthState createState() => FireBaseAuthState();
}

class FireBaseAuthState extends State<FireBaseAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/image-medical.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 80.0, left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      // '  مرحباً بك ',
                      'Welcome to you ',
                      style: GoogleFonts.b612(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      // 'في مركز العين الإستشاري',
                      'At Al Ain Consultant Centre',
                      style: GoogleFonts.b612(
                        color: Colors.indigo[800],
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.black26.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () =>
                                  _pushPage(context, const SignIn()),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.indigo[800],
                                backgroundColor: Colors.indigo[800],
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              child: Text(
                                // "دخول",
                                "Login",
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
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () => _pushPage(context, Register()),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              child: Text(
                                // "إنشاء حساب",
                                "Register",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
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
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
