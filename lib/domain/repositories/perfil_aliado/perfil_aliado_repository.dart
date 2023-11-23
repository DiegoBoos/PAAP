import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_aliado_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilAliadoRepository {
  Future<Either<Failure, List<PerfilAliadoEntity>>> getPerfilAliadosRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilAliadoEntity>>>
      savePerfilesAliadosRepository(UsuarioEntity usuario,
          List<PerfilAliadoEntity> perfilesAliadosEntity);
}
