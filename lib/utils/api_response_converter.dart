class ApiResponseConverter {
  static T extractData<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final data = json['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Data field is null in API response');
    }
    return fromJson(data);
  }
}
