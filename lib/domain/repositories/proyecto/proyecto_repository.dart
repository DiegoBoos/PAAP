import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/proyecto_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ProyectoRepository {
  Future<Either<Failure, List<ProyectoEntity>>> getProyectosRepository(
      UsuarioEntity usuario);
}
