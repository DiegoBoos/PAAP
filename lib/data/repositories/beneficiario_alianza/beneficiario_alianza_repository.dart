import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/beneficiario_alianza_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/beneficiario_alianza/beneficiario_alianza_repository.dart';
import '../../datasources/remote/beneficiario_alianza/beneficiario_alianza_remote_ds.dart';

class BeneficiarioAlianzaRepositoryImpl
    implements BeneficiarioAlianzaRepository {
  final BeneficiarioAlianzaRemoteDataSource beneficiarioAlianzaRemoteDataSource;

  BeneficiarioAlianzaRepositoryImpl(
      {required this.beneficiarioAlianzaRemoteDataSource});

  @override
  Future<Either<Failure, List<BeneficiarioAlianzaEntity>>>
      getBeneficiariosAlianzaRepository(UsuarioEntity usuario) async {
    try {
      final beneficiariosAlianza = await beneficiarioAlianzaRemoteDataSource
          .getBeneficiariosAlianza(usuario);

      return Right(beneficiariosAlianza);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
