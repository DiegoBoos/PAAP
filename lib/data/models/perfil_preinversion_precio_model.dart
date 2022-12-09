import '../../domain/entities/perfil_preinversion_precio_entity.dart';

class PerfilPreInversionPrecioModel extends PerfilPreInversionPrecioEntity {
  PerfilPreInversionPrecioModel({
    required String perfilPreInversionId,
    String? productoId,
    String? unidadId,
    String? tipoCalidadId,
    String? precio,
    String? producto,
    String? unidad,
    String? tipoCalidad,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          productoId: productoId ?? '',
          unidadId: unidadId ?? '',
          tipoCalidadId: tipoCalidadId ?? '',
          precio: precio ?? '',
          producto: producto ?? '',
          unidad: unidad ?? '',
          tipoCalidad: tipoCalidad ?? '',
          recordStatus: recordStatus ?? '',
        );

  factory PerfilPreInversionPrecioModel.fromJson(Map<String, dynamic> json) =>
      PerfilPreInversionPrecioModel(
          perfilPreInversionId: json["PerfilPreInversionId"],
          productoId: json["ProductoId"],
          unidadId: json["UnidadId"],
          tipoCalidadId: json["TipoCalidadId"],
          precio: json["Precio"],
          producto: json["Producto"],
          unidad: json["Unidad"],
          tipoCalidad: json["TipoCalidad"],
          recordStatus: json["RecordStatus"]);

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ProductoId": productoId,
        "UnidadId": unidadId,
        "TipoCalidadId": tipoCalidadId,
        "Precio": precio,
        "RecordStatus": recordStatus,
      };
}
