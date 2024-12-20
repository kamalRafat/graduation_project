import 'dart:async';
import 'package:health_and_doctor_appointment/dashscreen/dashboard.dart';
import 'package:health_and_doctor_appointment/model/card_model.dart';
import 'package:health_and_doctor_appointment/carousel_slider.dart';
import 'package:health_and_doctor_appointment/screens/explore_list.dart';
import 'package:health_and_doctor_appointment/firestore-data/search_list.dart';
import 'package:health_and_doctor_appointment/firestore-data/top_rated_list.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../omment/test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _doctorName = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection2(context);
    _getUser();
    _doctorName = TextEditingController();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late String message;
    DateTime now = DateTime.now();
    String currentHour = DateFormat('kk').format(now);
    int hour = int.parse(currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 12) {
          // _message = 'صباح الخير';
          message = 'Good Morning';
        }
        // else if (hour >= 12 && hour <= 17) {
        //   _message = 'نهارك سعيد';
        // }
        else {
          // _message = 'مساء الخير';
          message = 'Good Evening';
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          message,
          style: GoogleFonts.abel(
            color: const Color.fromARGB(135, 255, 251, 251),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(
            color: Colors.white,
            Icons.menu_open_sharp,
            size: 30,
          ),
          onPressed: () {
            AwesomeDialog(
              context: context,
              keyboardAware: true,
              dismissOnBackKeyPress: false,
              dialogType: DialogType.warning,
              animType: AnimType.bottomSlide,
              btnCancelText: "Cancel",
              btnOkText: "Ok",
              title: 'Dashboard ?',
              desc: 'You will be logged in to the control panel.',
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => const Dashsceen1()));
              },
            ).show();
          },
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
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
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Hello ${user!.displayName}👋",
                      // " مرحبا بك في مركز العين الإستشاري ",
                      style: GoogleFonts.lato(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      // "بإمكانك ان تجد عيادتك ودكتورك هنا",
                      "Welcome to Al Ain Consultant Centre \nYou can find your clinic and doctor here.",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextFormField(
                      textInputAction: TextInputAction.search,
                      controller: _doctorName,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Find a clinic or doctor',
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black26,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        suffixIcon: IconButton(
                          iconSize: 20,
                          color: Colors.black26,
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      onFieldSubmitted: (String value) {
                        setState(
                          () {
                            value.isEmpty
                                ? Container()
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchList(
                                        searchKey: value,
                                      ),
                                    ),
                                  );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 23, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "We take care of you",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Carouselslider(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Specialists",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.only(top: 14),
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 14),
                          height: 150,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(cards[index].cardBackground),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                          // ignore: deprecated_member_use
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              elevation: WidgetStatePropertyAll(0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExploreList(
                                    type: cards[index].doctor,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                CircleAvatar(
                                  foregroundColor:
                                      const Color.fromARGB(255, 56, 56, 211),
                                  backgroundColor:
                                      const Color.fromARGB(255, 231, 231, 235),
                                  radius: 29,
                                  child: Icon(
                                    cards[index].cardIcon,
                                    size: 26,
                                    color: Color(cards[index].cardBackground),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    cards[index].doctor,
                                    style: GoogleFonts.lato(
                                      color:
                                          const Color.fromARGB(255, 46, 45, 45),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Top Rated",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: const TopRatedList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
