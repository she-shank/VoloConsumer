part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = Loading;
  const factory ProfileState.ready({required Profile profile}) = Ready;
  const factory ProfileState.error({required String error}) = Error;
}
