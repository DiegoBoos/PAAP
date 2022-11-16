import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/indicador_entity.dart';
import '../../repositories/indicador/indicador_repository_db.dart';

class IndicadorUsecaseDB {
  final IndicadorRepositoryDB repositoryDB;

  IndicadorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<IndicadorEntity>?>> getIndicadoresUsecaseDB() {
    return repositoryDB.getIndicadoresRepositoryDB();
  }

  Future<Either<Failure, IndicadorEntity?>> getIndicadorUsecaseDB(String id) {
    return repositoryDB.getIndicadorRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveIndicadoresUsecaseDB(
      List<IndicadorEntity> indicadorEntity) {
    return repositoryDB.saveIndicadoresRepositoryDB(indicadorEntity);
  }
}
