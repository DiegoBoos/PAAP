import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../../domain/repositories/perfil_preinversion_precio/perfil_preinversion_precio_repository_db.dart';
import '../../datasources/local/perfil_preinversion_precio/perfil_preinversion_precio_local_ds.dart';

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
              .getPerfilPreInversionPreciosDB();

      return Right(perfilPreInversionPreciosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionPrecioEntity?>>
      getPerfilPreInversionPrecioRepositoryDB(String id) async {
    try {
      final perfilPreInversionPrecioDB =
          await perfilPreInversionPrecioLocalDataSource
              .getPerfilPreInversionPrecioDB(id);

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
}
