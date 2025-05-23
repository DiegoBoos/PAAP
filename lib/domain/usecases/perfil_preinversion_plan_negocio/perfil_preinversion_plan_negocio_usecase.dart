import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_repository.dart';

class PerfilPreInversionPlanNegocioUsecase {
  final PerfilPreInversionPlanNegocioRepository repository;

  PerfilPreInversionPlanNegocioUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionPlanNegociosUsecase(UsuarioEntity usuario) {
    return repository.getPerfilPreInversionPlanNegociosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      savePerfilesPreInversionesPlanNegociosUsecase(
          UsuarioEntity usuario,
          List<PerfilPreInversionPlanNegocioEntity>
              perfilPreInversionPlanNegocioEntity) {
    return repository.savePerfilesPreInversionesPlanNegociosRepository(
        usuario, perfilPreInversionPlanNegocioEntity);
  }
}
