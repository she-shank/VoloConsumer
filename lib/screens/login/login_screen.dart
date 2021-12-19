import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volo_consumer/screens/login/logic/login_cubit.dart';
import 'package:volo_consumer/utils/text_field_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: context.read<LoginCubit>().formKey,
            child: BlocBuilder<LoginCubit, LoginState>(
              bloc: context.read<LoginCubit>(),
              builder: (context, state) {
                return ListView(
                  children: [
                    const FlutterLogo(
                      size: 100,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      enabled: state.maybeWhen(
                          loading: () => false, orElse: () => true),
                      controller:
                          context.read<LoginCubit>().emailFieldController,
                      validator: TextFieldUtils.emailValidator,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFormField(
                          enabled: state.maybeWhen(
                              loading: () => false, orElse: () => true),
                          obscureText: context.read<LoginCubit>().obsucreState,
                          controller:
                              context.read<LoginCubit>().passFieldController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'password',
                            suffix: IconButton(
                              icon: Icon(context.read<LoginCubit>().obsucreState
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => setState(
                                () => context
                                    .read<LoginCubit>()
                                    .toggleObscureState(),
                              ),
                            ),
                          ),
                          validator: TextFieldUtils.passValidator,
                        );
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    const Text("Forgot Password?"),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => null)),
                      onPressed: context.read<LoginCubit>().sigin,
                      child: state.maybeWhen(
                          loading: () => const CircularProgressIndicator(),
                          orElse: () => const Text("signIn")),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Not a member yet? Sign Up",
                        children: <TextSpan>[
                          TextSpan(
                              text: "here!",
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = context
                                    .read<LoginCubit>()
                                    .goToSignupScreen),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
