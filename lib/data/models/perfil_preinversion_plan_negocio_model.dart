import '../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';

class PerfilPreInversionPlanNegocioModel
    extends PerfilPreInversionPlanNegocioEntity {
  PerfilPreInversionPlanNegocioModel({
    required String perfilPreInversionId,
    required String rubroId,
    required String year,
    required String valor,
    required String cantidad,
    required String unidadId,
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
          productoId: productoId ?? '',
          tipoCalidadId: tipoCalidadId ?? '',
          recordStatus: recordStatus ?? '',
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

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "RubroId": rubroId,
        "Year": year,
        "Valor": valor,
        "Cantidad": cantidad,
        "UnidadId": unidadId,
        "ProductoId": productoId,
        "TipoCalidadId": tipoCalidadId,
        "RecordStatus": recordStatus,
      };
}
