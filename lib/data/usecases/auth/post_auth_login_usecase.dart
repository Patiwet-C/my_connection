import 'package:injectable/injectable.dart';
import 'package:my_connection/base/usecase.dart';
import 'package:my_connection/data/entities/auth/login_model.dart';
import 'package:my_connection/data/services/auth_service.dart';

@injectable
class PostAuthLoginUseCase extends UseCase<LoginRequest, LoginResponse> {
  final AuthService _service;

  PostAuthLoginUseCase(this._service);

  @override
  Future<LoginResponse> execute(LoginRequest request) async {
    final response = await _service.postLogin(request.toJson());

    return response;
  }
}
