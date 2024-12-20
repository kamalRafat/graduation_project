// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_and_doctor_appointment/dashscreen/addimage.dart';
import 'package:health_and_doctor_appointment/firebase_options.dart';
import 'package:health_and_doctor_appointment/screens/docapoint.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(Dashsceen1());
}

class Dashsceen1 extends StatefulWidget {
  const Dashsceen1({super.key});

  @override
  State<Dashsceen1> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Dashsceen1> {
  final collectionRef = FirebaseFirestore.instance.collection('notification');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            style: TextStyle(
              color: Colors.white,
            ),
            'Dashboard',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              dividerColor: Color.fromARGB(255, 71, 11, 236),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              indicatorColor: Colors.indigo[900],
              labelColor: Color.fromARGB(255, 71, 11, 236),
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsetsDirectional.symmetric(vertical: 8),
              tabs: [
                Tab(
                  text: ' doctors',
                  icon: Icon(
                    Icons.person,
                    color: Colors.indigo[900],
                    size: 30,
                  ),
                ),
                Tab(
                  text: 'Appointments',
                  icon: Icon(
                    Icons.today_outlined,
                    color: Colors.indigo[900],
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  addimage(),
                  docapoint(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
