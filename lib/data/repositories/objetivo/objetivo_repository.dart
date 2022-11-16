import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/objetivo_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/objetivo/objetivo_repository.dart';
import '../../datasources/remote/objetivo/objetivo_remote_ds.dart';

class ObjetivoRepositoryImpl implements ObjetivoRepository {
  final ObjetivoRemoteDataSource objetivoRemoteDataSource;

  ObjetivoRepositoryImpl({required this.objetivoRemoteDataSource});

  @override
  Future<Either<Failure, List<ObjetivoEntity>>> getObjetivosRepository(
      UsuarioEntity usuario) async {
    try {
      final objetivos = await objetivoRemoteDataSource.getObjetivos(usuario);

      return Right(objetivos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
