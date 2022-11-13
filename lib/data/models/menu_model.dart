import 'package:paap/domain/entities/menu_entity.dart';

class MenuModel extends MenuEntity {
  MenuModel(
      {required String menuId,
      String? nombre,
      String? ruta,
      String? icono,
      String? orden,
      String? menuPadre,
      required String tipoMenuId})
      : super(
            menuId: menuId,
            nombre: nombre ?? '',
            ruta: ruta ?? '',
            icono: icono ?? '',
            orden: orden ?? '',
            menuPadre: menuPadre ?? '',
            tipoMenuId: tipoMenuId);

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
      menuId: json["MenuId"],
      nombre: json["Nombre"],
      ruta: json["Ruta"],
      icono: json["Icono"],
      orden: json["Orden"],
      menuPadre: json["MenuPadre"],
      tipoMenuId: json["TipoMenuId"]);

  @override
  Map<String, dynamic> toJson() => {
        "MenuId": menuId,
        "Nombre": nombre,
        "Ruta": ruta,
        "Icono": icono,
        "Orden": orden,
        "MenuPadre": menuPadre,
        "TipoMenuId": tipoMenuId
      };
}
