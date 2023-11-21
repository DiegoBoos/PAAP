import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/residencia_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/residencia/residencia_repository.dart';
import '../../datasources/remote/residencia_remote_ds.dart';

class ResidenciaRepositoryImpl implements ResidenciaRepository {
  final ResidenciaRemoteDataSource residenciaRemoteDataSource;

  ResidenciaRepositoryImpl({required this.residenciaRemoteDataSource});

  @override
  Future<Either<Failure, List<ResidenciaEntity>>> getResidenciasRepository(
      UsuarioEntity usuario) async {
    try {
      final residencias =
          await residenciaRemoteDataSource.getResidencias(usuario);

      return Right(residencias);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
