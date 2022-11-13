import 'package:paap/domain/entities/producto_entity.dart';

class ProductoModel extends ProductoEntity {
  ProductoModel(
      {required String id,
      String? nombre,
      String? unidad,
      String? simbolo,
      String? esProducto,
      String? esAsociado})
      : super(
            id: id,
            nombre: nombre ?? '',
            unidad: unidad ?? '',
            simbolo: simbolo ?? '',
            esProducto: esProducto ?? '',
            esAsociado: esAsociado ?? '');

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["ProductoId"],
        nombre: json["Nombre"],
        unidad: json["Unidad"],
        simbolo: json["Simbolo"],
        esProducto: json["EsProducto"],
        esAsociado: json["EsAsociado"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "ProductoId": id,
        "Nombre": nombre,
        "Unidad": unidad,
        "Simbolo": simbolo,
        "EsProducto": esProducto,
        "EsAsociado": esAsociado
      };
}
