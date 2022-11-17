import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_repository.dart';
import '../../datasources/remote/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_remote_ds.dart';

class PerfilPreInversionBeneficiarioRepositoryImpl
    implements PerfilPreInversionBeneficiarioRepository {
  final PerfilPreInversionBeneficiarioRemoteDataSource
      perfilPreInversionBeneficiarioRemoteDataSource;

  PerfilPreInversionBeneficiarioRepositoryImpl(
      {required this.perfilPreInversionBeneficiarioRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilPreInversionBeneficiariosRepository(
          UsuarioEntity usuario) async {
    try {
      final perfilPreInversionBeneficiarios =
          await perfilPreInversionBeneficiarioRemoteDataSource
              .getPerfilPreInversionBeneficiarios(usuario);

      return Right(perfilPreInversionBeneficiarios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      savePerfilesPreInversionesBeneficiariosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionBeneficiarioEntity>
              perfilesPreInversionesBeneficiariosEntity) async {
    try {
      final result = await perfilPreInversionBeneficiarioRemoteDataSource
          .savePerfilesPreInversionesBeneficiarios(
              usuario, perfilesPreInversionesBeneficiariosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
