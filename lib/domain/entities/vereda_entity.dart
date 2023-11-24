class VeredaEntity {
  VeredaEntity({this.veredaId, this.nombre, this.codigoDane, this.municipioId});

  String? veredaId;
  String? nombre;
  String? codigoDane;
  String? municipioId;

  Map<String, dynamic> toJson() => {
        "VeredaId": veredaId,
        "Nombre": nombre,
        "CodigoDane": codigoDane,
        "MunicipioId": municipioId
      };
}
