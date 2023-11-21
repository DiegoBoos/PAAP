import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/convocatoria_entity.dart';
import '../../repositories/convocatoria/convocatoria_repository_db.dart';

class ConvocatoriaUsecaseDB {
  final ConvocatoriaRepositoryDB repositoryDB;

  ConvocatoriaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ConvocatoriaEntity>?>>
      getConvocatoriasUsecaseDB() {
    return repositoryDB.getConvocatoriasRepositoryDB();
  }

  Future<Either<Failure, int>> saveConvocatoriaUsecaseDB(
      List<ConvocatoriaEntity> menu) {
    return repositoryDB.saveConvocatoriaRepositoryDB(menu);
  }
}
