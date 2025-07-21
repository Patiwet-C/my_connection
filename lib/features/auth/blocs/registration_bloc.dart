import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/base/activity_indicator.dart';
import 'package:my_connection/base/base_bloc.dart';
import 'package:my_connection/base/base_error.dart';
import 'package:my_connection/data/entities/auth/users_model.dart';
import 'package:my_connection/data/usecases/auth/post_register_usecase.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/widgets/custom_toast_dialog.dart';
import 'package:rxdart/rxdart.dart';

abstract class IRegistrationBloc {
  TextEditingController get usernameController;
  TextEditingController get emailController;
  TextEditingController get passwordController;
  TextEditingController get confirmPasswordController;

  void register();
}

@injectable
class RegistrationBloc extends BaseBloc<IRegistrationBloc>
    implements IRegistrationBloc {
  final AppNavigator _appNavigator;
  final PostRegisterUseCase _postRegisterUseCase;

  RegistrationBloc(this._appNavigator, this._postRegisterUseCase) {
    _register
        .whereNotLoading(_activityIndicator)
        .switchMap(
          (request) => _postRegisterUseCase
              .stream(request)
              .trackActivity(_activityIndicator)
              .onErrorForwardTo(_onError),
        )
        .listen((event) async {
          _showToastMessage('Registration successful');

          await Future.delayed(const Duration(seconds: 2));

          _appNavigator.pop();
        })
        .addTo(compositeSubscription);

    _onError
        .listen((event) {
          print('event: ${event.getMessage()}');
          _showToastMessage(event.getMessage(), isError: true);
        })
        .addTo(compositeSubscription);
  }

  final ActivityIndicator _activityIndicator = ActivityIndicator();
  final PublishSubject<BaseApiError> _onError = PublishSubject<BaseApiError>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final PublishSubject<UsersRequest> _register = PublishSubject<UsersRequest>();

  void _showToastMessage(String message, {bool isError = false}) {
    CustomToastDialog.showToastMessage(
      context: _appNavigator.currentState!.context,
      type: isError ? ToastType.error : ToastType.success,
      message: message,
    );
  }

  @override
  void register() {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      return;
    }

    _register.add(
      UsersRequest(
        username: _usernameController.text,
        password: _passwordController.text,
        email: _emailController.text,
      ),
    );
  }

  @override
  IRegistrationBloc get bloc => this;

  @override
  ValueStream<bool> get isLoading => _activityIndicator;

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get usernameController => _usernameController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
}
