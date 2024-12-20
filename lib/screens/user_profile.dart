// ignore_for_file: await_only_futures, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/firestore-data/appointment_history_list.dart';
import 'package:health_and_doctor_appointment/screens/user_settings.dart';
import 'my_appointments.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user1 = FirebaseAuth.instance.currentUser!;

  Future<void> _getUser() async {
    await user1;
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSettings(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'My Profile',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                padding: const EdgeInsets.only(left: 20),
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.pink[600],
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user1.displayName.toString(),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.orange[600],
                            child: const Icon(
                              Icons.mail_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user1.email.toString(),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.greenAccent.shade700,
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        getphon(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 27,
                              width: 27,
                              color: Colors.indigo[600],
                              child: const Icon(
                                Icons.perm_contact_cal,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Bio',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: getBio(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.green[900],
                            child: const Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Appointment History",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 30,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MyAppointments(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'View all',
                                  style: TextStyle(
                                    color: Colors.indigo[900],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: Container(
                          padding: const EdgeInsets.only(left: 35, right: 15),
                          child: const SingleChildScrollView(
                            child: AppointmentHistoryList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBio() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user1.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var userData = snapshot.data;
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                userData!['bio'] == null ? "No Bio" : userData['bio'],
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getphon() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user1.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var userData = snapshot.data;
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 4, left: 10),
          child: Column(
            children: [
              Text(
                userData!['phone'] == null ? "No phone" : userData['phone'],
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
