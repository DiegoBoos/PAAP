class TipoIdentificacionEntity {
  TipoIdentificacionEntity({this.tipoIdentificacionId, this.nombre});

  String? tipoIdentificacionId;
  String? nombre;

  Map<String, dynamic> toJson() => {
        "TipoIdentificacionId": tipoIdentificacionId,
        "Nombre": nombre,
      };
}
