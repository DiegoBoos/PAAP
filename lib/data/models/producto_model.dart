import 'package:paap/domain/entities/producto_entity.dart';

class ProductoModel extends ProductoEntity {
  ProductoModel(
      {String? id,
      String? nombre,
      String? unidad,
      String? simbolo,
      String? esProducto,
      String? esAsociado})
      : super(
            id: id,
            nombre: nombre,
            unidad: unidad,
            simbolo: simbolo,
            esProducto: esProducto,
            esAsociado: esAsociado);

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["ProductoId"],
        nombre: json["Nombre"],
        unidad: json["Unidad"],
        simbolo: json["Simbolo"],
        esProducto: json["EsProducto"],
        esAsociado: json["EsAsociado"],
      );
}
