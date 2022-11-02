import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_visita_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_visita/tipo_visita_repository.dart';
import '../../datasources/remote/tipo_visita/tipo_visita_remote_ds.dart';

class TipoVisitaRepositoryImpl implements TipoVisitaRepository {
  final TipoVisitaRemoteDataSource tipoVisitaRemoteDataSource;

  TipoVisitaRepositoryImpl({required this.tipoVisitaRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoVisitaEntity>>> getTiposVisitasRepository(
      UsuarioEntity usuario) async {
    try {
      final tipovisitas =
          await tipoVisitaRemoteDataSource.getTiposVisitas(usuario);

      return Right(tipovisitas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
