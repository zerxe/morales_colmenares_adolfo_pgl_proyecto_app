// character.dart
class Character {
  String? userEmail;
  String charaName;
  String charaClass;
  int level;
  int str;
  int dex;
  int cons;
  int inte;
  int wis;
  int cha;

  Character({
    required this.userEmail,
    required this.charaName,
    required this.charaClass,
    required this.level,
    required this.str,
    required this.dex,
    required this.cons,
    required this.inte,
    required this.wis,
    required this.cha,
  });

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'charaName': charaName,
      'charaClass': charaClass,
      'level': level,
      'str': str,
      'dex': dex,
      'cons': cons,
      'inte': inte,
      'wis': wis,
      'cha': cha,
    };
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      userEmail: json['userEmail'],
      charaName: json['charaName'] ?? "NoName",
      charaClass: json['charaClass'] ?? "Aldeano",
      level: json['level'] ?? 1,
      str: json['str'] ?? 10,
      dex: json['dex'] ?? 10,
      cons: json['cons'] ?? 10,
      inte: json['inte'] ?? 10,
      wis: json['wis'] ?? 10,
      cha: json['cha'] ?? 10,
    );
  }

  void copyFrom(Character other) {
    userEmail = other.userEmail;
    charaName = other.charaName;
    charaClass = other.charaClass;
    level = other.level;
    str = other.str;
    dex = other.dex;
    cons = other.cons;
    inte = other.inte;
    wis = other.wis;
    cha = other.cha;
  }
}
