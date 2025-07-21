import 'package:flutter/material.dart';
import 'package:my_connection/base/base_bloc_state.dart';
import 'package:my_connection/features/auth/blocs/authentication_bloc.dart';
import 'package:my_connection/widgets/custom_button.dart';
import 'package:my_connection/widgets/custom_card.dart';
import 'package:my_connection/widgets/custom_textfield.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState
    extends
        BaseBlocState<
          AuthenticationBloc,
          IAuthenticationBloc,
          AuthenticationPage
        > {
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
                children: [
                  Text(translation.auth.login.title, style: styles.headline1),
                  const SizedBox(height: 24),

                  // Email text field
                  CustomTextField(
                    label: translation.auth.login.email,
                    hint: translation.auth.login.email_hint,
                    controller: bloc.emailController,
                  ),
                  const SizedBox(height: 16),
                  // Password text field
                  CustomTextField(
                    label: translation.auth.login.password,
                    hint: translation.auth.login.password_hint,
                    controller: bloc.passwordController,
                  ),
                  const SizedBox(height: 24),
                  // Login button
                  CustomButton(
                    label: translation.button.login,
                    onPressed: bloc.login,
                  ),
                  const SizedBox(height: 16),
                  // Register button
                  CustomButton(
                    label: translation.button.register,
                    onPressed: bloc.register,
                    isSecondary: true,
                  ),
                  const SizedBox(height: 24),
                  // Forgot password button
                  InkWell(
                    onTap: bloc.forgotPassword,
                    child: Text(
                      translation.button.forgot_password,
                      style: styles.body1,
                    ),
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
