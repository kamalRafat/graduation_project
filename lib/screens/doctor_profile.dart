import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/screens/booking_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfile extends StatefulWidget {
  final String doctor;
  final String doctorid;

  const DoctorProfile(
      {super.key, required this.doctor, required this.doctorid});

  @override
  DoctorProfileState createState() => DoctorProfileState();
}

class DoctorProfileState extends State<DoctorProfile> {
  _launchCaller(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    try {
      await canLaunchUrl(url);
      launchUrl(url);
    } catch (e) {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.error,
        showCloseIcon: true,
        title: 'error',
        desc: '$e. Please dial the number manually.',
        btnOkOnPress: () {
          // Add functionality here if needed
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        },
      ).show();
    }
  }

  _launchplace(String all) async {
    final url = Uri.parse('https://maps.google.com/?q=$all');

    try {
      await canLaunchUrl(url);
      launchUrl(url);
    } catch (e) {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.error,
        showCloseIcon: true,
        title: 'error',
        desc: '$e. Could not launch Google Maps',
        btnOkOnPress: () {
          // Add functionality here if needed
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .orderBy('name')
              .startAt([widget.doctor]).endAt(
                  ['${widget.doctor}\uf8ff']).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 5),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.indigo[900],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(document['image']),
                          radius: 80,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          document['name'],
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          document['type'],
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < document['rating']; i++)
                              Icon(
                                Icons.star_rounded,
                                color: Colors.yellow.shade600,
                                size: 30,
                              ),
                            if (5 - document['rating'] > 0)
                              for (var i = 0; i < 5 - document['rating']; i++)
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.black12,
                                  size: 30,
                                ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          alignment: Alignment.center,
                          child: Text(
                            document['specification'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 24,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                const Icon(Icons.place_outlined),
                                const SizedBox(width: 12),
                                Text(
                                  document['address2'],
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 24,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                const Icon(Icons.place),
                                TextButton(
                                  onPressed: () =>
                                      _launchplace(document['address']),
                                  child: Text(
                                    document['address'].toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 24,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              const Icon(Icons.phone),
                              TextButton(
                                onPressed: () =>
                                    _launchCaller(document['phone']),
                                child: Text(
                                  document['phone'].toString(),
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.blue),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 24,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              const Icon(Icons.access_time_rounded),
                              const SizedBox(width: 12),
                              Text(
                                'Working Hours',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.only(left: 53),
                          child: Row(
                            children: [
                              Text(
                                'Today: ',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                document['openHour'] +
                                    " - " +
                                    document['closeHour'],
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo[900],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                    doctor: document['name'],
                                    doctorid: document['doctorid'],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Book an Appointment',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
