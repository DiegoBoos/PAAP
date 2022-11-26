import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_proyecto_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_proyecto/tipo_proyecto_repository.dart';
import '../../datasources/remote/tipo_proyecto_remote_ds.dart';

class TipoProyectoRepositoryImpl implements TipoProyectoRepository {
  final TipoProyectoRemoteDataSource tipoProyectoRemoteDataSource;

  TipoProyectoRepositoryImpl({required this.tipoProyectoRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoProyectoEntity>>> getTiposProyectosRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await tipoProyectoRemoteDataSource.getTiposProyectos(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
