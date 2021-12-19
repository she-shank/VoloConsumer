part of 'signup_cubit.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState.ready() = Ready;
  const factory SignupState.loading() = Loading;
  const factory SignupState.error({required String error}) = Error;
}
