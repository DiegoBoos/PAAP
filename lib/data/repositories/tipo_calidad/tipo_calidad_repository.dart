import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_calidad_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_calidad/tipo_calidad_repository.dart';
import '../../datasources/remote/tipo_calidad/tipo_calidad_remote_ds.dart';

class TipoCalidadRepositoryImpl implements TipoCalidadRepository {
  final TipoCalidadRemoteDataSource tipoCalidadRemoteDataSource;

  TipoCalidadRepositoryImpl({required this.tipoCalidadRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoCalidadEntity>>> getTiposCalidadesRepository(
      UsuarioEntity usuario) async {
    try {
      final tipocalidades =
          await tipoCalidadRemoteDataSource.getTiposCalidades(usuario);

      return Right(tipocalidades);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
