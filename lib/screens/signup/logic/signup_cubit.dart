import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:volo_consumer/services/services.dart';

part 'signup_state.dart';
part 'signup_cubit.freezed.dart';

class SignupCubit extends Cubit<SignupState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController emailFieldController;
  late final TextEditingController passFieldController;
  late final TextEditingController usernameFieldController;
  bool obsucreState = true;
  void toggleObscureState() => obsucreState = !obsucreState;
  final AuthenticationService _auth =
      GetIt.instance.get<AuthenticationService>();
  final NavigationService _nav = GetIt.instance.get<NavigationService>();

  void _initialize() {
    emailFieldController = TextEditingController();
    passFieldController = TextEditingController();
    usernameFieldController = TextEditingController();
    emit(const SignupState.ready());
  }

  SignupCubit() : super(const SignupState.loading()) {
    _initialize();
  }

  @override
  Future<void> close() async {
    emailFieldController.dispose();
    passFieldController.dispose();
    usernameFieldController.dispose();
    return super.close();
  }

  void signup() async {
    if (formKey.currentState!.validate()) {
      emit(const SignupState.loading());
      print(emailFieldController.text);
      var result = await _auth.signUp(
        email: emailFieldController.text,
        password: passFieldController.text,
        username: usernameFieldController.text,
      );
      result.fold(
        (left) => print(left),
        (right) => _nav.pushreplacementNamed(routeName: '/home'),
      );
    }
  }

  void goToLoginScreen() async {
    _nav.pushreplacementNamed(routeName: '/login');
  }
}
