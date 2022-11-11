import 'package:paap/domain/usecases/aliado_preinversion/aliado_preinversion_exports.dart';

class AliadoPreinversionModel extends AliadoPreinversionEntity {
  AliadoPreinversionModel({
    required String perfilPreInversionId,
    required String aliadoId,
    required String productoId,
    required String volumenCompra,
    required String unidadId,
    required String frecuenciaId,
    required String porcentajeCompra,
    required String sitioEntregaId,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          aliadoId: aliadoId,
          productoId: productoId,
          volumenCompra: volumenCompra,
          unidadId: unidadId,
          frecuenciaId: frecuenciaId,
          porcentajeCompra: porcentajeCompra,
          sitioEntregaId: sitioEntregaId,
        );

  factory AliadoPreinversionModel.fromJson(Map<String, dynamic> json) =>
      AliadoPreinversionModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        aliadoId: json["AliadoId"],
        productoId: json["ProductoId"],
        volumenCompra: json["VolumenCompra"],
        unidadId: json["UnidadId"],
        frecuenciaId: json["FrecuenciaId"],
        porcentajeCompra: json["PorcentajeCompra"],
        sitioEntregaId: json["SitioEntregaId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "AliadoId": aliadoId,
        "ProductoId": productoId,
        "VolumenCompra": volumenCompra,
        "UnidadId": unidadId,
        "FrecuenciaId": frecuenciaId,
        "PorcentajeCompra": porcentajeCompra,
        "SitioEntregaId": sitioEntregaId,
      };
}
