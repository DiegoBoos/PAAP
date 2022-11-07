import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/estado_civil_entity.dart';
import '../../../domain/repositories/estado_civil/estado_civil_repository_db.dart';
import '../../datasources/local/estado_civil/estado_civil_local_ds.dart';

class EstadoCivilRepositoryDBImpl implements EstadoCivilRepositoryDB {
  final EstadoCivilLocalDataSource estadoCivilLocalDataSource;

  EstadoCivilRepositoryDBImpl({required this.estadoCivilLocalDataSource});

  @override
  Future<Either<Failure, List<EstadoCivilEntity>>>
      getEstadosCivilesRepositoryDB() async {
    try {
      final estadocivilesDB =
          await estadoCivilLocalDataSource.getEstadosCivilesDB();

      return Right(estadocivilesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEstadosCivilesRepositoryDB(
      List<EstadoCivilEntity> estadocivilEntity) async {
    try {
      final estadocivilDB = await estadoCivilLocalDataSource
          .saveEstadosCiviles(estadocivilEntity);
      return Right(estadocivilDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
