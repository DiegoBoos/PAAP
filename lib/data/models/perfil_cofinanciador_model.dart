import '../../domain/entities/perfil_cofinanciador_entity.dart';

class PerfilCofinanciadorModel extends PerfilCofinanciadorEntity {
  PerfilCofinanciadorModel({
    String? perfilId,
    String? cofinanciadorId,
    String? nombre,
    String? telefonoMovil,
    String? correo,
    String? municipio,
    String? monto,
    String? participacion,
    String? recordStatus,
  }) : super(
          perfilId: perfilId,
          cofinanciadorId: cofinanciadorId,
          nombre: nombre,
          telefonoMovil: telefonoMovil,
          correo: correo,
          municipio: municipio,
          monto: monto,
          participacion: participacion,
          recordStatus: recordStatus,
        );

  factory PerfilCofinanciadorModel.fromJson(Map<String, dynamic> json) =>
      PerfilCofinanciadorModel(
        perfilId: json["PerfilId"],
        cofinanciadorId: json["CofinanciadorId"],
        nombre: json["Nombre"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        municipio: json["Municipio"],
        monto: json["Monto"].toString(),
        participacion: json["Participacion"].toString(),
        recordStatus: json["RecordStatus"],
      );
}
