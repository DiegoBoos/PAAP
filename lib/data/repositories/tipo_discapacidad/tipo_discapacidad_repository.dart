import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_discapacidad_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_discapacidad/tipo_discapacidad_repository.dart';
import '../../datasources/remote/tipo_discapacidad/tipo_discapacidad_remote_ds.dart';

class TipoDiscapacidadRepositoryImpl implements TipoDiscapacidadRepository {
  final TipoDiscapacidadRemoteDataSource tipoDiscapacidadRemoteDataSource;

  TipoDiscapacidadRepositoryImpl(
      {required this.tipoDiscapacidadRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoDiscapacidadEntity>>>
      getTiposDiscapacidadesRepository(UsuarioEntity usuario) async {
    try {
      final tiposDiscapacidades = await tipoDiscapacidadRemoteDataSource
          .getTiposDiscapacidades(usuario);

      return Right(tiposDiscapacidades);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
