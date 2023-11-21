import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/frecuencia_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class FrecuenciaRepository {
  Future<Either<Failure, List<FrecuenciaEntity>>> getFrecuenciasRepository(
      UsuarioEntity usuario);
}
