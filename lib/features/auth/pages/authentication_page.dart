import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool get isShowAppBar => false;

  @override
  Widget buildPageContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(translation.auth.login.title, style: styles.headline1),
                const SizedBox(height: 24),
                // Email text field
                CustomTextField(
                  label: translation.auth.login.email,
                  hint: translation.auth.login.email_hint,
                  controller: bloc.emailController,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: <TextInputFormatter>[
                    // FilteringTextInputFormatter.allow(CommonRegex.emailRegex),
                  ],
                ),
                const SizedBox(height: 16),
                // Password text field
                StreamBuilder<bool>(
                  stream: bloc.isPasswordObscure,
                  builder: (_, snapshot) {
                    final bool isObscure = snapshot.data ?? true;

                    return CustomTextField(
                      label: translation.auth.login.password,
                      hint: translation.auth.login.password_hint,
                      controller: bloc.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscure,
                      onObscureIconPressed: bloc.onPasswordObscureIconPressed,
                      inputFormatters: <TextInputFormatter>[
                        // FilteringTextInputFormatter.allow(
                        // CommonRegex.passwordRegex,
                        // ),
                      ],
                    );
                  },
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
      ),
    );
  }
}
