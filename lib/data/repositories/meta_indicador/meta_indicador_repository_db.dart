import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/meta_indicador_entity.dart';
import '../../../domain/repositories/meta_indicador/meta_indicador_repository_db.dart';
import '../../datasources/local/meta_indicador_local_ds.dart';

class MetaIndicadorRepositoryDBImpl implements MetaIndicadorRepositoryDB {
  final MetaIndicadorLocalDataSource metaIndicadorLocalDataSource;

  MetaIndicadorRepositoryDBImpl({required this.metaIndicadorLocalDataSource});

  @override
  Future<Either<Failure, List<MetaIndicadorEntity>>>
      getMetasIndicadoresRepositoryDB() async {
    try {
      final metasIndicadoresDB =
          await metaIndicadorLocalDataSource.getMetasIndicadoresDB();

      return Right(metasIndicadoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMetasIndicadoresRepositoryDB(
      List<MetaIndicadorEntity> metaIndicadorEntity) async {
    try {
      final metaIndicadorDB = await metaIndicadorLocalDataSource
          .saveMetasIndicadores(metaIndicadorEntity);
      return Right(metaIndicadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
