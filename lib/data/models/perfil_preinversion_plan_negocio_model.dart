import '../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';

class PerfilPreInversionPlanNegocioModel
    extends PerfilPreInversionPlanNegocioEntity {
  PerfilPreInversionPlanNegocioModel({
    String? perfilPreInversionId,
    String? rubroId,
    String? year,
    String? valor,
    String? cantidad,
    String? unidadId,
    String? productoId,
    String? tipoCalidadId,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          rubroId: rubroId,
          year: year,
          valor: valor,
          cantidad: cantidad,
          unidadId: unidadId,
          productoId: productoId,
          tipoCalidadId: tipoCalidadId,
          recordStatus: recordStatus,
        );

  factory PerfilPreInversionPlanNegocioModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionPlanNegocioModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        rubroId: json["RubroId"],
        year: json["Year"],
        valor: json["Valor"],
        cantidad: json["Cantidad"],
        unidadId: json["UnidadId"],
        productoId: json["ProductoId"],
        tipoCalidadId: json["TipoCalidadId"],
        recordStatus: json["RecordStatus"],
      );
}
