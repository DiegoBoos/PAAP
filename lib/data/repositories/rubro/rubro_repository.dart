import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/rubro/rubro_repository.dart';
import '../../datasources/remote/rubro_remote_ds.dart';

class RubroRepositoryImpl implements RubroRepository {
  final RubroRemoteDataSource rubroRemoteDataSource;

  RubroRepositoryImpl({required this.rubroRemoteDataSource});

  @override
  Future<Either<Failure, List<RubroEntity>>> getRubrosRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos = await rubroRemoteDataSource.getRubros(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
