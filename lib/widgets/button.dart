import 'package:flutter/material.dart';


final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(327, 50),
  elevation: 0,
  primary: Colors.transparent,
  side: BorderSide(color: Colors.yellow, width: 5),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  ), 
);
