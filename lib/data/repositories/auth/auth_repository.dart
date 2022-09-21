import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../datasources/local/secure_storage.dart';
import '../../datasources/remote/auth_remote_data_source.dart';
import '../../models/usuario_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UsuarioModel>> getUsuario() async {
    try {
      final usuario = await authRemoteDataSource.getUsuario();

      await SecureStorage.setUsuario(usuario);
      /* await SecureStorage.storage.write(key: 'token', value: token); */

      return Right(usuario);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
