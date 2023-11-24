class PerfilAliadoEntity {
  PerfilAliadoEntity({
    this.perfilId,
    this.aliadoId,
    this.productoId,
    this.volumenCompra,
    this.unidadId,
    this.frecuenciaId,
    this.porcentajeCompra,
    this.sitioEntregaId,
    this.aliado,
    this.recordStatus,
  });

  String? perfilId;
  String? aliadoId;
  String? productoId;
  String? volumenCompra;
  String? unidadId;
  String? frecuenciaId;
  String? porcentajeCompra;
  String? sitioEntregaId;
  String? aliado;
  String? recordStatus;

  PerfilAliadoEntity copyWith({
    String? perfilId,
    String? aliadoId,
    String? productoId,
    String? volumenCompra,
    String? unidadId,
    String? frecuenciaId,
    String? porcentajeCompra,
    String? sitioEntregaId,
    String? recordStatus,
  }) =>
      PerfilAliadoEntity(
        perfilId: perfilId ?? this.perfilId,
        aliadoId: aliadoId ?? this.aliadoId,
        productoId: productoId ?? this.productoId,
        volumenCompra: volumenCompra ?? this.volumenCompra,
        unidadId: unidadId ?? this.unidadId,
        frecuenciaId: frecuenciaId ?? this.frecuenciaId,
        porcentajeCompra: porcentajeCompra ?? this.porcentajeCompra,
        sitioEntregaId: sitioEntregaId ?? this.sitioEntregaId,
        recordStatus: recordStatus ?? this.recordStatus,
      );

  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "AliadoId": aliadoId,
        "ProductoId": productoId,
        "VolumenCompra": volumenCompra,
        "UnidadId": unidadId,
        "FrecuenciaId": frecuenciaId,
        "PorcentajeCompra": porcentajeCompra,
        "SitioEntregaId": sitioEntregaId,
        "RecordStatus": recordStatus,
      };
}
