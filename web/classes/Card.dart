import 'dart:html';

import 'CardType.dart';

class Card {
  int id;
  String extension;
  String rarity;
  String name;
  int maxNbr;
  CardType type;
  List<String> subtypes;
  List<String> devotions;
  Map<String, dynamic> constraints;
  Map<String, dynamic> keywords;
  String effect;
  int power;
  int resistance;

  Card(this.id, this.name, this.maxNbr, this.type, this.extension, this.rarity, this.subtypes, this.devotions,
      this.constraints, this.keywords, this.effect, this.power, this.resistance);

  Card.empty();

  Card.fromJson(Map<String, dynamic> json) {
    id = int.parse(json.keys.first);
    var cardProperties = json[id];
    name = cardProperties['name'];
    maxNbr = cardProperties['nbr_max'];
    type = CardTypeExtension.fromString(cardProperties['type']);
    rarity = cardProperties['rarete'];
    extension = cardProperties['extension'];
    subtypes = cardProperties['sous_types'];
    devotions = cardProperties['devotions'];
    constraints = cardProperties['contraintes'];
    keywords = cardProperties['mots_cles'];
    effect = cardProperties['texte_effet'];
    power = cardProperties['puissance'];
    resistance = cardProperties['resistance'];
  }

  /// Updates all attributes of card to match the values in the form.
  /// Does not update the json text area and the form fields.
  void updateFromForm(FormElement form) {
    id = int.parse((querySelector('#id') as InputElement).value);
    maxNbr = int.tryParse((querySelector('#nbr_max') as InputElement).value);
    name = (form.querySelector('#nom') as InputElement).value;
    rarity = (form.querySelector('#rarete') as SelectElement).value;
    extension = (form.querySelector('#extension') as SelectElement).value;
    type = CardTypeExtension.fromString((form.querySelector('#type') as SelectElement).value);
    subtypes = [];
    for (InputElement element in querySelectorAll('input.sous_types')) {
      if (element.value != '') {
        subtypes.add(element.value);
      }
    }
    devotions = [];
    for (InputElement element in querySelectorAll('input.devotions')) {
      if (element.value != '') {
        devotions.add(element.value);
      }
    }
    constraints = {};
    List<InputElement> constraintsText = form.querySelectorAll('input.contrainte_text');
    List<InputElement> constraintsNb = form.querySelectorAll('input.contrainte_nb');
    for (int i = 0; i < constraintsText.length; i++) {
      if (constraintsText[i].value != '') {
        constraints[constraintsText[i].value] = int.tryParse(constraintsNb[i].value);
      }
    }
    keywords = {};
    for (dynamic keyword in form.querySelectorAll('input.mots_cles')) {
      var checked = keyword.checked;
      var value = keyword.value;
      if (checked) {
        List<InputElement> nb = form.querySelectorAll('input#' + value + '_nb');
        if (nb.isEmpty) {
          keywords[value] = 1;
        } else if (nb[0].value == '') {
          keywords[value] = 1;
        } else {
          keywords[value] = int.parse((nb[0].value == null) ? '1' : nb[0].value);
        }
      }

      // keywords = data['mots_cles'];
      effect = (form.querySelector('#texte_effet') as TextAreaElement).value;
      power = int.tryParse((form.querySelector('#puissance') as InputElement).value);
      resistance = int.tryParse((form.querySelector('#resistance') as InputElement).value);
    }
    print(this);
  }

  /// add to json if the display property is not set to 'none'.
  void addIfDisplayed(Map json, dynamic property, String className) {
    if (querySelector('div.' + className).style.display != 'none') {
      json[id.toString()][className] = property;
    }
  }

  Map<String, dynamic> toJson() {
    var json = {id.toString(): {}};
    addIfDisplayed(json, name, 'nom');
    addIfDisplayed(json, maxNbr, 'nbr_max');
    addIfDisplayed(json, rarity, 'rarete');
    addIfDisplayed(json, extension, 'extension');
    addIfDisplayed(json, type.toText(), 'type');
    addIfDisplayed(json, subtypes, 'sous_types');
    addIfDisplayed(json, devotions, 'devotions');
    addIfDisplayed(json, constraints, 'contraintes');
    addIfDisplayed(json, keywords, 'mots_cles');
    addIfDisplayed(json, effect, 'texte_effet');
    addIfDisplayed(json, power, 'puissance');
    addIfDisplayed(json, resistance, 'resistance');
    return json;
  }

  /// since Dart doesn't support cloning object, this function is just a workaround for this
  Card copy() {
    return Card(id, name, maxNbr, type, extension, rarity, subtypes, devotions, constraints, keywords, effect, power,
        resistance);
  }

  Map getPropertiesMap() {
    return toJson()[id.toString()];
  }

  void addToMap(Map<String, dynamic> map) {
    map[id.toString()] = getPropertiesMap();
  }

  void incrementId() {
    (querySelector('#id') as InputElement).valueAsNumber = id + 1;
  }

  @override
  String toString() {
    return 'Card : $name :\n'
        'id: $id,\n'
        'type: $type,\n'
        'rarity: $rarity,\n'
        'extension: $extension,\n'
        'maxNbr: $maxNbr,\n'
        'subtypes: $subtypes,\n'
        'devotions: $devotions, \n'
        'constraints: $constraints, \n'
        'keywords: $keywords, \n'
        'effect: $effect, \n'
        'power: $power, \n'
        'resistance: $resistance\n';
  }

  /// to be able to compare two different cards : Card('name') == Card('name'); -> true
  // todo : better implementation with ids
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Card && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
