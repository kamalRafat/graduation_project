import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'firebase_auth.dart';

class Skip extends StatefulWidget {
  const Skip({super.key});

  @override
  SkipState createState() => SkipState();
}

class SkipState extends State<Skip> {
  List<PageViewModel> getpages() {
    return [
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/doc.png',
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // 'البحث عن دكتور',
              'Search for a doctor',
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Text(
              // 'إيجاد دكتور قريب منك',
              'Find a doctor near you.',
              style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/disease.png',
        ),
        //body: "Search Doctors",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // ' بحث عن عيادة',
              'Search for a clinic',
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Text(
              // 'بامكانك البحث عن عيادة',
              'You can look for a clinic.',
              style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.lightBlue[100],
        pages: getpages(),
        showNextButton: false,
        showSkipButton: true,
        skip: SizedBox(
          width: 80,
          height: 48,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.blue[300],
            shadowColor: Colors.blueGrey[100],
            elevation: 5,
            child: Center(
              child: Text(
                'skip',
                // 'تخطي',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
        done: SizedBox(
          height: 48,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.blue[300],
            shadowColor: Colors.blueGrey[200],
            elevation: 5,
            child: Center(
              child: Text(
                'continue',
                // 'إستمرار',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
        onDone: () => _pushPage(context, const FireBaseAuth()),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
