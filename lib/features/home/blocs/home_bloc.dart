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
  int get languageIndex;
  int get darkModeIndex;

  void onTabSelected(int index);
  void onDarkModeChanged(int index);
  void onLanguageChanged(int index);
}

@injectable
class HomeBloc extends BaseBloc<IHomeBloc> implements IHomeBloc {
  final AppNavigator _appNavigator;
  final AppConstants _appConstants;
  final LocalStorage _localStorage;

  HomeBloc(this._appNavigator, this._appConstants, this._localStorage);

  final ActivityIndicator _activityIndicator = ActivityIndicator();

  final BehaviorSubject<int> _selectedIndex = BehaviorSubject<int>.seeded(2);

  int _languageIndex = 0;
  int _darkModeIndex = 0;

  @override
  void onInit() {
    super.onInit();

    final isDarkMode =
        _localStorage.getCachedData<bool>(StorageKey.darkModeSetting) ?? false;
    _languageIndex =
        _localStorage.getCachedData<int>(StorageKey.languageSetting) ?? 0;

    _darkModeIndex = isDarkMode ? 1 : 0;
  }

  @override
  void onTabSelected(int index) {
    _selectedIndex.add(index);
  }

  @override
  void onDarkModeChanged(int index) {
    final isDarkMode = index == 0;
    _localStorage.cacheData(key: StorageKey.darkModeSetting, data: isDarkMode);
    _appConstants.setTheme(isDarkMode);
    // Update text styles to reflect theme change
    AppTextStyles.updateTheme(isDarkMode);
    _darkModeIndex = index;
  }

  @override
  void onLanguageChanged(int index) {
    _localStorage.cacheData(key: StorageKey.languageSetting, data: index);
    CommonUtils.changeLanguage(index);
    _languageIndex = index;
  }

  @override
  ValueStream<bool> get isLoading => _activityIndicator;

  @override
  IHomeBloc get bloc => this;

  @override
  ValueStream<int> get selectedIndex => _selectedIndex;

  @override
  int get languageIndex => _languageIndex;

  @override
  int get darkModeIndex => _darkModeIndex;
}
