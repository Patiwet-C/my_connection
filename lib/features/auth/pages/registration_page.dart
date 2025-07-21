import 'package:flutter/material.dart';
import 'package:my_connection/base/base_bloc_state.dart';
import 'package:my_connection/features/auth/blocs/registration_bloc.dart';
import 'package:my_connection/widgets/custom_button.dart';
import 'package:my_connection/widgets/custom_card.dart';
import 'package:my_connection/widgets/custom_textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState
    extends
        BaseBlocState<RegistrationBloc, IRegistrationBloc, RegistrationPage> {
  @override
  Widget buildPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Text(
                    translation.auth.registration.title,
                    style: styles.headline1,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: bloc.usernameController,
                    label: translation.auth.registration.username,
                    hint: translation.auth.registration.username_hint,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: bloc.emailController,
                    label: translation.auth.registration.email,
                    hint: translation.auth.registration.email_hint,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: bloc.passwordController,
                    label: translation.auth.registration.password,
                    hint: translation.auth.registration.password_hint,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: bloc.confirmPasswordController,
                    label: translation.auth.registration.confirm_password,
                    hint: translation.auth.registration.password_hint,
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 24),
                  CustomButton(
                    label: translation.button.register,
                    onPressed: bloc.register,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
