import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/departamento/departamento_repository.dart';
import '../../datasources/remote/departamento_remote_ds.dart';

class DepartamentoRepositoryImpl implements DepartamentoRepository {
  final DepartamentoRemoteDataSource departamentoRemoteDataSource;

  DepartamentoRepositoryImpl({required this.departamentoRemoteDataSource});

  @override
  Future<Either<Failure, List<DepartamentoEntity>>> getDepartamentosRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await departamentoRemoteDataSource.getDepartamentos(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
