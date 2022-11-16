import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/proyecto_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/proyecto/proyecto_repository.dart';
import '../../datasources/remote/proyecto/proyecto_remote_ds.dart';

class ProyectoRepositoryImpl implements ProyectoRepository {
  final ProyectoRemoteDataSource proyectoRemoteDataSource;

  ProyectoRepositoryImpl({required this.proyectoRemoteDataSource});

  @override
  Future<Either<Failure, List<ProyectoEntity>>> getProyectosRepository(
      UsuarioEntity usuario) async {
    try {
      final proyectos = await proyectoRemoteDataSource.getProyectos(usuario);

      return Right(proyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
