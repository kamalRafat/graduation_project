import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class UpdateUserDetails extends StatefulWidget {
  final String label;
  final String field;

  const UpdateUserDetails(
      {super.key, required this.label, required this.field});

  @override
  UpdateUserDetailsState createState() => UpdateUserDetailsState();
}

class UpdateUserDetailsState extends State<UpdateUserDetails> {
  final TextEditingController _textcontroller = TextEditingController();
  late FocusNode f1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late String UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
    UserID = user.uid;
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
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.indigo[900],
          ),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: GoogleFonts.lato(
              color: Colors.indigo[900],
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(UserID)
                  .snapshots(),
              builder: (context, snapshot) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo.shade900),
                      ),
                    ),
                    controller: _textcontroller,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    onFieldSubmitted: (String data) {
                      _textcontroller.text = data;
                    },
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null) {
                        return 'Please Enter the ${widget.label}';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  updateData();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                  'Update',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    FirebaseFirestore.instance.collection('users').doc(UserID).set({
      widget.field: _textcontroller.text,
    }, SetOptions(merge: true));
    final snackBar = SnackBar(
      backgroundColor: Colors.indigo[900],
      content: Row(
        children: [
          const Icon(
            Icons.add_alert,
            color: Colors.white,
          ),
          Text(" successes add the ${widget.label}"),
        ],
      ),
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (widget.field.compareTo('name') == 0) {
      await user.updateProfile(displayName: _textcontroller.text);
    }
    if (widget.field.compareTo('phone') == 0) {}
  }
}
