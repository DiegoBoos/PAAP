import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_entity.dart';

abstract class PerfilPreInversionCofinanciadorRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilPreInversionCofinanciadoresRepositoryDB();

  Future<Either<Failure, PerfilPreInversionCofinanciadorEntity?>>
      getPerfilPreInversionCofinanciadorRepositoryDB(String id);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadoresRepositoryDB(
          List<PerfilPreInversionCofinanciadorEntity>
              perfilPreInversionCofinanciadorEntity);
}
