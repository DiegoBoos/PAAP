import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/opcion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/opcion/opcion_repository.dart';
import '../../datasources/remote/opcion/opcion_remote_ds.dart';

class OpcionRepositoryImpl implements OpcionRepository {
  final OpcionRemoteDataSource opcionRemoteDataSource;

  OpcionRepositoryImpl({required this.opcionRemoteDataSource});

  @override
  Future<Either<Failure, List<OpcionEntity>>> getOpcionesRepository(
      UsuarioEntity usuario) async {
    try {
      final opcions = await opcionRemoteDataSource.getOpciones(usuario);

      return Right(opcions);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
