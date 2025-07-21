import 'package:injectable/injectable.dart';
import 'package:my_connection/base/usecase.dart';
import 'package:my_connection/data/entities/auth/users_model.dart';
import 'package:my_connection/data/services/auth_service.dart';

@injectable
class PostRegisterUseCase extends UseCase<UsersRequest, void> {
  final AuthService _service;

  PostRegisterUseCase(this._service);

  @override
  Future<void> execute(UsersRequest request) async {
    await _service.postRegister(request.toJson());
  }
}
