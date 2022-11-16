import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/producto_objetivo_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/producto_objetivo/producto_objetivo_repository.dart';
import '../../datasources/remote/producto_objetivo/producto_objetivo_remote_ds.dart';

class ProductoObjetivoRepositoryImpl implements ProductoObjetivoRepository {
  final ProductoObjetivoRemoteDataSource productoObjetivoRemoteDataSource;

  ProductoObjetivoRepositoryImpl(
      {required this.productoObjetivoRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductoObjetivoEntity>>>
      getProductosObjetivosRepository(UsuarioEntity usuario) async {
    try {
      final productosObjetivos =
          await productoObjetivoRemoteDataSource.getProductosObjetivos(usuario);

      return Right(productosObjetivos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
