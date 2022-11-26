import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/repositories/genero/genero_repository_db.dart';
import '../../datasources/local/genero_local_ds.dart';

class GeneroRepositoryDBImpl implements GeneroRepositoryDB {
  final GeneroLocalDataSource generoLocalDataSource;

  GeneroRepositoryDBImpl({required this.generoLocalDataSource});

  @override
  Future<Either<Failure, List<GeneroEntity>>> getGenerosRepositoryDB() async {
    try {
      final generosDB = await generoLocalDataSource.getGenerosDB();

      return Right(generosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveGenerosRepositoryDB(
      List<GeneroEntity> generoEntity) async {
    try {
      final generoDB = await generoLocalDataSource.saveGeneros(generoEntity);
      return Right(generoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
