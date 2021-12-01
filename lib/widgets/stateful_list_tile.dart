import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volo_consumer/screens/home/logic/home_cubit.dart';

class StfulListTile extends StatefulWidget {
  StfulListTile({Key? key}) : super(key: key);

  @override
  StfulListTileState createState() => StfulListTileState();
}

class StfulListTileState extends State<StfulListTile> {
  bool _enabled = true;
  void toggleEnable() {
    setState(() {
      _enabled = !_enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Logout'),
      onTap: context.read<HomeCubit>().logOut,
    );
  }
}
