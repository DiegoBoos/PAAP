import '../../domain/entities/perfil_preinversion_precio_entity.dart';

class PerfilPreInversionPrecioModel extends PerfilPreInversionPrecioEntity {
  PerfilPreInversionPrecioModel({
    required String perfilPreInversionId,
    String? productoId,
    String? tipoCalidadId,
    String? precio,
    String? unidadId,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          productoId: productoId ?? '',
          tipoCalidadId: tipoCalidadId ?? '',
          precio: precio ?? '',
          unidadId: unidadId ?? '',
        );

  factory PerfilPreInversionPrecioModel.fromJson(Map<String, dynamic> json) =>
      PerfilPreInversionPrecioModel(
          perfilPreInversionId: json["PerfilPreInversionId"],
          productoId: json["ProductoId"],
          tipoCalidadId: json["TipoCalidadId"],
          precio: json["Precio"],
          unidadId: json["UnidadId"]);

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ProductoId": productoId,
        "TipoCalidadId": tipoCalidadId,
        "Precio": precio,
        "UnidadId": unidadId,
      };
}
