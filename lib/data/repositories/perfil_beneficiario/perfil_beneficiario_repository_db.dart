import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../domain/repositories/perfil_beneficiario/perfil_beneficiario_repository_db.dart';
import '../../datasources/local/perfil_beneficiario/perfil_beneficiario_local_ds.dart';

class PerfilBeneficiarioRepositoryDBImpl
    implements PerfilBeneficiarioRepositoryDB {
  final PerfilBeneficiarioLocalDataSource perfilBeneficiarioLocalDataSource;

  PerfilBeneficiarioRepositoryDBImpl(
      {required this.perfilBeneficiarioLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosRepositoryDB() async {
    try {
      final perfilBeneficiariosDB =
          await perfilBeneficiarioLocalDataSource.getPerfilBeneficiariosDB();

      return Right(perfilBeneficiariosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilBeneficiarioEntity?>>
      getPerfilBeneficiarioRepositoryDB(String id) async {
    try {
      final perfilBeneficiarioDB =
          await perfilBeneficiarioLocalDataSource.getPerfilBeneficiarioDB(id);

      return Right(perfilBeneficiarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilBeneficiariosRepositoryDB(
      List<PerfilBeneficiarioEntity> perfilBeneficiarioEntity) async {
    try {
      final perfilBeneficiarioDB = await perfilBeneficiarioLocalDataSource
          .savePerfilBeneficiarios(perfilBeneficiarioEntity);
      return Right(perfilBeneficiarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
