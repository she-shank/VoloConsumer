import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volo_consumer/screens/signup/logic/signup_cubit.dart';
import 'package:volo_consumer/utils/text_field_utils.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Signup"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: context.read<SignupCubit>().formKey,
            child: BlocBuilder<SignupCubit, SignupState>(
              bloc: context.read<SignupCubit>(),
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
                          context.read<SignupCubit>().usernameFieldController,
                      validator: TextFieldUtils.usernameValidator,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      enabled: state.maybeWhen(
                          loading: () => false, orElse: () => true),
                      controller:
                          context.read<SignupCubit>().emailFieldController,
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
                          obscureText: context.read<SignupCubit>().obsucreState,
                          controller:
                              context.read<SignupCubit>().passFieldController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'password',
                            suffix: IconButton(
                              icon: Icon(
                                  context.read<SignupCubit>().obsucreState
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                              onPressed: () => setState(
                                () => context
                                    .read<SignupCubit>()
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
                    TextButton(
                      onPressed: context.read<SignupCubit>().signup,
                      child: state.maybeWhen(
                          loading: () => const CircularProgressIndicator(),
                          orElse: () => const Text("signup")),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Existing Users login ",
                        children: <TextSpan>[
                          TextSpan(
                              text: "here!",
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = context
                                    .read<SignupCubit>()
                                    .goToLoginScreen),
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
