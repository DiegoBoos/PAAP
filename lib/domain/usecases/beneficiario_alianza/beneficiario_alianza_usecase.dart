import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_alianza_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/beneficiario_alianza/beneficiario_alianza_repository.dart';

class BeneficiarioAlianzaUsecase {
  final BeneficiarioAlianzaRepository repository;

  BeneficiarioAlianzaUsecase(this.repository);

  Future<Either<Failure, List<BeneficiarioAlianzaEntity>>>
      getBeneficiariosAlianzaUsecase(UsuarioEntity usuario) {
    return repository.getBeneficiariosAlianzaRepository(usuario);
  }
}
