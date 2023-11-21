class TipoEntidadEntity {
  TipoEntidadEntity({required this.tipoEntidadId, required this.nombre});

  String tipoEntidadId;
  String nombre;

  Map<String, dynamic> toJson() =>
      {"TipoEntidadId": tipoEntidadId, "Nombre": nombre};
}
