import '../../domain/entities/perfil_entity.dart';

class PerfilModel extends PerfilEntity {
  PerfilModel(
      {required String perfilId,
      required String convocatoriaId,
      required String nombre,
      required String abreviatura,
      required String municipioId,
      required String direccion,
      required String contacto,
      String? telefonoFijo,
      String? telefonoMovil,
      String? correo,
      required String tipoProyectoId,
      required String productoId,
      required String productoAsociadoId,
      required String valorTotalProyecto,
      required String incentivoModular})
      : super(
            perfilId: perfilId,
            convocatoriaId: convocatoriaId,
            nombre: nombre,
            abreviatura: abreviatura,
            municipioId: municipioId,
            direccion: direccion,
            contacto: contacto,
            telefonoFijo: telefonoFijo ?? '',
            telefonoMovil: telefonoMovil ?? '',
            correo: correo ?? '',
            tipoProyectoId: tipoProyectoId,
            productoId: productoId,
            productoAsociadoId: productoAsociadoId,
            valorTotalProyecto: valorTotalProyecto,
            incentivoModular: incentivoModular);

  factory PerfilModel.fromJson(Map<String, dynamic> json) => PerfilModel(
      perfilId: json["PerfilId"],
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

  @override
  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "ConvocatoriaId": convocatoriaId,
        "Nombre": nombre,
        "Abreviatura": abreviatura,
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
        "IncentivoModular": incentivoModular
      };
}
