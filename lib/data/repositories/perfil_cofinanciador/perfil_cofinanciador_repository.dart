import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/perfil_cofinanciador_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_cofinanciador/perfil_cofinanciador_repository.dart';
import '../../datasources/remote/perfil_cofinanciador_remote_ds.dart';

class PerfilCofinanciadorRepositoryImpl
    implements PerfilCofinanciadorRepository {
  final PerfilCofinanciadorRemoteDataSource perfilCofinanciadorRemoteDataSource;

  PerfilCofinanciadorRepositoryImpl(
      {required this.perfilCofinanciadorRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilCofinanciadoresRepository(UsuarioEntity usuario) async {
    try {
      final tipoproyectos = await perfilCofinanciadorRemoteDataSource
          .getPerfilCofinanciadores(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      savePerfilesCofinanciadoresRepository(UsuarioEntity usuario,
          List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity) async {
    try {
      final result = await perfilCofinanciadorRemoteDataSource
          .savePerfilesCofinanciadores(usuario, perfilesCofinanciadoresEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
