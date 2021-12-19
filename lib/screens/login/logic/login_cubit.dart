import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:volo_consumer/services/services.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController emailFieldController;
  late final TextEditingController passFieldController;
  bool obsucreState = true;
  void toggleObscureState() => obsucreState = !obsucreState;
  final AuthenticationService _auth =
      GetIt.instance.get<AuthenticationService>();
  final NavigationService _nav = GetIt.instance.get<NavigationService>();

  void _initialize() {
    emailFieldController = TextEditingController();
    passFieldController = TextEditingController();
    emit(const LoginState.ready());
  }

  LoginCubit() : super(const LoginState.loading()) {
    _initialize();
  }

  @override
  Future<void> close() async {
    emailFieldController.dispose();
    passFieldController.dispose();
    return super.close();
  }

  void sigin() async {
    if (formKey.currentState!.validate()) {
      emit(const LoginState.loading());
      var result = await _auth.signIn(
          email: emailFieldController.text, password: passFieldController.text);
      result.fold(
        (left) => print(left),
        (right) => _nav.pushreplacementNamed(routeName: '/home'),
      );
    }
  }

  void goToSignupScreen() async {
    _nav.pushreplacementNamed(routeName: '/signup');
  }
}
