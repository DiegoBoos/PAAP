import '../../domain/entities/producto_entity.dart';

class ProductoModel extends ProductoEntity {
  ProductoModel(
      {required String id,
      required String nombre,
      required String unidadid,
      required String esproducto,
      required String esasociado})
      : super(
            id: id,
            nombre: nombre,
            unidadid: unidadid,
            esproducto: esproducto,
            esasociado: esasociado);

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["ProductoId"],
        nombre: json["Nombre"],
        unidadid: json["UnidadId"],
        esproducto: json["EsProducto"],
        esasociado: json["EsAsociado"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "ProductoId": id,
        "Nombre": nombre,
        "UnidadId": unidadid,
        "EsProducto": esproducto,
        "EsAsociado": esasociado
      };
}
