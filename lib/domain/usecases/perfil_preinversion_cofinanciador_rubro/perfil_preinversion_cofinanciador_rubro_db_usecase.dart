import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_repository_db.dart';

class PerfilPreInversionCofinanciadorRubroUsecaseDB {
  final PerfilPreInversionCofinanciadorRubroRepositoryDB repositoryDB;

  PerfilPreInversionCofinanciadorRubroUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>?>>
      getPerfilPreInversionCofinanciadorRubrosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionCofinanciadorRubrosRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionCofinanciadorRubroEntity?>>
      getPerfilPreInversionCofinanciadorRubroUsecaseDB(String id) {
    return repositoryDB.getPerfilPreInversionCofinanciadorRubroRepositoryDB(id);
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubrosUsecaseDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilPreInversionCofinanciadorRubrosEntity) {
    return repositoryDB.savePerfilPreInversionCofinanciadorRubrosRepositoryDB(
        perfilPreInversionCofinanciadorRubrosEntity);
  }
}
