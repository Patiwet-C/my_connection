import 'package:injectable/injectable.dart';
import 'package:my_connection/base/activity_indicator.dart';
import 'package:my_connection/base/base_bloc.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:rxdart/rxdart.dart';

abstract class IHomeBloc {
  ValueStream<int> get selectedIndex;

  void onTabSelected(int index);
}

@injectable
class HomeBloc extends BaseBloc<IHomeBloc> implements IHomeBloc {
  final AppNavigator _appNavigator;

  HomeBloc(this._appNavigator);

  final ActivityIndicator _activityIndicator = ActivityIndicator();

  final BehaviorSubject<int> _selectedIndex = BehaviorSubject<int>.seeded(2);

  @override
  void onTabSelected(int index) {
    _selectedIndex.add(index);
  }

  @override
  ValueStream<bool> get isLoading => _activityIndicator;

  @override
  IHomeBloc get bloc => this;

  @override
  ValueStream<int> get selectedIndex => _selectedIndex;
}
