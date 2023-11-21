class TipoDiscapacidadEntity {
  TipoDiscapacidadEntity({
    required this.tipoDiscapacidadId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoDiscapacidadId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TipoDiscapacidadId": tipoDiscapacidadId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
