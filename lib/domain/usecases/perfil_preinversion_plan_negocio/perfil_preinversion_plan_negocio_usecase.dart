import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_repository.dart';

class PerfilPreInversionPlanNegocioUsecase {
  final PerfilPreInversionPlanNegocioRepository repository;

  PerfilPreInversionPlanNegocioUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionPlanesNegociosUsecase(UsuarioEntity usuario) {
    return repository.getPerfilPreInversionPlanesNegociosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      savePerfilesPreInversionesPlanesNegociosUsecase(
          UsuarioEntity usuario,
          List<PerfilPreInversionPlanNegocioEntity>
              perfilPreInversionPlanNegocioEntity) {
    return repository.savePerfilesPreInversionesPlanesNegociosRepository(
        usuario, perfilPreInversionPlanNegocioEntity);
  }
}
