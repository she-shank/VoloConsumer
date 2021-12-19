part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.ready() = Ready;
  const factory LoginState.loading() = Loading;
  const factory LoginState.error({required String error}) = Error;
}
