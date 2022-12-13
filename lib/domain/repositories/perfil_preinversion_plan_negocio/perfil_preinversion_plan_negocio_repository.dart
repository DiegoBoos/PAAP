import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionPlanNegocioRepository {
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionPlanNegociosRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      savePerfilesPreInversionesPlanNegociosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionPlanNegocioEntity>
              perfilPreInversionPlanNegocioEntity);
}
