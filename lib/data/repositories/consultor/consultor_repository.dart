import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/consultor_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/consultor/consultor_repository.dart';
import '../../datasources/remote/consultor_remote_ds.dart';

class ConsultorRepositoryImpl implements ConsultorRepository {
  final ConsultorRemoteDataSource consultorRemoteDataSource;

  ConsultorRepositoryImpl({required this.consultorRemoteDataSource});

  @override
  Future<Either<Failure, List<ConsultorEntity>>> getConsultoresRepository(
      UsuarioEntity usuario) async {
    try {
      final consultors =
          await consultorRemoteDataSource.getConsultores(usuario);

      return Right(consultors);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
