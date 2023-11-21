import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../../domain/repositories/perfil_preinversion_precio/perfil_preinversion_precio_repository_db.dart';
import '../../datasources/local/perfil_preinversion_precio_local_ds.dart';

class PerfilPreInversionPrecioRepositoryDBImpl
    implements PerfilPreInversionPrecioRepositoryDB {
  final PerfilPreInversionPrecioLocalDataSource
      perfilPreInversionPrecioLocalDataSource;

  PerfilPreInversionPrecioRepositoryDBImpl(
      {required this.perfilPreInversionPrecioLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilPreInversionPreciosRepositoryDB() async {
    try {
      final perfilPreInversionPreciosDB =
          await perfilPreInversionPrecioLocalDataSource
              .getPerfilPreInversionPrecios();

      return Right(perfilPreInversionPreciosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilesPreInversionesPreciosRepositoryDB(
          String perfilPreInversionId) async {
    try {
      final perfilPreInversionPreciosDB =
          await perfilPreInversionPrecioLocalDataSource
              .getPerfilesPreInversionesPrecios(perfilPreInversionId);

      return Right(perfilPreInversionPreciosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionPrecioEntity?>>
      getPerfilPreInversionPrecioRepositoryDB(
          String perfilPreInversionId) async {
    try {
      final perfilPreInversionPrecioDB =
          await perfilPreInversionPrecioLocalDataSource
              .getPerfilPreInversionPrecio(perfilPreInversionId);

      return Right(perfilPreInversionPrecioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionPreciosRepositoryDB(
      List<PerfilPreInversionPrecioEntity>
          perfilPreInversionPrecioEntity) async {
    try {
      final result = await perfilPreInversionPrecioLocalDataSource
          .savePerfilPreInversionPrecios(perfilPreInversionPrecioEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilesPreInversionesPreciosProduccionRepositoryDB() async {
    try {
      final perfilPreInversionPreciosDB =
          await perfilPreInversionPrecioLocalDataSource
              .getPerfilesPreInversionesPreciosProduccion();

      return Right(perfilPreInversionPreciosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionPrecioRepositoryDB(
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity) async {
    try {
      final perfilPreInversionPrecioDB =
          await perfilPreInversionPrecioLocalDataSource
              .savePerfilPreInversionPrecio(perfilPreInversionPrecioEntity);
      return Right(perfilPreInversionPrecioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> deletePerfilesPreInversionesPreciosRepositoryDB(
      String perfilPreInversionId,
      String productoId,
      String tipoCalidadId) async {
    try {
      final result = await perfilPreInversionPrecioLocalDataSource
          .deletePerfilesPreInversionesPreciosDB(
              perfilPreInversionId, productoId, tipoCalidadId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPreciosProduccionDBRepositoryDB(
          List<PerfilPreInversionPrecioEntity>
              perfilesPreInversionesPreciosEntity) async {
    try {
      final result = await perfilPreInversionPrecioLocalDataSource
          .updatePerfilesPreInversionesPreciosProduccion(
              perfilesPreInversionesPreciosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
