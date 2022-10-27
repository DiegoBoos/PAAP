import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_entity.dart';
import '../../../domain/repositories/perfiles/perfiles_repository_db.dart';
import '../../datasources/local/perfiles/perfiles_local_ds.dart';
import '../../models/perfil_model.dart';

class PerfilesRepositoryDBImpl implements PerfilesRepositoryDB {
  final PerfilesLocalDataSource perfilesLocalDataSource;

  PerfilesRepositoryDBImpl({required this.perfilesLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilModel>>> getPerfilesRepositoryDB() async {
    try {
      final perfilesDB = await perfilesLocalDataSource.getPerfilesDB();

      return Right(perfilesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilModel>>> getPerfilesFiltrosRepositoryDB(
      String? id, String? nombre) async {
    try {
      final perfilesDB =
          await perfilesLocalDataSource.getPerfilesFiltrosDB(id!, nombre!);

      return Right(perfilesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilesRepositoryDB(
      List<PerfilEntity> perfiles) async {
    try {
      final perfilesDB = await perfilesLocalDataSource.savePerfilesDB(perfiles);
      return Right(perfilesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilEntity?>> getPerfilRepositoryDB(
      String id) async {
    try {
      final perfilDB = await perfilesLocalDataSource.getPerfilDB(id);

      return Right(perfilDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
