import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/cofinanciador_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/cofinanciador/cofinanciador_repository.dart';
import '../../datasources/remote/cofinanciador_remote_ds.dart';

class CofinanciadorRepositoryImpl implements CofinanciadorRepository {
  final CofinanciadorRemoteDataSource cofinanciadorRemoteDataSource;

  CofinanciadorRepositoryImpl({required this.cofinanciadorRemoteDataSource});

  @override
  Future<Either<Failure, List<CofinanciadorEntity>>>
      getCofinanciadoresRepository(UsuarioEntity usuario) async {
    try {
      final cofinanciadors =
          await cofinanciadorRemoteDataSource.getCofinanciadores(usuario);

      return Right(cofinanciadors);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
