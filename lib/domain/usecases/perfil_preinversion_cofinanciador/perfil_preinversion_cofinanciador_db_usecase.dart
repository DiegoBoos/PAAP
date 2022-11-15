import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_repository_db.dart';

class PerfilPreInversionCofinanciadorUsecaseDB {
  final PerfilPreInversionCofinanciadorRepositoryDB repositoryDB;

  PerfilPreInversionCofinanciadorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>?>>
      getPerfilPreInversionCofinanciadoresUsecaseDB() {
    return repositoryDB.getPerfilPreInversionCofinanciadoresRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionCofinanciadorEntity?>>
      getPerfilPreInversionCofinanciadorUsecaseDB(String id) {
    return repositoryDB.getPerfilPreInversionCofinanciadorRepositoryDB(id);
  }

  Future<Either<Failure, int>> savePerfilPreInversionCofinanciadoresUsecaseDB(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilPreInversionCofinanciadoresEntity) {
    return repositoryDB.savePerfilPreInversionCofinanciadoresRepositoryDB(
        perfilPreInversionCofinanciadoresEntity);
  }
}
