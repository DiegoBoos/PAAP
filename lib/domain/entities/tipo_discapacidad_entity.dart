class TipoDiscapacidadEntity {
  TipoDiscapacidadEntity({
    this.tipoDiscapacidadId,
    this.nombre,
    this.descripcion,
  });

  String? tipoDiscapacidadId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "TipoDiscapacidadId": tipoDiscapacidadId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
