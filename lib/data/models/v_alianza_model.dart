import 'package:paap/domain/entities/v_alianza_entity.dart';

class VAlianzaModel extends VAlianzaEntity {
  VAlianzaModel(
      {String? alianzaId,
      String? perfilPreInversionId,
      String? convocatoria,
      String? nombre,
      String? abreviatura,
      String? nit,
      String? municipio,
      String? direccion,
      String? contacto,
      String? telefonoFijo,
      String? telefonoMovil,
      String? correo,
      String? tipoProyecto,
      String? productoPrincipal,
      String? productoAsociado,
      String? valorTotalProyecto,
      String? incentivoModular,
      String? legalizado})
      : super(
            alianzaId: alianzaId,
            perfilPreInversionId: perfilPreInversionId,
            convocatoria: convocatoria,
            nombre: nombre,
            abreviatura: abreviatura,
            nit: nit,
            municipio: municipio,
            direccion: direccion,
            contacto: contacto,
            telefonoFijo: telefonoFijo,
            telefonoMovil: telefonoMovil,
            correo: correo,
            tipoProyecto: tipoProyecto,
            productoPrincipal: productoPrincipal,
            productoAsociado: productoAsociado,
            valorTotalProyecto: valorTotalProyecto,
            incentivoModular: incentivoModular,
            legalizado: legalizado);

  factory VAlianzaModel.fromJson(Map<String, dynamic> json) => VAlianzaModel(
      alianzaId: json["alianzaId"],
      perfilPreInversionId: json["perfilPreInversionId"],
      convocatoria: json["convocatoria"],
      nombre: json["nombre"],
      abreviatura: json["abreviatura"],
      nit: json["nit"],
      municipio: json["municipio"],
      direccion: json["direccion"],
      contacto: json["contacto"],
      telefonoFijo: json["telefonoFijo"]!,
      telefonoMovil: json["telefonoMovil"],
      correo: json["correo"],
      tipoProyecto: json["tipoProyecto"],
      productoPrincipal: json["productoPrincipal"],
      productoAsociado: json["productoAsociado"],
      valorTotalProyecto: json["valorTotalProyecto"],
      incentivoModular: json["incentivoModular"],
      legalizado: json["legalizado"]);
}
