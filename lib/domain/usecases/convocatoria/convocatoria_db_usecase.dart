import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/convocatoria_entity.dart';
import '../../repositories/convocatoria/convocatoria_repository_db.dart';

class ConvocatoriaUsecaseDB {
  final ConvocatoriaRepositoryDB repositoryDB;

  ConvocatoriaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ConvocatoriaEntity>?>>
      getConvocatoriasUsecaseDB() {
    return repositoryDB.getConvocatoriasRepositoryDB();
  }

  Future<Either<Failure, ConvocatoriaEntity>> saveConvocatoriaUsecaseDB(
      ConvocatoriaEntity convocatoriaEntity) {
    return repositoryDB.saveConvocatoriaRepositoryDB(convocatoriaEntity);
  }
}
