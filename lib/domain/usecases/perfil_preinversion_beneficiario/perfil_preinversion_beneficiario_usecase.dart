import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_repository.dart';

class PerfilPreInversionBeneficiarioUsecase {
  final PerfilPreInversionBeneficiarioRepository repository;

  PerfilPreInversionBeneficiarioUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilPreInversionBeneficiariosUsecase(UsuarioEntity usuario) {
    return repository.getPerfilPreInversionBeneficiariosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      savePerfilesPreInversionesBeneficiariosUsecase(
          UsuarioEntity usuario,
          List<PerfilPreInversionBeneficiarioEntity>
              perfilPreInversionBeneficiarioEntity) {
    return repository.savePerfilesPreInversionesBeneficiariosRepository(
        usuario, perfilPreInversionBeneficiarioEntity);
  }
}
