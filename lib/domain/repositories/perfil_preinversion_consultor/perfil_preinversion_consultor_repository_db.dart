import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_consultor_entity.dart';

abstract class PerfilPreInversionConsultorRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilPreInversionConsultoresRepositoryDB(String perfilPreInversionId);

  Future<Either<Failure, PerfilPreInversionConsultorEntity?>>
      getPerfilPreInversionConsultorRepositoryDB(
          String perfilPreInversionId, String consultorId, String revisionId);

  Future<Either<Failure, int>> savePerfilPreInversionConsultoresRepositoryDB(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultorEntity);

  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilesPreInversionesConsultoresProduccionRepositoryDB();

  Future<Either<Failure, int>> savePerfilPreInversionConsultorRepositoryDB(
      PerfilPreInversionConsultorEntity perfilPreInversionConsultorEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesConsultoresProduccionDBRepositoryDB(
          List<PerfilPreInversionConsultorEntity>
              perfilesPreInversionesConsultoresEntity);

  Future<Either<Failure, int>>
      deletePerfilesPreInversionesConsultoresRepositoryDB(
          String perfilPreInversionId, String consultorId, String revisionId);
}
