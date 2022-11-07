import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/vereda_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/vereda/vereda_repository.dart';
import '../../datasources/remote/vereda/vereda_remote_ds.dart';

class VeredaRepositoryImpl implements VeredaRepository {
  final VeredaRemoteDataSource veredaRemoteDataSource;

  VeredaRepositoryImpl({required this.veredaRemoteDataSource});

  @override
  Future<Either<Failure, List<VeredaEntity>>> getVeredasRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos = await veredaRemoteDataSource.getVeredas(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
