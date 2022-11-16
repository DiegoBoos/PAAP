import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ActividadRepository {
  Future<Either<Failure, List<ActividadEntity>>> getActividadesRepository(
      UsuarioEntity usuario);
}
