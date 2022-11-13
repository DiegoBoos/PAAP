import '../../domain/entities/perfil_preInversion_precio_entity.dart';

class PerfilPreinversionPrecioModel extends PerfilPreinversionPrecioEntity {
  PerfilPreinversionPrecioModel({
    required String perfilPreInversionId,
    required String productoId,
    required String tipoCalidadId,
    required String precio,
    required String unidadId,
    required String producto,
    required String tipoCalidad,
  }) : super(
            perfilPreInversionId: perfilPreInversionId,
            productoId: productoId,
            tipoCalidadId: tipoCalidadId,
            precio: precio,
            unidadId: unidadId,
            producto: producto,
            tipoCalidad: tipoCalidad);

  factory PerfilPreinversionPrecioModel.fromJson(Map<String, dynamic> json) =>
      PerfilPreinversionPrecioModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        productoId: json["ProductoId"],
        tipoCalidadId: json["TipoCalidadId"],
        precio: json["Precio"],
        unidadId: json["UnidadId"],
        producto: json["Producto"],
        tipoCalidad: json["TipoCalidad"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ProductoId": productoId,
        "TipoCalidadId": tipoCalidadId,
        "Precio": precio,
        "UnidadId": unidadId,
        "Producto": producto,
        "TipoCalidad": tipoCalidad,
      };
}
