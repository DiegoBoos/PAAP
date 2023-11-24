class TipoTenenciaEntity {
  TipoTenenciaEntity({
    this.tipoTenenciaId,
    this.nombre,
    this.descripcion,
  });

  String? tipoTenenciaId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "TipoTenenciaId": tipoTenenciaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
