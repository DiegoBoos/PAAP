import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilPreInversionCofinanciadorDesembolsosRepositoryDB();

  Future<Either<Failure, PerfilPreInversionCofinanciadorDesembolsoEntity?>>
      getPerfilPreInversionCofinanciadorDesembolsoRepositoryDB(String id);

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsosRepositoryDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilPreInversionCofinanciadorDesembolsoEntity);

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorDesembolsoEntity>?>>
      getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorRepositoryDB(
          String cofinanciadorId);
}
