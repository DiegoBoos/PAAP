import 'package:paap/domain/entities/perfil_entity.dart';

class PerfilModel extends PerfilEntity {
  PerfilModel(
      {String? perfilId,
      String? convocatoriaId,
      String? nombre,
      String? abreviatura,
      String? municipioId,
      String? direccion,
      String? contacto,
      String? telefonoFijo,
      String? telefonoMovil,
      String? correo,
      String? tipoProyectoId,
      String? productoId,
      String? productoAsociadoId,
      String? valorTotalProyecto,
      String? incentivoModular})
      : super(
            perfilId: perfilId,
            convocatoriaId: convocatoriaId,
            nombre: nombre,
            abreviatura: abreviatura,
            municipioId: municipioId,
            direccion: direccion,
            contacto: contacto,
            telefonoFijo: telefonoFijo,
            telefonoMovil: telefonoMovil,
            correo: correo,
            tipoProyectoId: tipoProyectoId,
            productoId: productoId,
            productoAsociadoId: productoAsociadoId,
            valorTotalProyecto: valorTotalProyecto,
            incentivoModular: incentivoModular);

  factory PerfilModel.fromJson(Map<String, dynamic> json) => PerfilModel(
      perfilId: json["ID"],
      convocatoriaId: json["ConvocatoriaId"],
      nombre: json["Nombre"],
      abreviatura: json["Abreviatura"],
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
      incentivoModular: json["IncentivoModular"]);
}
