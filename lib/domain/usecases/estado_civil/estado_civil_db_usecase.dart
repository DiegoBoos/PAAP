import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/estado_civil_entity.dart';
import '../../repositories/estado_civil/estado_civil_repository_db.dart';

class EstadoCivilUsecaseDB {
  final EstadoCivilRepositoryDB repositoryDB;

  EstadoCivilUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<EstadoCivilEntity>?>>
      getEstadosCivilesUsecaseDB() {
    return repositoryDB.getEstadosCivilesRepositoryDB();
  }

  Future<Either<Failure, int>> saveEstadosCivilesUsecaseDB(
      List<EstadoCivilEntity> estadoCivilEntity) {
    return repositoryDB.saveEstadosCivilesRepositoryDB(estadoCivilEntity);
  }
}
