import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:volo_consumer/utils/datamodels/datamodels.dart';
import 'package:volo_consumer/services/database_service.dart';
import 'package:volo_consumer/services/authentication_service.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DatabaseService _db = GetIt.instance.get<DatabaseService>();

  ProfileCubit() : super(const ProfileState.loading());

  void getProfileDetails(String profileID) async {
    emit(const ProfileState.loading());
    await Future.delayed(const Duration(seconds: 2));
    Either<String, Profile> result = await _db.getProfile(profileID);
    result.fold((left) {
      emit(ProfileState.error(error: left));
    }, (right) {
      emit(ProfileState.ready(profile: right));
    });
  }
}
