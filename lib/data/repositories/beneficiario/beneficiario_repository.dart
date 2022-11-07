import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/beneficiario_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/beneficiario/beneficiario_repository.dart';
import '../../datasources/remote/beneficiario/beneficiario_remote_ds.dart';

class BeneficiarioRepositoryImpl implements BeneficiarioRepository {
  final BeneficiarioRemoteDataSource beneficiarioRemoteDataSource;

  BeneficiarioRepositoryImpl({required this.beneficiarioRemoteDataSource});

  @override
  Future<Either<Failure, List<BeneficiarioEntity>>> getBeneficiariosRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await beneficiarioRemoteDataSource.getBeneficiarios(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
