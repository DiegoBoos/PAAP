import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/convocatoria_entity.dart';
import '../../../domain/repositories/convocatoria/convocatoria_repository_db.dart';
import '../../datasources/local/convocatoria/convocatoria_local_ds.dart';

class ConvocatoriaRepositoryDBImpl implements ConvocatoriaRepositoryDB {
  final ConvocatoriaLocalDataSource convocatoriaLocalDataSource;

  ConvocatoriaRepositoryDBImpl({required this.convocatoriaLocalDataSource});

  @override
  Future<Either<Failure, List<ConvocatoriaEntity>>>
      getConvocatoriasRepositoryDB() async {
    try {
      final convocatoriasDB =
          await convocatoriaLocalDataSource.getConvocatoriasDB();

      return Right(convocatoriasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveConvocatoriaRepositoryDB(
      List<ConvocatoriaEntity> convocatoriaEntity) async {
    try {
      final convocatoriaDB = await convocatoriaLocalDataSource
          .saveConvocatoria(convocatoriaEntity);
      return Right(convocatoriaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
