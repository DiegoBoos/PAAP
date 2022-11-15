import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_repository_db.dart';

class PerfilPreInversionCofinanciadorDesembolsoUsecaseDB {
  final PerfilPreInversionCofinanciadorDesembolsoRepositoryDB repositoryDB;

  PerfilPreInversionCofinanciadorDesembolsoUsecaseDB(this.repositoryDB);

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorDesembolsoEntity>?>>
      getPerfilPreInversionCofinanciadorDesembolsosUsecaseDB() {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorDesembolsosRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionCofinanciadorDesembolsoEntity?>>
      getPerfilPreInversionCofinanciadorDesembolsoUsecaseDB(String id) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorDesembolsoRepositoryDB(id);
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsosUsecaseDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilPreInversionCofinanciadorDesembolsosEntity) {
    return repositoryDB
        .savePerfilPreInversionCofinanciadorDesembolsosRepositoryDB(
            perfilPreInversionCofinanciadorDesembolsosEntity);
  }
}
