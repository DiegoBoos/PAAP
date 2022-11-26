import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/convocatoria_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/convocatoria/convocatoria_repository.dart';
import '../../datasources/remote/convocatoria_remote_ds.dart';

class ConvocatoriaRepositoryImpl implements ConvocatoriaRepository {
  final ConvocatoriaRemoteDataSource convocatoriaRemoteDataSource;

  ConvocatoriaRepositoryImpl({required this.convocatoriaRemoteDataSource});

  @override
  Future<Either<Failure, List<ConvocatoriaEntity>>> getConvocatoriasRepository(
      UsuarioEntity usuario) async {
    try {
      final convocatorias =
          await convocatoriaRemoteDataSource.getConvocatorias(usuario);

      return Right(convocatorias);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
