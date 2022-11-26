import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';

abstract class PerfilPreInversionCofinanciadorRubroRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosRepositoryDB();

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilesPreInversionesCofinanciadoresRubrosProduccionRepositoryDB();

  Future<Either<Failure, PerfilPreInversionCofinanciadorRubroEntity?>>
      getPerfilPreInversionCofinanciadorRubroRepositoryDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId,
          String actividadFinancieraId,
          String rubroId);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubrosRepositoryDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilPreInversionCofinanciadorRubroEntity);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>?>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciadorRepositoryDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId,
          String actividadFinancieraId,
          String rubroId);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubroRepositoryDB(
          PerfilPreInversionCofinanciadorRubroEntity
              perfilPreInversionCofinanciadorRubroEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresRubrosProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilesPreInversionesCofinanciadoresRubrosEntity);
}
