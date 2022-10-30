import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_proyecto_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoProyectoRepository {
  Future<Either<Failure, List<TipoProyectoEntity>>> getTiposProyectosRepository(
      UsuarioEntity usuario);
}
