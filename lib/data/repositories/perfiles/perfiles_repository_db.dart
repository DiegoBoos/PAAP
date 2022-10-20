import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_entity.dart';
import '../../../domain/repositories/perfiles/perfiles_repository_db.dart';
import '../../datasources/local/perfiles/perfiles_local_ds.dart';

class PerfilesRepositoryDBImpl implements PerfilesRepositoryDB {
  final PerfilesLocalDataSource perfilesLocalDataSource;

  PerfilesRepositoryDBImpl({required this.perfilesLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepositoryDB() async {
    try {
      final perfilesDB = await perfilesLocalDataSource.getPerfilesDB();
      final perfilesList = List<PerfilEntity>.from(
          perfilesDB.map((m) => PerfilEntity.fromJson(m)));

      return Right(perfilesList);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosRepositoryDB(
      String id, String nombre) async {
    try {
      final perfilesDB = await perfilesLocalDataSource.getPerfilesDB();
      final perfilesList = List<PerfilEntity>.from(
          perfilesDB.map((m) => PerfilEntity.fromJson(m)));

      return Right(perfilesList);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilesRepositoryDB(
      List<PerfilEntity> perfiles) {
    // TODO: implement savePerfilesRepositoryDB
    throw UnimplementedError();
  }
}
