import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/beneficiario_preinversion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/beneficiario_preinversion/beneficiario_preinversion_repository.dart';
import '../../datasources/remote/beneficiario_preinversion/beneficiario_preinversion_remote_ds.dart';

class BeneficiarioPreinversionRepositoryImpl
    implements BeneficiarioPreinversionRepository {
  final BeneficiarioPreinversionRemoteDataSource
      beneficiarioPreinversionRemoteDataSource;

  BeneficiarioPreinversionRepositoryImpl(
      {required this.beneficiarioPreinversionRemoteDataSource});

  @override
  Future<Either<Failure, List<BeneficiarioPreinversionEntity>>>
      getBeneficiariosPreinversionRepository(UsuarioEntity usuario) async {
    try {
      final beneficiariosPreinversion =
          await beneficiarioPreinversionRemoteDataSource
              .getBeneficiariosPreinversion(usuario);

      return Right(beneficiariosPreinversion);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
