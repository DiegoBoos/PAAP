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

  Map<String, dynamic> toJson() => {
        "ID": perfilId,
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
