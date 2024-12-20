// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_and_doctor_appointment/screens/doctor_profile.dart';
import 'package:health_and_doctor_appointment/screens/firebase_auth.dart';
import 'package:health_and_doctor_appointment/mainPage.dart';
import 'package:health_and_doctor_appointment/screens/homepage.dart';
import 'package:health_and_doctor_appointment/screens/my_appointments.dart';
import 'package:health_and_doctor_appointment/screens/skip.dart';
import 'package:health_and_doctor_appointment/screens/user_profile.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user;

  MyApp({super.key});

  Future<void> _getUser() async {
    try {
      user = _auth.currentUser;
    } catch (e) {
      const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    _getUser();
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => user == null ? const Skip() : const MainPage(),
        '/login': (context) => const FireBaseAuth(),
        '/home': (context) => const MainPage(),
        '/profile': (context) => const UserProfile(
              key: null,
            ),
        '/MyAppointments': (context) => const MyAppointments(),
        '/DoctorProfile': (context) => const DoctorProfile(
              doctor: '',
              doctorid: '',
            ),
      },
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
    );
  }
}
