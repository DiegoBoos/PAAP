import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/alianza_beneficiario/alianza_beneficiario_repository.dart';
import '../../datasources/remote/alianza_beneficiario_remote_ds.dart';

class AlianzaBeneficiarioRepositoryImpl
    implements AlianzaBeneficiarioRepository {
  final AlianzaBeneficiarioRemoteDataSource alianzaBeneficiarioRemoteDataSource;

  AlianzaBeneficiarioRepositoryImpl(
      {required this.alianzaBeneficiarioRemoteDataSource});

  @override
  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosRepository(UsuarioEntity usuario) async {
    try {
      final alianzasBeneficiarios = await alianzaBeneficiarioRemoteDataSource
          .getAlianzasBeneficiarios(usuario);

      return Right(alianzasBeneficiarios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      saveAlianzasBeneficiariosRepository(UsuarioEntity usuario,
          List<AlianzaBeneficiarioEntity> alianzasBeneficiariosEntity) async {
    try {
      final result = await alianzaBeneficiarioRemoteDataSource
          .saveAlianzasBeneficiarios(usuario, alianzasBeneficiariosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
