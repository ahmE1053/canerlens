import 'package:flutter/material.dart';

///Generates border for the text fields in the app
OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: color, width: 2),
    );
