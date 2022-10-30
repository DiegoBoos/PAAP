import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/producto_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/producto/producto_repository.dart';
import '../../datasources/remote/producto/producto_remote_ds.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final ProductoRemoteDataSource productoRemoteDataSource;

  ProductoRepositoryImpl({required this.productoRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductoEntity>>> getProductosRepository(
      UsuarioEntity usuario) async {
    try {
      final productos = await productoRemoteDataSource.getProductos(usuario);

      return Right(productos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
