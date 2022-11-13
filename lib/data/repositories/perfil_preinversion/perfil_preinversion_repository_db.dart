import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_entity.dart';
import '../../../domain/entities/v_perfil_preinversion_entity.dart';
import '../../../domain/repositories/perfil_preinversion/perfil_preinversion_repository_db.dart';
import '../../datasources/local/perfil_preinversion/perfil_preinversion_local_ds.dart';

class PerfilPreinversionRepositoryDBImpl
    implements PerfilPreinversionRepositoryDB {
  final PerfilPreinversionLocalDataSource perfilesPreinversionLocalDataSource;

  PerfilPreinversionRepositoryDBImpl(
      {required this.perfilesPreinversionLocalDataSource});

  @override
  Future<Either<Failure, List<VPerfilPreinversionEntity>>>
      getPerfilesPreinversionRepositoryDB() async {
    try {
      final perfilesPreinversionDB =
          await perfilesPreinversionLocalDataSource.getPerfilesPreinversionDB();

      return Right(perfilesPreinversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<VPerfilPreinversionEntity>>>
      getPerfilesPreinversionFiltrosRepositoryDB(
          String? id, String? nombre) async {
    try {
      final perfilesPreinversionDB = await perfilesPreinversionLocalDataSource
          .getPerfilesPreinversionFiltrosDB(id!, nombre!);

      return Right(perfilesPreinversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilesPreinversionRepositoryDB(
      List<PerfilPreinversionEntity> perfiles) async {
    try {
      final result = await perfilesPreinversionLocalDataSource
          .savePerfilesPreinversionDB(perfiles);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
