class TipoCalidadEntity {
  TipoCalidadEntity({
    this.tipoCalidadId,
    this.nombre,
    this.descripcion,
  });

  String? tipoCalidadId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "TipoCalidadId": tipoCalidadId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
