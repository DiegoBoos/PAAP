import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/entities/visita_entity.dart';
import '../../../domain/repositories/visita/visita_repository.dart';
import '../../datasources/remote/visita/visita_remote_ds.dart';

class VisitaRepositoryImpl implements VisitaRepository {
  final VisitaRemoteDataSource visitaRemoteDataSource;

  VisitaRepositoryImpl({required this.visitaRemoteDataSource});

  @override
  Future<Either<Failure, List<VisitaEntity>>> getVisitasRepository(
      UsuarioEntity usuario) async {
    try {
      final visitas = await visitaRemoteDataSource.getVisitas(usuario);

      return Right(visitas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveVisitaRepository(
      UsuarioEntity usuario, VisitaEntity visitaEntity) async {
    try {
      final result =
          await visitaRemoteDataSource.saveVisita(usuario, visitaEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
