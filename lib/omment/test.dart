import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart'
    show AnimType, AwesomeDialog, DialogType;

import 'package:flutter/material.dart';

void checkInternetConnection2(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet connection is available');
    }
  } on SocketException catch (_) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'There is no internet connection.',
      desc: 'Note: There is no internet connection, please connect to continue!!',
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }
}
