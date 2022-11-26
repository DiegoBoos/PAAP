import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_identificacion/tipo_identificacion_repository.dart';
import '../../datasources/remote/tipo_identificacion_remote_ds.dart';

class TipoIdentificacionRepositoryImpl implements TipoIdentificacionRepository {
  final TipoIdentificacionRemoteDataSource tipoIdentificacionRemoteDataSource;

  TipoIdentificacionRepositoryImpl(
      {required this.tipoIdentificacionRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoIdentificacionEntity>>>
      getTiposIdentificacionesRepository(UsuarioEntity usuario) async {
    try {
      final tipoidentificaciones = await tipoIdentificacionRemoteDataSource
          .getTiposIdentificaciones(usuario);

      return Right(tipoidentificaciones);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
