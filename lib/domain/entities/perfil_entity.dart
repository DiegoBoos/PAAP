class PerfilEntity {
  PerfilEntity({
    required this.perfilId,
    required this.convocatoriaId,
    required this.nombre,
    required this.abreviatura,
    required this.municipioId,
    required this.direccion,
    required this.contacto,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.tipoProyectoId,
    required this.productoId,
    required this.productoAsociadoId,
    required this.valorTotalProyecto,
    required this.incentivoModular,
  });

  final String perfilId;
  final String convocatoriaId;
  final String nombre;
  final String abreviatura;
  final String municipioId;
  final String direccion;
  final String contacto;
  final String telefonoFijo;
  final String telefonoMovil;
  final String correo;
  final String tipoProyectoId;
  final String productoId;
  final String productoAsociadoId;
  final String valorTotalProyecto;
  final String incentivoModular;

  factory PerfilEntity.fromJson(Map<String, dynamic> json) => PerfilEntity(
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
        incentivoModular: json["IncentivoModular"],
      );

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
        "IncentivoModular": incentivoModular,
      };
}
