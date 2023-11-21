class TipoCalidadEntity {
  TipoCalidadEntity({
    required this.tipoCalidadId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoCalidadId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TipoCalidadId": tipoCalidadId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
