import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class AlianzaBeneficiarioRepository {
  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      saveAlianzasBeneficiariosRepository(UsuarioEntity usuario,
          List<AlianzaBeneficiarioEntity> perfilPreInversionBeneficiarioEntity);
}
