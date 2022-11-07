import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/desembolso_entity.dart';
import '../../../domain/repositories/desembolso/desembolso_repository_db.dart';
import '../../datasources/local/desembolso/desembolso_local_ds.dart';

class DesembolsoRepositoryDBImpl implements DesembolsoRepositoryDB {
  final DesembolsoLocalDataSource desembolsoLocalDataSource;

  DesembolsoRepositoryDBImpl({required this.desembolsoLocalDataSource});

  @override
  Future<Either<Failure, List<DesembolsoEntity>>>
      getDesembolsosRepositoryDB() async {
    try {
      final desembolsosDB = await desembolsoLocalDataSource.getDesembolsosDB();

      return Right(desembolsosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveDesembolsosRepositoryDB(
      List<DesembolsoEntity> desembolsoEntity) async {
    try {
      final desembolsoDB =
          await desembolsoLocalDataSource.saveDesembolsos(desembolsoEntity);
      return Right(desembolsoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
