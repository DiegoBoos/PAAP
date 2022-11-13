import '../../domain/entities/visita_entity.dart';

class VisitaModel extends VisitaEntity {
  VisitaModel({
    required String perfilId,
    required String tipoVisitaId,
    String? fechaInicial,
    String? fechaFinal,
    required String estadoVisitaId,
    String? observacion,
    required String usuarioId,
    String? fechaRegistro,
  }) : super(
            perfilId: perfilId,
            tipoVisitaId: tipoVisitaId,
            fechaInicial: fechaInicial ?? '',
            fechaFinal: fechaFinal ?? '',
            estadoVisitaId: estadoVisitaId,
            observacion: observacion ?? '',
            usuarioId: usuarioId,
            fechaRegistro: fechaRegistro ?? '');

  factory VisitaModel.fromJson(Map<String, dynamic> json) => VisitaModel(
        perfilId: json["PerfilId"],
        tipoVisitaId: json["TipoVisitaId"],
        fechaInicial: json["FechaInicial"],
        fechaFinal: json["FechaFinal"],
        estadoVisitaId: json["EstadoVisitaId"],
        observacion: json["Observacion"],
        usuarioId: json["UsuarioId"],
        fechaRegistro: json["FechaRegistro"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "TipoVisitaId": tipoVisitaId,
        "FechaInicial": fechaInicial,
        "FechaFinal": fechaFinal,
        "EstadoVisitaId": estadoVisitaId,
        "Observacion": observacion,
        "UsuarioId": usuarioId,
        "FechaRegistro": fechaRegistro,
      };
}
