import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gallery/core/utils/colors.dart';

showCustomToast(FToast? toastShower, String toastMessage, bool isError) {
  if(toastShower != null){
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    //margin: EdgeInsets.only(bottom: 0.1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      //color: kDefaultIconColor,
      color: isError == true ? kErrorColor : kSuccessColor,
    ),
    child: Text(
      toastMessage,
      style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,
    ),
  );
  toastShower.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );}
}