class PerfilPreinversionPrecioEntity {
  PerfilPreinversionPrecioEntity({
    required this.perfilPreInversionId,
    required this.productoId,
    required this.tipoCalidadId,
    required this.precio,
    required this.unidadId,
    required this.producto,
    required this.tipoCalidad,
  });

  String perfilPreInversionId;
  String productoId;
  String tipoCalidadId;
  String precio;
  String unidadId;
  String producto;
  String tipoCalidad;

  factory PerfilPreinversionPrecioEntity.fromJson(Map<String, dynamic> json) =>
      PerfilPreinversionPrecioEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        productoId: json["ProductoId"],
        tipoCalidadId: json["TipoCalidadId"],
        precio: json["Precio"],
        unidadId: json["UnidadId"],
        producto: json["Producto"],
        tipoCalidad: json["TipoCalidad"],
      );

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
