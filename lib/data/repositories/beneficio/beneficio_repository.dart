import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/beneficio_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/beneficio/beneficio_repository.dart';
import '../../datasources/remote/beneficio_remote_ds.dart';

class BeneficioRepositoryImpl implements BeneficioRepository {
  final BeneficioRemoteDataSource beneficioRemoteDataSource;

  BeneficioRepositoryImpl({required this.beneficioRemoteDataSource});

  @override
  Future<Either<Failure, List<BeneficioEntity>>> getBeneficiosRepository(
      UsuarioEntity usuario) async {
    try {
      final beneficios = await beneficioRemoteDataSource.getBeneficios(usuario);

      return Right(beneficios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
