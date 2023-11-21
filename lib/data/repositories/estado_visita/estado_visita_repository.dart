import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/estado_visita_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/estado_visita/estado_visita_repository.dart';
import '../../datasources/remote/estado_visita_remote_ds.dart';

class EstadoVisitaRepositoryImpl implements EstadoVisitaRepository {
  final EstadoVisitaRemoteDataSource estadoVisitaRemoteDataSource;

  EstadoVisitaRepositoryImpl({required this.estadoVisitaRemoteDataSource});

  @override
  Future<Either<Failure, List<EstadoVisitaEntity>>> getEstadosVisitasRepository(
      UsuarioEntity usuario) async {
    try {
      final estadovisitas =
          await estadoVisitaRemoteDataSource.getEstadosVisitas(usuario);

      return Right(estadovisitas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
