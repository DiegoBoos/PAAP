import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/actividad_economica_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/actividad_economica/actividad_economica_repository.dart';
import '../../datasources/remote/actividad_economica_remote_ds.dart';

class ActividadEconomicaRepositoryImpl implements ActividadEconomicaRepository {
  final ActividadEconomicaRemoteDataSource actividadEconomicaRemoteDataSource;

  ActividadEconomicaRepositoryImpl(
      {required this.actividadEconomicaRemoteDataSource});

  @override
  Future<Either<Failure, List<ActividadEconomicaEntity>>>
      getActividadesEconomicasRepository(UsuarioEntity usuario) async {
    try {
      final tipoproyectos = await actividadEconomicaRemoteDataSource
          .getActividadesEconomicas(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
