import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/agrupacion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/agrupacion/agrupacion_repository.dart';
import '../../datasources/remote/agrupacion_remote_ds.dart';

class AgrupacionRepositoryImpl implements AgrupacionRepository {
  final AgrupacionRemoteDataSource agrupacionRemoteDataSource;

  AgrupacionRepositoryImpl({required this.agrupacionRemoteDataSource});

  @override
  Future<Either<Failure, List<AgrupacionEntity>>> getAgrupacionesRepository(
      UsuarioEntity usuario) async {
    try {
      final agrupacions =
          await agrupacionRemoteDataSource.getAgrupaciones(usuario);

      return Right(agrupacions);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
