import 'package:paap/domain/entities/perfil_preinversion_entity.dart';

class PerfilPreInversionModel extends PerfilPreInversionEntity {
  PerfilPreInversionModel({
    required String perfilPreInversionId,
    required String perfilId,
    String? convocatoriaId,
    String? nombre,
    String? abreviatura,
    String? nit,
    required String municipioId,
    String? direccion,
    String? contacto,
    String? telefonoFijo,
    String? telefonoMovil,
    String? correo,
    required String tipoProyectoId,
    required String productoId,
    required String productoAsociadoId,
    String? valorTotalProyecto,
    String? incentivoModular,
  }) : super(
            perfilPreInversionId: perfilPreInversionId,
            perfilId: perfilId,
            convocatoriaId: convocatoriaId ?? '',
            nombre: nombre ?? '',
            abreviatura: abreviatura ?? '',
            nit: nit ?? '',
            municipioId: municipioId,
            direccion: direccion ?? '',
            contacto: contacto ?? '',
            telefonoFijo: telefonoFijo ?? '',
            telefonoMovil: telefonoMovil ?? '',
            correo: correo ?? '',
            tipoProyectoId: tipoProyectoId,
            productoId: productoId,
            productoAsociadoId: productoAsociadoId,
            valorTotalProyecto: valorTotalProyecto ?? '',
            incentivoModular: incentivoModular ?? '');

  factory PerfilPreInversionModel.fromJson(Map<String, dynamic> json) =>
      PerfilPreInversionModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        perfilId: json["PerfilId"],
        convocatoriaId: json["ConvocatoriaId"],
        nombre: json["Nombre"],
        abreviatura: json["Abreviatura"],
        nit: json["NIT"],
        municipioId: json["MunicipioId"],
        direccion: json["Direccion"],
        contacto: json["Contacto"],
        telefonoFijo: json["TelefonoFijo"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        tipoProyectoId: json["TipoProyectoId"],
        productoId: json["ProductoId"],
        productoAsociadoId: json["ProductoAsociadoId"],
        valorTotalProyecto: json["ValorTotalProyecto"],
        incentivoModular: json["IncentivoModular"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "PerfilId": perfilId,
        "ConvocatoriaId": convocatoriaId,
        "Nombre": nombre,
        "Abreviatura": abreviatura,
        "NIT": nit,
        "MunicipioId": municipioId,
        "Direccion": direccion,
        "Contacto": contacto,
        "TelefonoFijo": telefonoFijo,
        "TelefonoMovil": telefonoMovil,
        "Correo": correo,
        "TipoProyectoId": tipoProyectoId,
        "ProductoId": productoId,
        "ProductoAsociadoId": productoAsociadoId,
        "ValorTotalProyecto": valorTotalProyecto,
        "IncentivoModular": incentivoModular,
      };
}
