import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/firestore-data/search_list.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  DoctorsListState createState() => DoctorsListState();
}

class DoctorsListState extends State<DoctorsList> {
  final TextEditingController _textController = TextEditingController();
  late String search;
  var _length = 0;

  @override
  void initState() {
    super.initState();
    search = _textController.text;
    _length = search.length;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Find Doctors'),
        actions: <Widget>[
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Search Doctor',
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  prefixStyle: TextStyle(
                    color: Colors.grey[300],
                  ),
                  suffixIcon: _textController.text.isNotEmpty
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _textController.clear();
                              _length = search.length;
                            });
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            size: 20,
                          ),
                        )
                      : const SizedBox(),
                ),
                onFieldSubmitted: (String searchKey) {
                  setState(
                    () {
                      search = searchKey;
                    },
                  );
                },
                onChanged: (String searchKey) {
                  setState(
                    () {
                      search = searchKey;
                      _length = search.length;
                    },
                  );
                },
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textInputAction: TextInputAction.search,
                autofocus: false,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: _length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _length = 1;
                        });
                      },
                      child: Text(
                        'Show All',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                        ),
                      ),
                    ),
                    const Image(image: AssetImage('assets/search-bg.png')),
                  ],
                ),
              )
            : SearchList(
                searchKey: search,
              ),
      ),
    );
  }
}
