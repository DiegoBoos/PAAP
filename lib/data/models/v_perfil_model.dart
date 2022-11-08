import 'package:paap/domain/entities/v_perfil_entity.dart';

class VPerfilModel extends VPerfilEntity {
  VPerfilModel(
      {required String perfilId,
      required String convocatoriaId,
      required String nombre,
      required String abreviatura,
      required String municipio,
      required String departamento,
      required String direccion,
      required String contacto,
      required String telefonoFijo,
      required String telefonoMovil,
      required String correo,
      required String tipoProyecto,
      required String productoPrincipal,
      required String productoAsociado,
      required String valorTotalProyecto,
      required String incentivoModular})
      : super(
            perfilId: perfilId,
            convocatoriaId: convocatoriaId,
            nombre: nombre,
            abreviatura: abreviatura,
            municipio: municipio,
            departamento: departamento,
            direccion: direccion,
            contacto: contacto,
            telefonoFijo: telefonoFijo,
            telefonoMovil: telefonoMovil,
            correo: correo,
            tipoProyecto: tipoProyecto,
            productoPrincipal: productoPrincipal,
            productoAsociado: productoAsociado,
            valorTotalProyecto: valorTotalProyecto,
            incentivoModular: incentivoModular);

  factory VPerfilModel.fromJson(Map<String, dynamic> json) => VPerfilModel(
      perfilId: json["perfilId"],
      convocatoriaId: json["convocatoriaId"],
      nombre: json["nombre"],
      abreviatura: json["abreviatura"],
      municipio: json["municipio"],
      departamento: json["departamento"],
      direccion: json["direccion"],
      contacto: json["contacto"],
      telefonoFijo: json["telefonoFijo"]!,
      telefonoMovil: json["telefonoMovil"],
      correo: json["correo"],
      tipoProyecto: json["tipoProyecto"],
      productoPrincipal: json["productoPrincipal"],
      productoAsociado: json["productoAsociado"],
      valorTotalProyecto: json["valorTotalProyecto"],
      incentivoModular: json["incentivoModular"]);

  @override
  Map<String, dynamic> toJson() => {
        "perfilId": perfilId,
        "convocatoriaId": convocatoriaId,
        "nombre": nombre,
        "abreviatura": abreviatura,
        "municipio": municipio,
        "departamento": departamento,
        "direccion": direccion,
        "contacto": contacto,
        "telefonoFijo": telefonoFijo,
        "telefonoMovil": telefonoMovil,
        "correo": correo,
        "tipoProyecto": tipoProyecto,
        "productoPrincipal": productoPrincipal,
        "productoAsociado": productoAsociado,
        "valorTotalProyecto": valorTotalProyecto,
        "incentivoModular": incentivoModular
      };
}
