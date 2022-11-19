class PerfilPreInversionAliadoEntity {
  PerfilPreInversionAliadoEntity({
    required this.perfilPreInversionId,
    required this.aliadoId,
    required this.productoId,
    required this.volumenCompra,
    required this.unidadId,
    required this.frecuenciaId,
    required this.porcentajeCompra,
    required this.sitioEntregaId,
    required this.recordStatus,
  });

  String perfilPreInversionId;
  String aliadoId;
  String productoId;
  String volumenCompra;
  String unidadId;
  String frecuenciaId;
  String porcentajeCompra;
  String sitioEntregaId;
  String recordStatus;

  factory PerfilPreInversionAliadoEntity.fromJson(Map<String, dynamic> json) =>
      PerfilPreInversionAliadoEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        aliadoId: json["AliadoId"],
        productoId: json["ProductoId"],
        volumenCompra: json["VolumenCompra"],
        unidadId: json["UnidadId"],
        frecuenciaId: json["FrecuenciaId"],
        porcentajeCompra: json["PorcentajeCompra"],
        sitioEntregaId: json["SitioEntregaId"],
        recordStatus: json["RecordStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
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
