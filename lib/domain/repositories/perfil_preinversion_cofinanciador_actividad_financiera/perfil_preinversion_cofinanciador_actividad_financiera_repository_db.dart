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
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionRepositoryDB();

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorRepositoryDB(
          String perfilPreInversionId, String cofinanciadorId);

  Future<
          Either<Failure,
              PerfilPreInversionCofinanciadorActividadFinancieraEntity?>>
      getPerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(
          String perfilPreInversionId, String cofinanciadorId);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilPreInversionCofinanciadorActividadFinancieraEntity);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(
          PerfilPreInversionCofinanciadorActividadFinancieraEntity
              perfilPreInversionCofinanciadorActividadFinancieraEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity);
}
