import 'package:dartz/dartz.dart';

import '../../../../domain/core/error/exception.dart';
import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/municipio_entity.dart';
import '../../../../domain/repositories/municipio/municipio_repository_db.dart';
import '../../datasources/local/municipio_local_ds.dart';

class MunicipioRepositoryDBImpl implements MunicipioRepositoryDB {
  final MunicipioLocalDataSource municipioLocalDataSource;

  MunicipioRepositoryDBImpl({required this.municipioLocalDataSource});

  @override
  Future<Either<Failure, List<MunicipioEntity>>>
      getMunicipiosRepositoryDB() async {
    try {
      final municipiosDB = await municipioLocalDataSource.getMunicipiosDB();

      return Right(municipiosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMunicipiosRepositoryDB(
      List<MunicipioEntity> municipioEntity) async {
    try {
      final municipioDB =
          await municipioLocalDataSource.saveMunicipios(municipioEntity);
      return Right(municipioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<MunicipioEntity>>>
      getMunicipiosByDepartamentoRepositoryDB(String departamentoId) async {
    try {
      final municipiosByDepartamentoDB = await municipioLocalDataSource
          .getMunicipiosByDepartamentoDB(departamentoId);

      return Right(municipiosByDepartamentoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getMunicipiosIdsRepositoryDB() async {
    try {
      final municipioIds = await municipioLocalDataSource.getMunicipiosIdsDB();

      return Right(municipioIds);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
