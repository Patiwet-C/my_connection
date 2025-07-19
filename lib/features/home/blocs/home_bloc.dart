import 'package:injectable/injectable.dart';
import 'package:my_connection/base/activity_indicator.dart';
import 'package:my_connection/base/base_bloc.dart';
import 'package:my_connection/constants/app_constants.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/styles/app_text_styles.dart';
import 'package:my_connection/utils/common_utils.dart';
import 'package:my_connection/utils/local_storage.dart';
import 'package:rxdart/rxdart.dart';

abstract class IHomeBloc {
  ValueStream<int> get selectedIndex;
  Stream<bool> get isDarkMode;
  Stream<int> get languageChanged;

  void onTabSelected(int index);
  void onDarkModeChanged(bool isDarkMode);
  void onLanguageChanged(int index);
}

@injectable
class HomeBloc extends BaseBloc<IHomeBloc> implements IHomeBloc {
  final AppNavigator _appNavigator;
  final AppConstants _appConstants;
  final LocalStorage _localStorage;

  HomeBloc(this._appNavigator, this._appConstants, this._localStorage);

  final ActivityIndicator _activityIndicator = ActivityIndicator();

  final BehaviorSubject<int> _selectedIndex = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<bool> _isDarkMode = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<int> _languageChanged = BehaviorSubject<int>.seeded(0);

  @override
  void onInit() {
    super.onInit();

    _isDarkMode.add(
      _localStorage.getCachedData<bool>(StorageKey.darkModeSetting) ?? false,
    );
    _languageChanged.add(
      _localStorage.getCachedData<int>(StorageKey.languageSetting) ?? 0,
    );
  }

  @override
  void onTabSelected(int index) {
    _selectedIndex.add(index);
  }

  @override
  void onDarkModeChanged(bool isDarkMode) {
    _localStorage.cacheData(key: StorageKey.darkModeSetting, data: isDarkMode);
    _appConstants.setTheme(isDarkMode);
    // Update text styles to reflect theme change
    AppTextStyles.updateTheme(isDarkMode);

    _isDarkMode.add(isDarkMode);
  }

  @override
  void onLanguageChanged(int index) {
    _localStorage.cacheData(key: StorageKey.languageSetting, data: index);
    CommonUtils.changeLanguage(index);
    _languageChanged.add(index);
  }

  @override
  ValueStream<bool> get isLoading => _activityIndicator;

  @override
  IHomeBloc get bloc => this;

  @override
  ValueStream<int> get selectedIndex => _selectedIndex;

  @override
  Stream<bool> get isDarkMode => _isDarkMode;

  @override
  Stream<int> get languageChanged => _languageChanged;
}
