import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/criterio/criterio_repository.dart';
import '../../datasources/remote/criterio_remote_ds.dart';

class CriterioRepositoryImpl implements CriterioRepository {
  final CriterioRemoteDataSource criterioRemoteDataSource;

  CriterioRepositoryImpl({required this.criterioRemoteDataSource});

  @override
  Future<Either<Failure, List<CriterioEntity>>> getCriteriosRepository(
      UsuarioEntity usuario) async {
    try {
      final criterios = await criterioRemoteDataSource.getCriterios(usuario);

      return Right(criterios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
