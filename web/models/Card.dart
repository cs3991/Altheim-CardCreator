import 'CardType.dart';

class Card {
  String name;
  CardType type;
  List<String> subtypes;
  List<String> devotions;
  Map<String, dynamic> constraints;
  Map<String, dynamic> keywords;
  String effect;
  int power;
  int resistance;

  Card(this.name, this.type, this.subtypes, this.devotions, this.constraints, this.keywords, this.effect, this.power,
      this.resistance);

  Card.fromJson(Map<String, dynamic> json) {
    name = json.keys.first;
    var cardProperties = json[name];

    type = CardTypeExtension.fromString(cardProperties['type']);
    subtypes = cardProperties['sous_types'];
    devotions = cardProperties['devotions'];
    constraints = cardProperties['contraintes'];
    keywords = cardProperties['mots_cles'];
    effect = cardProperties['texte_effet'];
    power = cardProperties['puissance'];
    resistance = cardProperties['resistance'];
  }

  static CardType cardTypeOf(String s) {
    switch (s) {
      case ("creature"):
        return CardType.creature;
      case ("construction"):
        return CardType.construction;
      case ("miracle"):
        return CardType.miracle;
      case ("devotion"):
        return CardType.devotion;
      case ("lieu"):
        return CardType.place;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() => {
        name: {
          'type': type.toText(),
          'sous_types': subtypes,
          'devotions': devotions,
          'contraintes': constraints,
          'mots_cles': keywords,
          'texte_effet': effect,
          'puissance': power,
          'resistance': resistance,
        },
      };

  @override
  String toString() {
    return 'Card : $name :\n'
        'type: $type,\n'
        'subtypes: $subtypes,\n'
        'devotions: $devotions, \n'
        'constraints: $constraints, \n'
        'keywords: $keywords, \n'
        'effect: $effect, \n'
        'power: $power, \n'
        'resistance: $resistance\n';
  }
}
