import 'dart:convert';

mixin JsonSerializable {
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap();
}
