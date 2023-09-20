import 'dart:convert';

import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  String message = '';
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  if (statusCode == 422) {
    message = json.decode(response.body)['message'];
  } else if (statusCode == 500) {
    message = 'Server Error';
  } else {
    message = reasonPhrase ?? 'Error';
  }
  return message;
}
