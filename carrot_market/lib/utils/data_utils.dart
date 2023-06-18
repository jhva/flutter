import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailUtils {
  static final oCcy = new NumberFormat("#,###", "ko_KR");
  static String caclStringToWon(String price) {
    if (price == "무료나눔") return price;
    return "${oCcy.format(int.parse(price))} 원";
  }
}
