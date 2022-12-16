import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficio_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class BeneficioRepository {
  Future<Either<Failure, List<BeneficioEntity>>> getBeneficiosRepository(
      UsuarioEntity usuario);
}
