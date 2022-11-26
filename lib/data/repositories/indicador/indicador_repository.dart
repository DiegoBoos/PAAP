import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/indicador_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/indicador/indicador_repository.dart';
import '../../datasources/remote/indicador_remote_ds.dart';

class IndicadorRepositoryImpl implements IndicadorRepository {
  final IndicadorRemoteDataSource indicadorRemoteDataSource;

  IndicadorRepositoryImpl({required this.indicadorRemoteDataSource});

  @override
  Future<Either<Failure, List<IndicadorEntity>>> getIndicadoresRepository(
      UsuarioEntity usuario) async {
    try {
      final indicadors =
          await indicadorRemoteDataSource.getIndicadores(usuario);

      return Right(indicadors);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
