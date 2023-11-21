import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/aliado/aliado_repository.dart';
import '../../datasources/remote/aliado_remote_ds.dart';

class AliadoRepositoryImpl implements AliadoRepository {
  final AliadoRemoteDataSource aliadoRemoteDataSource;

  AliadoRepositoryImpl({required this.aliadoRemoteDataSource});

  @override
  Future<Either<Failure, List<AliadoEntity>>> getAliadosRepository(
      UsuarioEntity usuario) async {
    try {
      final aliados = await aliadoRemoteDataSource.getAliados(usuario);

      return Right(aliados);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AliadoEntity>>> saveAliadosRepository(
      UsuarioEntity usuario, List<AliadoEntity> aliadosEntity) async {
    try {
      final result =
          await aliadoRemoteDataSource.saveAliados(usuario, aliadosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
