import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/app.dart';
import 'package:my_connection/base/activity_indicator.dart';
import 'package:my_connection/base/base_bloc.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/utils/local_storage.dart';
import 'package:rxdart/rxdart.dart';

abstract class ISettingsBloc {
  int get languageIndex;
  Stream<bool> get isDarkMode;

  void onDarkModeChanged(BuildContext context, bool isDarkMode);
  void onLanguageChanged(int index);
}

@injectable
class SettingsBloc extends BaseBloc<ISettingsBloc> implements ISettingsBloc {
  final LocalStorage _localStorage;

  SettingsBloc(this._localStorage);

  final ActivityIndicator _activityIndicator = ActivityIndicator();
  final BehaviorSubject<bool> _isDarkMode = BehaviorSubject<bool>.seeded(false);

  int _languageIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _languageIndex =
        _localStorage.getCachedData<int>(StorageKey.languageSetting) ?? 0;
    _isDarkMode.add(
      _localStorage.getCachedData<bool>(StorageKey.darkModeSetting) ?? false,
    );
  }

  @override
  void onDarkModeChanged(BuildContext context, bool isDarkMode) {
    _localStorage.cacheData(key: StorageKey.darkModeSetting, data: isDarkMode);
    MyConnectionApp.of(context).changeTheme(isDarkMode);
    _isDarkMode.add(isDarkMode);
  }

  @override
  void onLanguageChanged(int index) {
    _localStorage.cacheData(key: StorageKey.languageSetting, data: index);
    LocaleSettings.setLocale(index == 0 ? AppLocale.en : AppLocale.th);
    _languageIndex = index;
  }

  @override
  ValueStream<bool> get isLoading => _activityIndicator;

  @override
  ISettingsBloc get bloc => this;

  @override
  int get languageIndex => _languageIndex;

  @override
  Stream<bool> get isDarkMode => _isDarkMode;
}
