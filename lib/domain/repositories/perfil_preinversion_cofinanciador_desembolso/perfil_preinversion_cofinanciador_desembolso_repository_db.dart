import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilPreInversionCofinanciadorDesembolsosRepositoryDB();

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionRepositoryDB();

  Future<Either<Failure, PerfilPreInversionCofinanciadorDesembolsoEntity?>>
      getPerfilPreInversionCofinanciadorDesembolsoRepositoryDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsosRepositoryDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilPreInversionCofinanciadorDesembolsoEntity);

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorDesembolsoEntity>?>>
      getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorRepositoryDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsoRepositoryDB(
          PerfilPreInversionCofinanciadorDesembolsoEntity
              perfilPreInversionCofinanciadorDesembolsoEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilesPreInversionesCofinanciadoresDesembolsosEntity);
}
