import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/alianza_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/alianza/alianza_repository.dart';
import '../../datasources/remote/alianza_remote_ds.dart';

class AlianzaRepositoryImpl implements AlianzaRepository {
  final AlianzaRemoteDataSource alianzaRemoteDataSource;

  AlianzaRepositoryImpl({required this.alianzaRemoteDataSource});

  @override
  Future<Either<Failure, List<AlianzaEntity>>> getAlianzasRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos = await alianzaRemoteDataSource.getAlianzas(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
