import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/vereda_entity.dart';
import '../../../domain/repositories/vereda/vereda_repository_db.dart';
import '../../datasources/local/vereda_local_ds.dart';

class VeredaRepositoryDBImpl implements VeredaRepositoryDB {
  final VeredaLocalDataSource veredaLocalDataSource;

  VeredaRepositoryDBImpl({required this.veredaLocalDataSource});

  @override
  Future<Either<Failure, List<VeredaEntity>>> getVeredasByMunicipioRepositoryDB(
      String municipioId) async {
    try {
      final veredasDB =
          await veredaLocalDataSource.getVeredasByMunicipioDB(municipioId);

      return Right(veredasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveVeredasRepositoryDB(
      List<VeredaEntity> veredaEntity) async {
    try {
      final veredaDB = await veredaLocalDataSource.saveVeredas(veredaEntity);
      return Right(veredaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
