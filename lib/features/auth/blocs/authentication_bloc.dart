import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/base/activity_indicator.dart';
import 'package:my_connection/base/base_bloc.dart';
import 'package:my_connection/base/base_error.dart';
import 'package:my_connection/constants/router_name.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/data/entities/auth/login_model.dart';
import 'package:my_connection/data/usecases/auth/post_auth_login_usecase.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/utils/local_storage.dart';
import 'package:my_connection/widgets/custom_toast_dialog.dart';
import 'package:rxdart/rxdart.dart';

abstract class IAuthenticationBloc {
  TextEditingController get emailController;
  TextEditingController get passwordController;

  void login();
  void register();
  void forgotPassword();
}

@injectable
class AuthenticationBloc extends BaseBloc<IAuthenticationBloc>
    implements IAuthenticationBloc {
  final AppNavigator _appNavigator;
  final LocalStorage _localStorage;
  final PostAuthLoginUseCase _postAuthLoginUseCase;

  AuthenticationBloc(
    this._appNavigator,
    this._localStorage,
    this._postAuthLoginUseCase,
  ) {
    _login.stream
        .whereNotLoading(_activityIndicator)
        .switchMap(
          (request) => _postAuthLoginUseCase
              .stream(request)
              .trackActivity(_activityIndicator)
              .onErrorForwardTo(_onError),
        )
        .listen((event) {
          final loginData = event.data;

          if (loginData?.token != null) {
            _localStorage.cacheData(
              key: StorageKey.accessToken,
              data: loginData?.token,
            );

            _appNavigator.pushNamed(RouterName.homePage);
          }
        })
        .addTo(compositeSubscription);

    _onError.listen((event) {
      CustomToastDialog.showToastMessage(
        context: _appNavigator.currentState!.context,
        type: ToastType.error,
        message: event.getMessage(),
      );
    });
  }

  final ActivityIndicator _activityIndicator = ActivityIndicator();
  final PublishSubject<BaseApiError> _onError = PublishSubject<BaseApiError>();

  final PublishSubject<LoginRequest> _login = PublishSubject<LoginRequest>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  IAuthenticationBloc get bloc => this;

  @override
  ValueStream<bool> get isLoading => _activityIndicator;

  @override
  void login() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }

    _login.add(
      LoginRequest(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  void register() {
    _appNavigator.pushNamed(RouterName.registrationPage);
  }

  @override
  void forgotPassword() {
    // TODO: implement forgotPassword
  }

  @override
  TextEditingController get emailController => _emailController;
  @override
  TextEditingController get passwordController => _passwordController;
}
