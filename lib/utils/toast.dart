import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message{
  static void show({String message = 'Done.',
  ToastGravity gravity =ToastGravity.BOTTOM,
  int timeInSecForIosWeb = 1,
  Color backgroundColor =Colors.green,
  Color textColor = Colors.white,
  double fontSize =16.0
  
  })
  {
    Fluttertoast.showToast(



                      
                      msg: message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: gravity,
                      timeInSecForIosWeb: timeInSecForIosWeb,
                      backgroundColor:backgroundColor,
                      textColor: textColor,
                      fontSize:fontSize             
         
    );


  }
}