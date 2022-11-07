import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/alianza_entity.dart';
import '../../../domain/repositories/alianza/alianza_repository_db.dart';
import '../../datasources/local/alianzas/alianzas_local_ds.dart';

class AlianzaRepositoryDBImpl implements AlianzaRepositoryDB {
  final AlianzasLocalDataSource alianzaLocalDataSource;

  AlianzaRepositoryDBImpl({required this.alianzaLocalDataSource});

  @override
  Future<Either<Failure, List<AlianzaEntity>>> getAlianzasRepositoryDB() async {
    try {
      final alianzasDB = await alianzaLocalDataSource.getAlianzasDB();

      return Right(alianzasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzasRepositoryDB(
      List<AlianzaEntity> alianzaEntity) async {
    try {
      final alianzaDB =
          await alianzaLocalDataSource.saveAlianzasDB(alianzaEntity);
      return Right(alianzaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
