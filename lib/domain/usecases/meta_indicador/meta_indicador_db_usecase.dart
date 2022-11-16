import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/meta_indicador_entity.dart';
import '../../repositories/meta_indicador/meta_indicador_repository_db.dart';

class MetaIndicadorUsecaseDB {
  final MetaIndicadorRepositoryDB repositoryDB;

  MetaIndicadorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<MetaIndicadorEntity>?>>
      getMetasIndicadoresUsecaseDB() {
    return repositoryDB.getMetasIndicadoresRepositoryDB();
  }

  Future<Either<Failure, int>> saveMetasIndicadoresUsecaseDB(
      List<MetaIndicadorEntity> metaIndicadorEntity) {
    return repositoryDB.saveMetasIndicadoresRepositoryDB(metaIndicadorEntity);
  }
}
