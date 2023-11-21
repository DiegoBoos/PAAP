import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/repositories/grupo_especial/grupo_especial_repository_db.dart';
import '../../datasources/local/grupo_especial_local_ds.dart';

class GrupoEspecialRepositoryDBImpl implements GrupoEspecialRepositoryDB {
  final GrupoEspecialLocalDataSource grupoEspecialLocalDataSource;

  GrupoEspecialRepositoryDBImpl({required this.grupoEspecialLocalDataSource});

  @override
  Future<Either<Failure, List<GrupoEspecialEntity>>>
      getGruposEspecialesRepositoryDB() async {
    try {
      final grupoEspecialesDB =
          await grupoEspecialLocalDataSource.getGruposEspecialesDB();

      return Right(grupoEspecialesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveGruposEspecialesRepositoryDB(
      List<GrupoEspecialEntity> grupoEspecialEntity) async {
    try {
      final grupoEspecialDB = await grupoEspecialLocalDataSource
          .saveGruposEspeciales(grupoEspecialEntity);
      return Right(grupoEspecialDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
