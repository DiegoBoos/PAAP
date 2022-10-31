class GeneroEntity {
  GeneroEntity({required this.generoId, required this.nombre});

  String generoId;
  String nombre;

  factory GeneroEntity.fromJson(Map<String, dynamic> json) =>
      GeneroEntity(generoId: json["GeneroId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() => {"GeneroId": generoId, "Nombre": nombre};
}
