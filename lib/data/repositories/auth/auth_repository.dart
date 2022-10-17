import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../datasources/local/auth/auth_local_data_source.dart';
import '../../datasources/remote/auth/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource, required this.authLocalDataSource});

  @override
  Future<Either<Failure, UsuarioEntity>> verificacion(
      String usuarioId, String contrasena) async {
    try {
      final usuarioModel =
          await authRemoteDataSource.verificacion(usuarioId, contrasena);

      return Right(usuarioModel);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, Object?>>>> existeUsuarioDB() async {
    try {
      final usuarioDB = await authLocalDataSource.existeUsuario();

      if (usuarioDB.isEmpty) {
        return const Left(ServerFailure([
          'Usuario no encontrado, por favor inicie sesión con una conexión a internet'
        ]));
      }

      return Right(usuarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }

  @override
  Future<Either<Failure, int>> guardarUsuarioDB(
      UsuarioEntity usuarioEntity) async {
    try {
      final usuarioDB = await authLocalDataSource.guardarUsuario(usuarioEntity);
      return Right(usuarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }

  @override
  Future<Either<Failure, List<Map>>> verificacionDB(
      String usuarioId, String contrasena) async {
    try {
      final usuarioDB = await authLocalDataSource.logIn(usuarioId, contrasena);
      return Right(usuarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }

  @override
  Future<Either<Failure, List<MenuEntity>>> getMenu(
      String usuarioId, String contrasena) async {
    try {
      final menu = await authRemoteDataSource.getMenu(usuarioId, contrasena);

      return Right(menu);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }

  @override
  Future<Either<Failure, List<MenuEntity>>> getMenuDB() async {
    try {
      final menuDB = await authLocalDataSource.getMenuDB();
      final menuList =
          List<MenuEntity>.from(menuDB.map((m) => MenuEntity.fromJson(m)));

      return Right(menuList);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }

  @override
  Future<Either<Failure, int>> guardarMenuDB(
      List<MenuEntity> menuEntity) async {
    try {
      final menuDB = await authLocalDataSource.guardarMenu(menuEntity);
      return Right(menuDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }
}
