import 'package:paap/domain/entities/perfil_aliado_entity.dart';

class PerfilAliadoModel extends PerfilAliadoEntity {
  PerfilAliadoModel({
    String? perfilId,
    String? aliadoId,
    String? productoId,
    String? volumenCompra,
    String? unidadId,
    String? frecuenciaId,
    String? porcentajeCompra,
    String? sitioEntregaId,
    String? aliado,
    String? recordStatus,
  }) : super(
          perfilId: perfilId,
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

  factory PerfilAliadoModel.fromJson(Map<String, dynamic> json) =>
      PerfilAliadoModel(
        perfilId: json["PerfilId"],
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
