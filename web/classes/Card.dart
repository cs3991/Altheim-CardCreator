import 'dart:html';

import 'CardType.dart';
import 'Form.dart';
import 'effect-creator/Effect.dart';

class Card {
  int id;
  String extension = '';
  String rarity = '';
  String name = '';
  int maxNbr = 0;
  CardType type = CardType.creature;
  List<String> subtypes = <String>[];
  List<String> devotions = <String>[];
  Map<String, dynamic> constraints = <String, dynamic>{};
  Map<String, dynamic> keywords = <String, dynamic>{};
  List<Effect> effects = [Effect()]; // TODO: Handle multiple effects
  String effectTxt = '';
  int power = 0;
  int resistance = 0;

  static int maxId = 0;

  Card(this.id, this.name, this.maxNbr, this.type, this.extension, this.rarity, this.subtypes, this.devotions,
      this.constraints, this.keywords, this.effectTxt, this.power, this.resistance);

  Card.empty() {
    id = createId();
  }

  Card.fromJson(Map<String, dynamic> json)
      : id = maxId++,
        name = json['nom'],
        maxNbr = json['nbr_max'],
        type = CardTypeExtension.fromString(json['type']),
        rarity = json['rarete'],
        extension = json['extension'],
        subtypes = List<String>.from(json['sous_types' ?? []]),
        devotions = List<String>.from(json['devotions'] ?? []),
        constraints = Map<String, dynamic>.from(json['contraintes'] ?? {}),
        keywords = Map<String, dynamic>.from(json['mots_cles'] ?? {}),
        effectTxt = json['texte_effet'],
        effects =
            List<Effect>.from(json['effet'].map((e) => Effect.fromJson(e))),
        power = json['puissance'],
        resistance = json['resistance'];

  int createId() {
    return maxId++;
  }

  /// Updates all attributes of card to match the values in the form.
  /// Does not update the json text area and the form fields.
  void updateFromForm(FormElement form) {
    id = int.tryParse((querySelector('#id') as InputElement).value) ?? id;
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
    for (var i = 0; i < constraintsText.length; i++) {
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
      effectTxt = (form.querySelector('#texte_effet') as TextAreaElement).value;
      power = int.tryParse((form.querySelector('#puissance') as InputElement).value);
      resistance = int.tryParse((form.querySelector('#resistance') as InputElement).value);
    }
  }

  void activate(PropertiesForm propertiesForm) {
    var form = propertiesForm.form;
    (querySelector('#type') as SelectElement).value = type.toText();
    (querySelector('#id') as InputElement).valueAsNumber = id;
    (querySelector('#nbr_max') as InputElement).valueAsNumber = maxNbr;
    (form.querySelector('#nom') as InputElement).value = name;
    (form.querySelector('#rarete') as SelectElement).value = rarity;
    (form.querySelector('#extension') as SelectElement).value = extension;
    (form.querySelector('#type') as SelectElement).value = type.toText();
    propertiesForm.changeType(type);
    propertiesForm.removeAllSubtypes();
    for (var subtype in subtypes) {
      propertiesForm.addSubType(subtype);
    }
    propertiesForm.removeAllDevotions();
    for (var devotion in devotions) {
      propertiesForm.addDevotion(devotion);
    }
    propertiesForm.removeAllConstraints();
    for (var constraint in constraints.keys) {
      propertiesForm.addConstraints(constraint, constraints[constraint].toString());
    }
    querySelectorAll('input[type="checkbox"].mot-cles').forEach((element) {
      (element as CheckboxInputElement).checked = false;
    });
    querySelectorAll('input[type="checkbox"].mots_cles').forEach((element) {
      (element as CheckboxInputElement).checked = false;
    });
    for (var keyword in keywords.entries) {
      (querySelector('#' + keyword.key) as CheckboxInputElement).checked = true;
      if (querySelectorAll('#' + keyword.key + '_nb').isNotEmpty) {
        (querySelectorAll('#' + keyword.key + '_nb')[0] as InputElement).value = keyword.value.toString();
      }
    }
    (form.querySelector('#texte_effet') as TextAreaElement).value = effectTxt;
    (form.querySelector('#puissance') as InputElement).value = power.toString();
    (form.querySelector('#resistance') as InputElement).value = resistance.toString();
    // TODO: Attach a view for all effects
    effects[0].attachView(querySelector('#trigger_div'), querySelector('#condition_div'), querySelector('#action_div'));
  }

  void deactivate() {
    for (var effect in effects) {
      effect.detachView();
    }
  }

  /// add to json if the display property is not set to 'none'.
  void addIfDisplayed(Map<String, dynamic> json, String propertyName, dynamic property, String className) {
    if (querySelector('div.' + className).style.display != 'none') {
      json[propertyName] = property;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'id': id};
    addIfDisplayed(json, 'nom', name, 'nom');
    addIfDisplayed(json, 'nbr_max', maxNbr, 'nbr_max');
    addIfDisplayed(json, 'rarete', rarity, 'rarete');
    addIfDisplayed(json, 'extension', extension, 'extension');
    addIfDisplayed(json, 'type', type.toText(), 'type');
    addIfDisplayed(json, 'sous_types', subtypes, 'sous_types');
    addIfDisplayed(json, 'devotions', devotions, 'devotions');
    addIfDisplayed(json, 'contraintes', constraints, 'contraintes');
    addIfDisplayed(json, 'mots_cles', keywords, 'mots_cles');
    addIfDisplayed(json, 'texte_effet', effectTxt, 'effet');
    addIfDisplayed(json, 'effet', effects.map((e) => e.toJson()).toList(growable: false), 'effet');
    addIfDisplayed(json, 'puissance', power, 'puissance');
    addIfDisplayed(json, 'resistance', resistance, 'resistance');
    return json;
  }

  /// since Dart doesn't support cloning object, this function is just a workaround for this
  Card copy() {
    return Card(id, name, maxNbr, type, extension, rarity, subtypes, devotions, constraints, keywords, effectTxt, power,
        resistance);
  }

  // Map getPropertiesMap() {
  //   return toJson()[id.toString()];
  // }
  //
  // void addToMap(Map<String, dynamic> map) {
  //   map[id.toString()] = getPropertiesMap();
  // }

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
        'effect: $effectTxt, \n'
        'power: $power, \n'
        'resistance: $resistance\n';
  }

  /// to be able to compare two different cards : Card('name') == Card('name'); -> true
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Card && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
