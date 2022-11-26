import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/repositories/rubro/rubro_repository_db.dart';
import '../../datasources/local/rubro_local_ds.dart';

class RubroRepositoryDBImpl implements RubroRepositoryDB {
  final RubroLocalDataSource rubroLocalDataSource;

  RubroRepositoryDBImpl({required this.rubroLocalDataSource});

  @override
  Future<Either<Failure, List<RubroEntity>>> getRubrosRepositoryDB() async {
    try {
      final rubrosDB = await rubroLocalDataSource.getRubrosDB();

      return Right(rubrosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveRubrosRepositoryDB(
      List<RubroEntity> rubroEntity) async {
    try {
      final rubroDB = await rubroLocalDataSource.saveRubros(rubroEntity);
      return Right(rubroDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
