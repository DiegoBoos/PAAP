import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_consultor_entity.dart';
import '../../repositories/perfil_preinversion_consultor/perfil_preinversion_consultor_repository_db.dart';

class PerfilPreInversionConsultorUsecaseDB {
  final PerfilPreInversionConsultorRepositoryDB repositoryDB;

  PerfilPreInversionConsultorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>?>>
      getPerfilPreInversionConsultoresUsecaseDB() {
    return repositoryDB.getPerfilPreInversionConsultoresRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionConsultorEntity?>>
      getPerfilPreInversionConsultorUsecaseDB(String id) {
    return repositoryDB.getPerfilPreInversionConsultorRepositoryDB(id);
  }

  Future<Either<Failure, int>> savePerfilPreInversionConsultoresUsecaseDB(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultoresEntity) {
    return repositoryDB.savePerfilPreInversionConsultoresRepositoryDB(
        perfilPreInversionConsultoresEntity);
  }
}
