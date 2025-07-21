import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_model.freezed.dart';
part 'status_model.g.dart';

@freezed
sealed class StatusResponse with _$StatusResponse {
  factory StatusResponse({
    @JsonKey(name: 'status_code') final int? code,
    final String? message,
  }) = _StatusResponse;

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);
}
