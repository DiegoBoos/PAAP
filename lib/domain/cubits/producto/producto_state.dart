part of 'producto_cubit.dart';

abstract class ProductoState extends Equatable {
  final List<ProductoEntity>? productos;
  const ProductoState({this.productos});

  @override
  List<Object?> get props => [productos];
}

class ProductosInitial extends ProductoState {}

class ProductosLoading extends ProductoState {}

class ProductosLoaded extends ProductoState {
  final List<ProductoEntity>? productosLoaded;

  const ProductosLoaded(this.productosLoaded)
      : super(productos: productosLoaded);
}

class ProductosError extends ProductoState {
  final String message;

  const ProductosError(this.message);

  @override
  List<Object?> get props => [message];
}
