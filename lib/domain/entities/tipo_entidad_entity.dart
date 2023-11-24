class TipoEntidadEntity {
  TipoEntidadEntity({this.tipoEntidadId, this.nombre});

  String? tipoEntidadId;
  String? nombre;

  Map<String, dynamic> toJson() =>
      {"TipoEntidadId": tipoEntidadId, "Nombre": nombre};
}
