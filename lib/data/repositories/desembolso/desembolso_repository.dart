import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/desembolso_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/desembolso/desembolso_repository.dart';
import '../../datasources/remote/desembolso/desembolso_remote_ds.dart';

class DesembolsoRepositoryImpl implements DesembolsoRepository {
  final DesembolsoRemoteDataSource desembolsoRemoteDataSource;

  DesembolsoRepositoryImpl({required this.desembolsoRemoteDataSource});

  @override
  Future<Either<Failure, List<DesembolsoEntity>>> getDesembolsosRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await desembolsoRemoteDataSource.getDesembolsos(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
