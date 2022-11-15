import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB {
  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB();

  Future<
          Either<Failure,
              PerfilPreInversionCofinanciadorActividadFinancieraEntity?>>
      getPerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(
          String id);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilPreInversionCofinanciadorActividadFinancieraEntity);
}
