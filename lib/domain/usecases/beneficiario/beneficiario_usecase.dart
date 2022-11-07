import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/beneficiario/beneficiario_repository.dart';

class BeneficiarioUsecase {
  final BeneficiarioRepository repository;

  BeneficiarioUsecase(this.repository);

  Future<Either<Failure, List<BeneficiarioEntity>>> getBeneficiariosUsecase(
      UsuarioEntity usuario) {
    return repository.getBeneficiariosRepository(usuario);
  }
}
