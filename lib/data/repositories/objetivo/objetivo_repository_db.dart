import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/objetivo_entity.dart';
import '../../../domain/repositories/objetivo/objetivo_repository_db.dart';
import '../../datasources/local/objetivo_local_ds.dart';

class ObjetivoRepositoryDBImpl implements ObjetivoRepositoryDB {
  final ObjetivoLocalDataSource objetivoLocalDataSource;

  ObjetivoRepositoryDBImpl({required this.objetivoLocalDataSource});

  @override
  Future<Either<Failure, List<ObjetivoEntity>>>
      getObjetivosRepositoryDB() async {
    try {
      final objetivosDB = await objetivoLocalDataSource.getObjetivosDB();

      return Right(objetivosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveObjetivosRepositoryDB(
      List<ObjetivoEntity> objetivoEntity) async {
    try {
      final objetivoDB =
          await objetivoLocalDataSource.saveObjetivos(objetivoEntity);
      return Right(objetivoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
