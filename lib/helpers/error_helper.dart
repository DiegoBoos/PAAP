import 'dart:convert';
import 'package:http/http.dart';

class ErrorHelper {
  static Map<String, dynamic> manageError(Response resp) {
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('msg')) {
      return {'errorMsg': decodedResp['msg'], 'statusCode': resp.statusCode};
    }

    if (decodedResp.containsKey('errors')) {
      return {
        'errorMsg': decodedResp['errors'][0]['msg'],
        'statusCode': resp.statusCode
      };
    }
    return {
      'errorMsg': 'Excepción no controlada',
      'statusCode': resp.statusCode
    };
  }
}
