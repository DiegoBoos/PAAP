import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/beneficiario_preinversion/beneficiario_preinversion_repository.dart';

class BeneficiarioPreinversionUsecase {
  final BeneficiarioPreinversionRepository repository;

  BeneficiarioPreinversionUsecase(this.repository);

  Future<Either<Failure, List<BeneficiarioPreinversionEntity>>>
      getBeneficiariosPreinversionUsecase(UsuarioEntity usuario) {
    return repository.getBeneficiariosPreinversionRepository(usuario);
  }
}
