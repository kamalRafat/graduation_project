import 'dart:async';
import 'package:health_and_doctor_appointment/screens/homepage.dart';
import 'package:health_and_doctor_appointment/screens/my_appointments.dart';
import 'package:health_and_doctor_appointment/screens/user_profile.dart';
import 'package:health_and_doctor_appointment/screens/doctors_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const DoctorsList(),
    const MyAppointments(),
    const UserProfile(),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                rippleColor: Colors.grey,
                hoverColor: Colors.grey,
                haptic: true,
                tabBorderRadius: 20,
                gap: 5,
                activeColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.indigo.shade900,
                textStyle: GoogleFonts.lato(
                  color: Colors.white,
                ),
                tabs: [
                  GButton(
                    iconSize: _selectedIndex != 0 ? 28 : 25,
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  const GButton(
                    icon: Icons.search_sharp,
                    text: 'Search',
                  ),
                  GButton(
                    iconSize: 28,
                    icon: _selectedIndex == 2
                        ? Typicons.calendar
                        : Typicons.calendar_outline,
                    text: 'Schedule',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: _selectedIndex == 3
                        ? Typicons.user
                        : Typicons.user_outline,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
