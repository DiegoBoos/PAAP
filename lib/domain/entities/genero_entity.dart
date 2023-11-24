class GeneroEntity {
  GeneroEntity({this.generoId, this.nombre});

  String? generoId;
  String? nombre;

  Map<String, dynamic> toJson() => {"GeneroId": generoId, "Nombre": nombre};
}
