import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_response.freezed.dart';
part 'status_response.g.dart';

@freezed
sealed class StatusResponse with _$StatusResponse {
  factory StatusResponse({
    required final int code,
    required final String message,
  }) = _StatusResponse;

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);
}
