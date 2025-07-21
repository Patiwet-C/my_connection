import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_model.freezed.dart';
part 'users_model.g.dart';

@freezed
sealed class UsersRequest with _$UsersRequest {
  factory UsersRequest({
    required final String username,
    required final String password,
    required final String email,
  }) = _UsersRequest;

  factory UsersRequest.fromJson(Map<String, dynamic> json) =>
      _$UsersRequestFromJson(json);
}
