import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_beneficiario/perfil_beneficiario_repository.dart';
import '../../datasources/remote/perfil_beneficiario/perfil_beneficiario_remote_ds.dart';

class PerfilBeneficiarioRepositoryImpl implements PerfilBeneficiarioRepository {
  final PerfilBeneficiarioRemoteDataSource perfilBeneficiarioRemoteDataSource;

  PerfilBeneficiarioRepositoryImpl(
      {required this.perfilBeneficiarioRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosRepository(UsuarioEntity usuario) async {
    try {
      final tipoproyectos = await perfilBeneficiarioRemoteDataSource
          .getPerfilBeneficiarios(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      savePerfilesBeneficiariosRepository(UsuarioEntity usuario,
          List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity) async {
    try {
      final result = await perfilBeneficiarioRemoteDataSource
          .savePerfilesBeneficiarios(usuario, perfilesBeneficiariosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
