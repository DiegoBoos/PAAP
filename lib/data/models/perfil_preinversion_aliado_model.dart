import 'package:paap/domain/usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_exports.dart';

class PerfilPreInversionAliadoModel extends PerfilPreInversionAliadoEntity {
  PerfilPreInversionAliadoModel({
    required String perfilPreInversionId,
    required String aliadoId,
    String? productoId,
    String? volumenCompra,
    String? unidadId,
    String? frecuenciaId,
    String? porcentajeCompra,
    String? sitioEntregaId,
    String? aliado,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          aliadoId: aliadoId,
          productoId: productoId,
          volumenCompra: volumenCompra,
          unidadId: unidadId,
          frecuenciaId: frecuenciaId,
          porcentajeCompra: porcentajeCompra,
          sitioEntregaId: sitioEntregaId,
          aliado: aliado,
          recordStatus: recordStatus,
        );

  factory PerfilPreInversionAliadoModel.fromJson(Map<String, dynamic> json) =>
      PerfilPreInversionAliadoModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        aliadoId: json["AliadoId"],
        productoId: json["ProductoId"],
        volumenCompra: json["VolumenCompra"],
        unidadId: json["UnidadId"],
        frecuenciaId: json["FrecuenciaId"],
        porcentajeCompra: json["PorcentajeCompra"],
        sitioEntregaId: json["SitioEntregaId"],
        aliado: json["aliado"],
        recordStatus: json["RecordStatus"],
      );
}
