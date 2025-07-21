import 'package:injectable/injectable.dart';
import 'package:my_connection/base/usecase.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/utils/local_storage.dart';

@injectable
class GetAuthTokenUseCase extends UseCase<void, String> {
  final LocalStorage _storage;

  GetAuthTokenUseCase(this._storage);

  @override
  Future<String> execute(request) async {
    final token = _storage.getCachedData<String>(StorageKey.accessToken) ?? '';

    return token;
  }
}
