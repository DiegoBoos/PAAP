import 'package:paap/domain/entities/indicador_entity.dart';

class IndicadorModel extends IndicadorEntity {
  IndicadorModel(
      {required String indicadorId,
      required String nombre,
      required String meta,
      required String productoObjetivoId,
      required String producto})
      : super(
            indicadorId: indicadorId,
            nombre: nombre,
            meta: meta,
            productoObjetivoId: productoObjetivoId,
            producto: producto);

  factory IndicadorModel.fromJson(Map<String, dynamic> json) => IndicadorModel(
      indicadorId: json["IndicadorId"],
      nombre: json["Nombre"],
      meta: json["Meta"],
      productoObjetivoId: json["ProductoObjetivoId"],
      producto: json["Producto"]);
  @override
  Map<String, dynamic> toJson() => {
        "IndicadorId": indicadorId,
        "Nombre": nombre,
        "Meta": meta,
        "ProductoObjetivoId": productoObjetivoId,
        "Producto": producto,
      };
}
