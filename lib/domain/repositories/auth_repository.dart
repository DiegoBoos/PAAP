import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UsuarioEntity>> verificacion(
      String usuarioId, String contrasena);

  Future<Either<Failure, int>> guardarUsuarioDB(UsuarioEntity usuarioEntity);

  Future<Either<Failure, List<Map<String, dynamic>>>> verificacionDB(
      String usuarioId, String contrasena);

  Future<Either<Failure, List<MenuEntity>>> getMenu(
      String usuarioId, String contrasena);

  Future<Either<Failure, int>> guardarMenuDB(List<MenuEntity> menuEntity);

  Future<Either<Failure, List<MenuEntity>>> getMenuDB();
}
