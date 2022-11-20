import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_entity.dart';

abstract class PerfilPreInversionCofinanciadorRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilPreInversionCofinanciadoresRepositoryDB();

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilesPreInversionesCofinanciadoresProduccionRepositoryDB();

  Future<Either<Failure, PerfilPreInversionCofinanciadorEntity?>>
      getPerfilPreInversionCofinanciadorRepositoryDB(String id);

  Future<Either<Failure, int>>
      savePerfilesPreInversionesCofinanciadoresRepositoryDB(
          List<PerfilPreInversionCofinanciadorEntity>
              perfilPreInversionCofinanciadorEntity);
  Future<Either<Failure, int>> savePerfilPreInversionCofinanciadorRepositoryDB(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorEntity>
              perfilesPreInversionesCofinanciadoresEntity);
}
