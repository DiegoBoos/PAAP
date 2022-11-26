import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/proyecto_entity.dart';
import '../../../domain/repositories/proyecto/proyecto_repository_db.dart';
import '../../datasources/local/proyecto_local_ds.dart';

class ProyectoRepositoryDBImpl implements ProyectoRepositoryDB {
  final ProyectoLocalDataSource proyectoLocalDataSource;

  ProyectoRepositoryDBImpl({required this.proyectoLocalDataSource});

  @override
  Future<Either<Failure, List<ProyectoEntity>>>
      getProyectosRepositoryDB() async {
    try {
      final proyectosDB = await proyectoLocalDataSource.getProyectosDB();

      return Right(proyectosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveProyectosRepositoryDB(
      List<ProyectoEntity> proyectoEntity) async {
    try {
      final proyectoDB =
          await proyectoLocalDataSource.saveProyectos(proyectoEntity);
      return Right(proyectoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
