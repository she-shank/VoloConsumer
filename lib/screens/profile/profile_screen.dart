import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:volo_consumer/screens/profile/logic/profile_cubit.dart';
import 'package:volo_consumer/utils/constants/app_bar_title.dart';

class ProfileScreen extends StatefulWidget {
  final String profileID;
  const ProfileScreen({Key? key, required this.profileID}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileCubit _profileCubit = GetIt.instance.get<ProfileCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileCubit.getProfileDetails(widget.profileID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: appBarTitle,
      ),
    );
  }
}
