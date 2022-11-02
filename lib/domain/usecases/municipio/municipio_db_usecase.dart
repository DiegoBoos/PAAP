import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/municipio_entity.dart';
import '../../repositories/municipio/municipio_repository_db.dart';

class MunicipioUsecaseDB {
  final MunicipioRepositoryDB repositoryDB;

  MunicipioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<MunicipioEntity>?>> getMunicipiosUsecaseDB() {
    return repositoryDB.getMunicipiosRepositoryDB();
  }

  Future<Either<Failure, int>> saveMunicipiosUsecaseDB(
      List<MunicipioEntity> municipioEntity) {
    return repositoryDB.saveMunicipiosRepositoryDB(municipioEntity);
  }
}
