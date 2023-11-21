import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/actividad_financiera/actividad_financiera_repository.dart';
import '../../datasources/remote/actividad_financiera_remote_ds.dart';

class ActividadFinancieraRepositoryImpl
    implements ActividadFinancieraRepository {
  final ActividadFinancieraRemoteDataSource actividadFinancieraRemoteDataSource;

  ActividadFinancieraRepositoryImpl(
      {required this.actividadFinancieraRemoteDataSource});

  @override
  Future<Either<Failure, List<ActividadFinancieraEntity>>>
      getActividadesFinancierasRepository(UsuarioEntity usuario) async {
    try {
      final tipoproyectos = await actividadFinancieraRemoteDataSource
          .getActividadesFinancieras(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
