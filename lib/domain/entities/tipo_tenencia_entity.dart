class TipoTenenciaEntity {
  TipoTenenciaEntity({
    required this.tipoTenenciaId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoTenenciaId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TipoTenenciaId": tipoTenenciaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
