import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/estado_civil_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class EstadoCivilRepository {
  Future<Either<Failure, List<EstadoCivilEntity>>> getEstadosCivilesRepository(
      UsuarioEntity usuario);
}
