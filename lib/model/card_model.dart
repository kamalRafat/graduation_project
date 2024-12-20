import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CardModel {
  String doctor;
  int cardBackground;
  var cardIcon;

  CardModel(this.doctor, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [
  CardModel("Cardiologist", 0xFFec407a, Icons.heart_broken), //طبيب القلب
  CardModel("Dentist", 0xFF5c6bc0, Icons.today_outlined), //طبيب أسنان
  CardModel("Eye Special", 0xFFfbc02d, TablerIcons.eye), //مختص بالعين
  CardModel(
      "Orthopaedic", 0xFF1565C0, Icons.wheelchair_pickup_sharp), //تقويم العظام
  CardModel(
      "Paediatrician", 0xFF2E7D32, Icons.baby_changing_station), //طبيب الأطفال
];
