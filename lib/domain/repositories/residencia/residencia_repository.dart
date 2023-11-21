import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/residencia_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ResidenciaRepository {
  Future<Either<Failure, List<ResidenciaEntity>>> getResidenciasRepository(
      UsuarioEntity usuario);
}
