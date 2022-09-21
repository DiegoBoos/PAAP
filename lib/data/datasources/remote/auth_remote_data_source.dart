import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../domain/core/error/exception.dart';
import '../../models/usuario_model.dart';

abstract class AuthRemoteDataSource {
  Future<UsuarioModel> getUsuario();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client httpClient;
  AuthRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<UsuarioModel> getUsuario() async {
    final url = Uri.parse('');
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
