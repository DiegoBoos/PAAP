import 'package:paap/domain/entities/producto_objetivo_entity.dart';

class ProductoObjetivoModel extends ProductoObjetivoEntity {
  ProductoObjetivoModel(
      {required String productoObjetivoId,
      required String nombre,
      required String unidadId,
      required String objetivoId,
      required String objetivo,
      required String proyecto,
      required String unidad})
      : super(
            productoObjetivoId: productoObjetivoId,
            nombre: nombre,
            unidadId: unidadId,
            objetivoId: objetivoId,
            objetivo: objetivo,
            proyecto: proyecto,
            unidad: unidad);

  factory ProductoObjetivoModel.fromJson(Map<String, dynamic> json) =>
      ProductoObjetivoModel(
          productoObjetivoId: json["ProductoObjetivoId"],
          nombre: json["Nombre"],
          unidadId: json["UnidadId"],
          objetivoId: json["ObjetivoId"],
          objetivo: json["Objetivo"],
          proyecto: json["Proyecto"],
          unidad: json["Unidad"]);

  @override
  Map<String, dynamic> toJson() => {
        "ProductoObjetivoId": productoObjetivoId,
        "Nombre": nombre,
        "UnidadId": unidadId,
        "ObjetivoId": objetivoId,
        "Objetivo": objetivo,
        "Proyecto": proyecto,
        "Unidad": unidad
      };
}
