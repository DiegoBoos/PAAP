import '../../domain/entities/alianza_experiencia_pecuaria_entity.dart';

class AlianzaExperienciaPecuariaModel extends AlianzaExperienciaPecuariaEntity {
  AlianzaExperienciaPecuariaModel({
    String? tipoActividadProductivaId,
    String? beneficiarioId,
    String? frecuenciaId,
    String? cantidadAnimales,
    String? cantidadCria,
    String? cantidadLevante,
    String? cantidadCeba,
    String? cantidadLeche,
    String? valorJornal,
    String? costosInsumos,
    String? ingresos,
    String? recordStatus,
  }) : super(
          tipoActividadProductivaId: tipoActividadProductivaId,
          beneficiarioId: beneficiarioId,
          frecuenciaId: frecuenciaId,
          cantidadAnimales: cantidadAnimales,
          cantidadCria: cantidadCria,
          cantidadLevante: cantidadLevante,
          cantidadCeba: cantidadCeba,
          cantidadLeche: cantidadLeche,
          valorJornal: valorJornal,
          costosInsumos: costosInsumos,
          ingresos: ingresos,
          recordStatus: recordStatus,
        );

  factory AlianzaExperienciaPecuariaModel.fromJson(Map<String, dynamic> json) =>
      AlianzaExperienciaPecuariaModel(
        tipoActividadProductivaId: json["TipoActividadProductivaId"],
        beneficiarioId: json["BeneficiarioId"],
        frecuenciaId: json["FrecuenciaId"],
        cantidadAnimales: json["CantidadAnimales"],
        cantidadCria: json["CantidadCria"],
        cantidadLevante: json["CantidadLevante"],
        cantidadCeba: json["CantidadCeba"],
        cantidadLeche: json["CantidadLeche"],
        valorJornal: json["ValorJornal"],
        costosInsumos: json["CostosInsumos"],
        ingresos: json["Ingresos"],
        recordStatus: json["RecordStatus"],
      );
}
