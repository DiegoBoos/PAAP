import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/estado_civil_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/estado_civil/estado_civil_repository.dart';
import '../../datasources/remote/estado_civil_remote_ds.dart';

class EstadoCivilRepositoryImpl implements EstadoCivilRepository {
  final EstadoCivilRemoteDataSource estadoCivilRemoteDataSource;

  EstadoCivilRepositoryImpl({required this.estadoCivilRemoteDataSource});

  @override
  Future<Either<Failure, List<EstadoCivilEntity>>> getEstadosCivilesRepository(
      UsuarioEntity usuario) async {
    try {
      final estadociviles =
          await estadoCivilRemoteDataSource.getEstadosCiviles(usuario);

      return Right(estadociviles);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
