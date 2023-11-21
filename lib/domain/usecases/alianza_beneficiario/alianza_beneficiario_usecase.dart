import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/alianza_beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/alianza_beneficiario/alianza_beneficiario_repository.dart';

class AlianzaBeneficiarioUsecase {
  final AlianzaBeneficiarioRepository repository;

  AlianzaBeneficiarioUsecase(this.repository);

  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosUsecase(UsuarioEntity usuario) {
    return repository.getAlianzasBeneficiariosRepository(usuario);
  }

  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      saveAlianzasBeneficiariosUsecase(UsuarioEntity usuario,
          List<AlianzaBeneficiarioEntity> alianzaBeneficiarioEntity) {
    return repository.saveAlianzasBeneficiariosRepository(
        usuario, alianzaBeneficiarioEntity);
  }
}
