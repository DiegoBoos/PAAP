import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionBeneficiarioRepository {
  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilPreInversionBeneficiariosRepository(UsuarioEntity usuario);
}
