import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volo_consumer/screens/home/logic/home_cubit.dart';

class StfulListTile extends StatefulWidget {
  const StfulListTile({Key? key}) : super(key: key);

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
      leading: const Icon(Icons.exit_to_app),
      title: const Text('Logout'),
      enabled: _enabled,
      onTap: context.read<HomeCubit>().logOut,
    );
  }
}
