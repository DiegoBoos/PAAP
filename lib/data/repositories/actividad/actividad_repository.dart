import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/actividad_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/actividad/actividad_repository.dart';
import '../../datasources/remote/actividad_remote_ds.dart';

class ActividadRepositoryImpl implements ActividadRepository {
  final ActividadRemoteDataSource actividadRemoteDataSource;

  ActividadRepositoryImpl({required this.actividadRemoteDataSource});

  @override
  Future<Either<Failure, List<ActividadEntity>>> getActividadesRepository(
      UsuarioEntity usuario) async {
    try {
      final actividads =
          await actividadRemoteDataSource.getActividades(usuario);

      return Right(actividads);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
