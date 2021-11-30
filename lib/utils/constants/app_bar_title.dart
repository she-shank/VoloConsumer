import 'package:flutter/material.dart';

//TODO: make this a widget

final Widget appBarTitle = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    const CircleAvatar(
      //backgroundImage: AssetImage('images/$theme/logo.png')
      backgroundImage: AssetImage('images/logo1.png'),
    ),
    const Text(
      'VOLO',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  ],
);
