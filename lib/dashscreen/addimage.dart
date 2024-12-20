import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/omment/colors.dart';
import 'package:health_and_doctor_appointment/omment/test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webkul_textfield_with_label/utils/input_decoration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const addimage());
}

// ignore: camel_case_types
class addimage extends StatefulWidget {
  const addimage({
    super.key,
  });

  @override
  State<addimage> createState() => addimages();
}
//البيانات الشخصية للدكتور

class addimages extends State<addimage> {
  final TextEditingController namedoc = TextEditingController();
  final TextEditingController doctid = TextEditingController();
  final TextEditingController type = TextEditingController();
  String ratingg = 'rating';
  final TextEditingController specification = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController openHour = TextEditingController();
  final TextEditingController closeHour = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController newaddress = TextEditingController();
  final url = Uri.parse('https://maps.google.com/?q');
  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select openHour';
  String timeText2 = 'Select closeHour';
  late String dateUTC;
  late String date_Time;
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  FocusNode f7 = FocusNode();
  FocusNode f8 = FocusNode();
  String urlimag = '';
  String urlimag2 = '';
  final _formKey = GlobalKey<FormState>();
  String saveDate1 = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final userid = FirebaseAuth.instance.currentUser?.uid;
  Duration remainingTime = const Duration(seconds: 60);
  late Timer timer;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        remainingTime -= const Duration(seconds: 60);
      });
      if (remainingTime < const Duration(seconds: 60)) {
        timer.cancel();
      }
    });
  }

  _onlyMessageWithCompletionProgress(context) async {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Success',
      desc: 'Data added successfully',
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
        debugPrint('Dialog Dismiss from callback $type');
      },
    ).show(); // Set Completed
  }

  _completedProgress(context) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'Error',
      desc: 'Data added before...',
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  DateTime inputDate1 = DateTime.now(); // Replace with your input date
  String idmessag = '';

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime!,
        alwaysUse24HourFormat: false);

    setState(() {
      timeText = formattedTime;
      openHour.text = timeText;
    });
    date_Time = selectedTime.toString().substring(10, 15);
  }

  Future<void> selectTime2(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime!,
        alwaysUse24HourFormat: false);

    setState(() {
      timeText2 = formattedTime;
      closeHour.text = timeText;
    });
    date_Time = selectedTime.toString().substring(10, 15);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: 170,
                        height: 160,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _image != null
                            ? ClipOval(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const Text('No profile image selected'),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        width: 166,
                        height: 70,
                        padding: const EdgeInsets.only(
                          top: 2,
                          left: 2,
                          right: 3,
                          bottom: 3,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              color: Color(0x2D292556),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 100,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 3.75,
                                    bottom: 19.12,
                                    child: SizedBox(
                                      width: 50.50,
                                      height: 50.62,
                                      child: IconButton(
                                        splashRadius: 10,
                                        onPressed: getImageFromCamera,
                                        icon: const Icon(Icons.add_a_photo),
                                        color: const Color.fromARGB(
                                          255,
                                          71,
                                          11,
                                          236,
                                        ),
                                        iconSize: 60,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 70.75,
                                    bottom: 19.12,
                                    child: SizedBox(
                                      width: 100.50,
                                      height: 50.62,
                                      child: IconButton(
                                        splashRadius: 10,
                                        onPressed: getImageFromGallery,
                                        icon: const Icon(
                                          Icons.photo_album_rounded,
                                        ),
                                        iconSize: 60,
                                        color: const Color.fromARGB(
                                          255,
                                          71,
                                          11,
                                          236,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Text(saveDate1),

                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                  TextFormField(
                    focusNode: f1,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: namedoc,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'Your_Name',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      f1.unfocus();
                      FocusScope.of(context).requestFocus(f2);
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter the Name';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    focusNode: f2,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: type,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'Type_work',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      f2.unfocus();
                      if (type.text.isEmpty) {
                        FocusScope.of(context).requestFocus(f3);
                      }
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the type';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    maxLines: 5,
                    focusNode: f3,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    keyboardType: TextInputType.text,
                    controller: specification,
                    decoration: InputDecoration(
                      hintMaxLines: 30,
                      prefixIcon: const Icon(Icons.spatial_audio_off_rounded),
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'specification',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      f3.unfocus();
                      if (specification.text.isEmpty) {
                        FocusScope.of(context).requestFocus(f4);
                      }
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the specification';
                      } else if (value.length < 40) {
                        return 'Password must be at least 40 characters long';
                      } else {
                        return null;
                      }
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    focusNode: f8,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    controller: newaddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.place),
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'address write',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      f8.unfocus();
                      if (specification.text.isEmpty) {
                        FocusScope.of(context).requestFocus(f5);
                      }
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the address';
                      } else {
                        return null;
                      }
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    focusNode: f4,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipOval(
                          child: Material(
                            color: Colors.indigo[900], // button color
                            child: InkWell(
                              // inkwell color
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.place,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                launchUrl(url);
                              },
                            ),
                          ),
                        ),
                      ),
                      prefixIcon: const Icon(Icons.place),
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'open map to add address*',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    controller: address,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter place map';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      f4.unfocus();
                    },
                    textInputAction: TextInputAction.next,
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    focusNode: f5,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    controller: phone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'phone',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      f5.unfocus();
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the phone';
                      } else {
                        return null;
                      }
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    focusNode: f6,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipOval(
                          child: Material(
                            color: Colors.indigo[900], // button color
                            child: InkWell(
                              // inkwell color
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                selectTime(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'Select openHour*',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    controller: openHour,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the openHour';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      f6.unfocus();
                    },
                    textInputAction: TextInputAction.next,
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: f7,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipOval(
                          child: Material(
                            color: Colors.indigo[900], // button color
                            child: InkWell(
                              // inkwell color
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                selectTime2(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(),
                      ),
                      filled: true,
                      fillColor: tWhiteColor,
                      hintText: 'Select closeHour*',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    controller: closeHour,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the closeHour';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      f7.unfocus();
                    },
                    textInputAction: TextInputAction.next,
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField(
                    autofocus: true,
                    alignment: Alignment.centerRight,

                    decoration: const InputDecorationTextField(
                      filledColor: Colors.white,
                      isEnabled: true,
                      isFilled: true,
                      suffixTxt: '   rating  ',
                      prefixTxt: '',
                      hint: '',
                      focusedInputBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 15, 15, 15)),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        // borderSide: BorderSide(),
                      ),
                    ),

                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    elevation: 10,
                    focusColor: const Color.fromARGB(255, 240, 35, 96),
                    padding: const EdgeInsets.symmetric(vertical: 10),

                    // ignore: unnecessary_null_comparison
                    hint: ratingg == null
                        ? const Text('Dropdown')
                        : Text(
                            ratingg,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 15, 15, 15),
                            ),
                          ),
                    isExpanded: false,

                    iconSize: 30.0,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 8, 8, 8),
                    ),
                    items: [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.bottomStart,
                          value: val,
                          child: Text(
                            val,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          ratingg = val!;
                        },
                      );
                    },
                  ),
                  AnimatedButton(
                    // زر الارسال
                    text: 'Send',
                    color: Colors.indigo[900],
                    buttonTextStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    pressEvent: () {
                      checkInternetConnection2(context);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title:
                                'Do you want to send pictures to the server?',
                            btnOkOnPress: () {
                              addUpersontb2();
                            },
                            btnCancelOnPress: () {},
                            btnCancelText: "Back",
                            btnOkIcon: Icons.send,
                            btnOkColor: Colors.blue,
                            btnCancelIcon: Icons.exit_to_app,
                            btnCancelColor: Colors.red,
                          ).show();
                        } catch (e) {
                          // checkInternetConnection2(context);
                        }
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: 'You must fill in all required fields...',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  File? _image;

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future getImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } catch (e) {
      // Handle any exceptions that may occur during image picking
      (msg: 'Error picking image: $e');
    }
  }

  Future uploadImageToFirebase() async {
    if (_image != null) {
      final firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/${phone.text}.jpg');
      await firebaseStorageRef.putFile(_image!);
      final downloadURL = await firebaseStorageRef.getDownloadURL();
      // You can use the downloadURL to save it in the database or display it in your app

      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Success',
        desc: 'Image uploaded: $downloadURL',
        btnOkOnPress: () {
          // Add functionality here if needed
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.error,
        showCloseIcon: true,
        title: 'Error',
        desc: 'Image uploaded: error',
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

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      // Camera permission granted, proceed with image capture
      await getImageFromCamera();
      await getImageFromGallery();
    } else {}
  }

  Future<void> addUpersontb2() async {
    final user = FirebaseAuth.instance.currentUser;

    // Replace with your input date
    String docmid = phone.text;
    String docwithuid = docmid;
    int ri = int.parse(ratingg);
    // Call the user's CollectionReference to add a new user
    CollectionReference pr = FirebaseFirestore.instance.collection('doctors');
    CollectionReference imagc =
        FirebaseFirestore.instance.collection('imageurl');
    final QuerySnapshot snapshot =
        await pr.where('doctorid', isEqualTo: docmid).get();
    final QuerySnapshot imagurlid =
        await imagc.where('doctorid', isEqualTo: docmid).get();
    final QuerySnapshot useridsn =
        await pr.where('doctorid', isEqualTo: userid).get();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          if (_image != null) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Loading...'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LinearProgressIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        'Time remaining: ${remainingTime.inMinutes}:${remainingTime.inSeconds % 100}',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );

            final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('images/${phone.text}.jpg');
            await firebaseStorageRef.putFile(_image!);

            final downloadURL = await firebaseStorageRef
                .getDownloadURL()
                .whenComplete(() => AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.success,
                      showCloseIcon: true,
                      title: 'Success',
                      desc: 'Image saved successfully',
                      btnOkOnPress: () {
                        // Add functionality here if needed
                      },
                      btnOkIcon: Icons.check_circle,
                      onDismissCallback: (type) {
                        debugPrint('Dialog Dismiss from callback $type');
                      },
                    ).show());

            urlimag = downloadURL.toString();
            // You can use the downloadURL to save it in the database or display it in your app

            // You can use the downloadURL to save it in the database or display it in your app

            Navigator.pop(context); // Dismiss the loading dialog

            try {
              FirebaseFirestore.instance
                  .collection('doctors')
                  .doc(docmid)
                  .set({
                    //تاريخ الادخال للبيانات
                    'doctorid': docmid,
                    'name': namedoc.text,
                    'type': type.text,
                    'rating': ri,
                    'specification': specification.text,
                    'address': address.text,
                    'address2': newaddress.text,
                    'phone': phone.text,
                    'openHour': openHour.text,
                    'closeHour': closeHour.text,
                    'image': urlimag,
                  })
                  .then((value) => _onlyMessageWithCompletionProgress(context))
                  .catchError(
                    (error) => print("Failed to add user: $error"),
                  );
              FirebaseFirestore.instance
                  .collection('imageurl')
                  .doc(docmid)
                  .set({
                    'doctorid': user?.uid, //رقم المستخدم
                    'idpres': doctid.text,
                    //تاريخ الادخال للبيانات
                    'image': urlimag,
                  })
                  .then((value) =>
                      print("Photos have been added to the photo table"))
                  .catchError(
                    (error) => print("Failed to add user: $error"),
                  );
            } catch (e) {
              print("Failed to add user: $e");
            }
          } else {
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              dialogType: DialogType.error,
              showCloseIcon: true,
              title: 'Error',
              desc: 'You must choose a photo from the gallery or camera',
              btnOkOnPress: () {
                // Add functionality here if needed
              },
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {
                debugPrint('Dialog Dismiss from callback $type');
              },
            ).show();
          }
        } catch (e) {
          // ignore: use_build_context_synchronously
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            headerAnimationLoop: false,
            title: 'Error',
            desc: '...$e',
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
        /*} else {
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              dialogType: DialogType.error,
              showCloseIcon: true,
              title: 'خطأ',
              desc: 'تم اضافة الصور من قبل',
              btnOkOnPress: () {
                // Add functionality here if needed
              },
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {
                debugPrint('Dialog Dismiss from callback $type');
              },
            ).show();
          }

      }*/
      }
    } on SocketException catch (_) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'There is no internet connection.',
              desc:
                  'Note: When sending, data will not be sent to the server, please connect to the Internet.',
              btnOkOnPress: () async {},
              btnOkIcon: Icons.send,
              btnOkColor: Colors.red,
              btnOkText: 'Send')
          .show();
    }
  }
}
