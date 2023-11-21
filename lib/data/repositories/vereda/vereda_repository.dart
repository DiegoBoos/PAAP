import 'package:dartz/dartz.dart';
import 'package:paap/data/models/vereda_model.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/vereda/vereda_repository.dart';
import '../../datasources/remote/vereda_remote_ds.dart';

class VeredaRepositoryImpl implements VeredaRepository {
  final VeredaRemoteDataSource veredaRemoteDataSource;

  VeredaRepositoryImpl({required this.veredaRemoteDataSource});

  @override
  Future<Either<Failure, List<VeredaModel>>> getVeredasRepository(
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

  @override
  Future<Either<Failure, List<VeredaModel>>> downloadVeredas(
      UsuarioEntity usuario, List<String> municipiosIds) async {
    try {
      final tipoproyectos =
          await veredaRemoteDataSource.downloadVeredas(usuario, municipiosIds);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
