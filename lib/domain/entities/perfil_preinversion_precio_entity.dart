class PerfilPreInversionPrecioEntity {
  PerfilPreInversionPrecioEntity({
    required this.perfilPreInversionId,
    required this.productoId,
    required this.tipoCalidadId,
    required this.precio,
    required this.unidadId,
    required this.recordStatus,
  });

  String perfilPreInversionId;
  String productoId;
  String tipoCalidadId;
  String precio;
  String unidadId;
  String recordStatus;

  factory PerfilPreInversionPrecioEntity.fromJson(Map<String, dynamic> json) =>
      PerfilPreInversionPrecioEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        productoId: json["ProductoId"],
        tipoCalidadId: json["TipoCalidadId"],
        precio: json["Precio"],
        unidadId: json["UnidadId"],
        recordStatus: json["RecordStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ProductoId": productoId,
        "TipoCalidadId": tipoCalidadId,
        "Precio": precio,
        "UnidadId": unidadId,
        "RecordStatus": recordStatus,
      };
}
