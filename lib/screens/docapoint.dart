import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_and_doctor_appointment/screens/appointment.dart';

class docapoint extends StatefulWidget {
  const docapoint({super.key});

  @override
  MyAppointmentsState createState() => MyAppointmentsState();
}

class MyAppointmentsState extends State<docapoint> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: const AppointmentList(),
      ),
    );
  }
}
