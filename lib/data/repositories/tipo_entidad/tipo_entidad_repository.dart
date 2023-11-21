import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/tipo_entidad_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_entidad/tipo_entidad_repository.dart';
import '../../datasources/remote/tipo_entidad_remote_ds.dart';

class TipoEntidadRepositoryImpl implements TipoEntidadRepository {
  final TipoEntidadRemoteDataSource tipoEntidadRemoteDataSource;

  TipoEntidadRepositoryImpl({required this.tipoEntidadRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoEntidadEntity>>> getTiposEntidadesRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoentidades =
          await tipoEntidadRemoteDataSource.getTiposEntidades(usuario);

      return Right(tipoentidades);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
