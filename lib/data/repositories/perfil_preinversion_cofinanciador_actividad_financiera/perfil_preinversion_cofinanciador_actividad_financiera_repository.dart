import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_repository.dart';
import '../../datasources/remote/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_remote_ds.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraRepositoryImpl
    implements PerfilPreInversionCofinanciadorActividadFinancieraRepository {
  final PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource
      perfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource;

  PerfilPreInversionCofinanciadorActividadFinancieraRepositoryImpl(
      {required this.perfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource});

  @override
  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasRepository(
          UsuarioEntity usuario) async {
    try {
      final perfilPreInversionCofinanciadorActividadesFinancieras =
          await perfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource
              .getPerfilPreInversionCofinanciadorActividadesFinancieras(
                  usuario);

      return Right(perfilPreInversionCofinanciadorActividadesFinancieras);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      savePerfilesPreInversionesCofinanciadoresActividadesFinancierasRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity) async {
    try {
      final result =
          await perfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource
              .savePerfilesPreInversionesCofinanciadoresActividadesFinancieras(
                  usuario,
                  perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
