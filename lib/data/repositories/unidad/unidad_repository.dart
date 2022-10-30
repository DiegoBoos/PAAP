import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/unidad_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/unidad/unidad_repository.dart';
import '../../datasources/remote/unidad/unidad_remote_ds.dart';

class UnidadRepositoryImpl implements UnidadRepository {
  final UnidadRemoteDataSource unidadRemoteDataSource;

  UnidadRepositoryImpl({required this.unidadRemoteDataSource});

  @override
  Future<Either<Failure, List<UnidadEntity>>> getUnidadesRepository(
      UsuarioEntity usuario) async {
    try {
      final unidads = await unidadRemoteDataSource.getUnidades(usuario);

      return Right(unidads);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
