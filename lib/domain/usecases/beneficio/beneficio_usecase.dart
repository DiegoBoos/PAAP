import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/beneficio_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/beneficio/beneficio_repository.dart';

class BeneficioUsecase {
  final BeneficioRepository repository;

  BeneficioUsecase(this.repository);

  Future<Either<Failure, List<BeneficioEntity>>> getBeneficiosUsecase(
      UsuarioEntity usuario) {
    return repository.getBeneficiosRepository(usuario);
  }
}
