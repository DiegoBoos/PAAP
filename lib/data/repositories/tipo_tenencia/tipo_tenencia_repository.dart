import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_tenencia/tipo_tenencia_repository.dart';
import '../../datasources/remote/tipo_tenencia_remote_ds.dart';

class TipoTenenciaRepositoryImpl implements TipoTenenciaRepository {
  final TipoTenenciaRemoteDataSource tipoTenenciaRemoteDataSource;

  TipoTenenciaRepositoryImpl({required this.tipoTenenciaRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoTenenciaEntity>>> getTiposTenenciasRepository(
      UsuarioEntity usuario) async {
    try {
      final tipotenencias =
          await tipoTenenciaRemoteDataSource.getTiposTenencias(usuario);

      return Right(tipotenencias);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
