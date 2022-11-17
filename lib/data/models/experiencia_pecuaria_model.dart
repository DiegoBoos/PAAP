import '../../domain/entities/experiencia_pecuaria_entity.dart';

class ExperienciaPecuariaModel extends ExperienciaPecuariaEntity {
  ExperienciaPecuariaModel({
    required String? tipoActividadProductivaId,
    required String? beneficiarioId,
    required String? frecuenciaId,
    required String cantidadAnimales,
    required String cantidadCria,
    required String cantidadLevante,
    required String cantidadCeba,
    required String cantidadLeche,
    required String valorJornal,
    required String costosInsumos,
    required String ingresos,
  }) : super(
          tipoActividadProductivaId: tipoActividadProductivaId ?? '',
          beneficiarioId: beneficiarioId ?? '',
          frecuenciaId: frecuenciaId ?? '',
          cantidadAnimales: cantidadAnimales,
          cantidadCria: cantidadCria,
          cantidadLevante: cantidadLevante,
          cantidadCeba: cantidadCeba,
          cantidadLeche: cantidadLeche,
          valorJornal: valorJornal,
          costosInsumos: costosInsumos,
          ingresos: ingresos,
        );

  factory ExperienciaPecuariaModel.fromJson(Map<String, dynamic> json) =>
      ExperienciaPecuariaModel(
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
      );

  @override
  Map<String, dynamic> toJson() => {
        "TipoActividadProductivaId": tipoActividadProductivaId,
        "BeneficiarioId": beneficiarioId,
        "FrecuenciaId": frecuenciaId,
        "CantidadAnimales": cantidadAnimales,
        "CantidadCria": cantidadCria,
        "CantidadLevante": cantidadLevante,
        "CantidadCeba": cantidadCeba,
        "CantidadLeche": cantidadLeche,
        "ValorJornal": valorJornal,
        "CostosInsumos": costosInsumos,
        "Ingresos": ingresos,
      };
}
