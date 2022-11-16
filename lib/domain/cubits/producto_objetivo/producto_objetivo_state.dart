part of 'producto_objetivo_cubit.dart';

abstract class ProductoObjetivoState extends Equatable {
  final List<ProductoObjetivoEntity>? productoObjetivos;
  const ProductoObjetivoState({this.productoObjetivos});

  @override
  List<Object?> get props => [productoObjetivos];
}

class ProductosObjetivosInitial extends ProductoObjetivoState {}

class ProductosObjetivosLoading extends ProductoObjetivoState {}

class ProductosObjetivosLoaded extends ProductoObjetivoState {
  final List<ProductoObjetivoEntity>? productoObjetivosLoaded;

  const ProductosObjetivosLoaded(this.productoObjetivosLoaded)
      : super(productoObjetivos: productoObjetivosLoaded);
}

class ProductosObjetivosError extends ProductoObjetivoState {
  final String message;

  const ProductosObjetivosError(this.message);

  @override
  List<Object?> get props => [message];
}
