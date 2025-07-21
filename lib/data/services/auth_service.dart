import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/app_constants.dart';
import 'package:my_connection/data/entities/auth/login_model.dart';
import 'package:my_connection/di/dio_client.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
@injectable
abstract class AuthService {
  @factoryMethod
  factory AuthService(DioClient dioClient, AppConstants appConstants) =>
      _AuthService(dioClient.client, baseUrl: appConstants.getBaseUrl());

  @POST('/v1/register')
  Future<void> postRegister(@Body() Map<String, dynamic> request);

  @POST('/v1/auth/login')
  Future<LoginResponse> postLogin(@Body() Map<String, dynamic> request);
}
