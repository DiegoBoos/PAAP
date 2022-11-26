import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_entity.dart';
import '../../../domain/entities/v_perfil_preinversion_entity.dart';
import '../../../domain/repositories/perfil_preinversion/perfil_preinversion_repository_db.dart';
import '../../datasources/local/perfil_preinversion_local_ds.dart';

class PerfilPreInversionRepositoryDBImpl
    implements PerfilPreInversionRepositoryDB {
  final PerfilPreInversionLocalDataSource perfilesPreInversionLocalDataSource;

  PerfilPreInversionRepositoryDBImpl(
      {required this.perfilesPreInversionLocalDataSource});

  @override
  Future<Either<Failure, List<VPerfilPreInversionEntity>>>
      getPerfilesPreInversionRepositoryDB() async {
    try {
      final perfilesPreInversionDB =
          await perfilesPreInversionLocalDataSource.getPerfilesPreInversionDB();

      return Right(perfilesPreInversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<VPerfilPreInversionEntity>>>
      getPerfilesPreInversionFiltrosRepositoryDB(
          String? id, String? nombre) async {
    try {
      final perfilesPreInversionDB = await perfilesPreInversionLocalDataSource
          .getPerfilesPreInversionFiltrosDB(id!, nombre!);

      return Right(perfilesPreInversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilesPreInversionRepositoryDB(
      List<PerfilPreInversionEntity> perfiles) async {
    try {
      final result = await perfilesPreInversionLocalDataSource
          .savePerfilesPreInversionDB(perfiles);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionEntity?>>
      getPerfilPreInversionRepositoryDB(String id) async {
    try {
      final result =
          await perfilesPreInversionLocalDataSource.getPerfilPreInversionDB(id);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
