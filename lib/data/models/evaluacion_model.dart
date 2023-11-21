import 'package:paap/domain/entities/evaluacion_entity.dart';

class EvaluacionModel extends EvaluacionEntity {
  EvaluacionModel({
    required String evaluacionId,
    required String perfilId,
    String? resumen,
    String? fortalezas,
    String? debilidades,
    String? riesgos,
    String? finalizado,
    String? usuarioIdCoordinador,
    String? fechaEvaluacion,
    String? preAprobado,
    String? recordStatus,
    String? remoteEvaluacionId,
  }) : super(
            evaluacionId: evaluacionId,
            perfilId: perfilId,
            resumen: resumen ?? '',
            fortalezas: fortalezas ?? '',
            debilidades: debilidades ?? '',
            riesgos: riesgos ?? '',
            finalizado: finalizado ?? '',
            usuarioIdCoordinador: usuarioIdCoordinador ?? '',
            fechaEvaluacion: fechaEvaluacion ?? '',
            preAprobado: preAprobado ?? '',
            recordStatus: recordStatus ?? '',
            remoteEvaluacionId: remoteEvaluacionId ?? '');

  factory EvaluacionModel.fromJson(Map<String, dynamic> json) =>
      EvaluacionModel(
        evaluacionId: json["EvaluacionId"].toString(),
        perfilId: json["PerfilId"],
        resumen: json["Resumen"],
        fortalezas: json["Fortalezas"],
        debilidades: json["Debilidades"],
        riesgos: json["Riesgos"],
        finalizado: json["Finalizado"],
        usuarioIdCoordinador: json["UsuarioIdCoordinador"],
        fechaEvaluacion: json["FechaEvaluacion"],
        preAprobado: json["PreAprobado"],
        recordStatus: json["RecordStatus"],
        remoteEvaluacionId: json["RemoteEvaluacionId"].toString(),
      );

  @override
  bool operator ==(Object other) =>
      other is EvaluacionModel && other.evaluacionId == evaluacionId;

  @override
  int get hashCode => evaluacionId.hashCode;
}
