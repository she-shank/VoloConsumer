import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        CircleAvatar(
          radius: 13,
          backgroundImage: AssetImage('assets/images/logo.png'),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'VOLO',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
