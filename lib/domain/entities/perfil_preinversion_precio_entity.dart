class PerfilPreInversionPrecioEntity {
  PerfilPreInversionPrecioEntity({
    required this.perfilPreInversionId,
    required this.productoId,
    required this.unidadId,
    required this.tipoCalidadId,
    required this.precio,
    this.producto,
    this.unidad,
    this.tipoCalidad,
    required this.recordStatus,
  });

  String perfilPreInversionId;
  String productoId;
  String unidadId;
  String tipoCalidadId;
  String precio;
  String? producto;
  String? unidad;
  String? tipoCalidad;
  String recordStatus;

  PerfilPreInversionPrecioEntity copyWith(
      {String? perfilPreInversionId,
      String? productoId,
      String? unidadId,
      String? tipoCalidadId,
      String? precio,
      String? recordStatus}) {
    return PerfilPreInversionPrecioEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      productoId: productoId ?? this.productoId,
      unidadId: unidadId ?? this.unidadId,
      tipoCalidadId: tipoCalidadId ?? this.tipoCalidadId,
      precio: precio ?? this.precio,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ProductoId": productoId,
        "UnidadId": unidadId,
        "TipoCalidadId": tipoCalidadId,
        "Precio": precio,
        "RecordStatus": recordStatus,
      };
}
