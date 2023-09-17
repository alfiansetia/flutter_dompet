import 'dart:convert';

import 'package:flutter_dompet/data/models/custom_error.dart';
import 'package:http/http.dart' as http;

CustomError httpErrorHandler(http.Response response) {
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
  return CustomError(message: message);
}
