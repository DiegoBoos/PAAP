import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/nivel_escolar_entity.dart';
import '../../../domain/repositories/nivel_escolar/nivel_escolar_repository_db.dart';
import '../../datasources/local/nivel_escolar_local_ds.dart';

class NivelEscolarRepositoryDBImpl implements NivelEscolarRepositoryDB {
  final NivelEscolarLocalDataSource nivelEscolarLocalDataSource;

  NivelEscolarRepositoryDBImpl({required this.nivelEscolarLocalDataSource});

  @override
  Future<Either<Failure, List<NivelEscolarEntity>>>
      getNivelesEscolaresRepositoryDB() async {
    try {
      final nivelesEscolaresDB =
          await nivelEscolarLocalDataSource.getNivelesEscolaresDB();

      return Right(nivelesEscolaresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNivelesEscolaresRepositoryDB(
      List<NivelEscolarEntity> nivelEscolarEntity) async {
    try {
      final nivelEscolarDB = await nivelEscolarLocalDataSource
          .saveNivelesEscolares(nivelEscolarEntity);
      return Right(nivelEscolarDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
