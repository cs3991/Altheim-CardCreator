import 'dart:html';

import 'CardType.dart';

class Card {
  // todo : rarete, extension, id
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

  Card.empty();

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

  /// Updates all attributes of card to match the values in the form.
  /// Does not update the json text area and the form fields.
  void updateFromForm(FormElement form) {
    name = (form.querySelector('#nom') as InputElement).value;
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
  }

  /// add to json if the display property is not set to 'none'.
  void addIfDisplayed(Map json, dynamic property, String className) {
    if (querySelector('div.' + className).style.display != 'none') {
      json[name][className] = property;
    }
  }

  Map<String, dynamic> toJson() {
    var json = {name: {}};
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
