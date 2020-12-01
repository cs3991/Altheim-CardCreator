import 'dart:convert';
import 'dart:html';

import 'Card.dart';
import 'CardType.dart';

class PropertiesForm {
  Card card = Card.empty();
  FormElement form;
  var subtypes_id = 0;
  var devotions_id = 0;
  var constraints_id = 0;

  PropertiesForm(this.form);

  void activateDiv(List<String> list) {
    for (var champ in document.querySelectorAll('div.champ')) {
      champ.style.display = 'none';
    }
    for (var champ in list.map((x) => document.querySelector('div.' + x))) {
      champ.style.display = 'unset';
    }
  }

  /// activates the fields of the form corresponding to the type of card selected
  void changeType(CardType type) {
    switch (type) {
      case CardType.construction:
        activateDiv([
          'nom',
          'id',
          'nbr_max',
          'rarete',
          'extension',
          'contraintes',
          'mots_cles',
          'texte_effet',
          'puissance',
          'resistance',
        ]);
        break;
      case CardType.place:
        activateDiv([
          'nom',
          'id',
          'nbr_max',
          'rarete',
          'extension',
          'sous_types',
          'texte_effet',
        ]);
        break;
      case CardType.miracle:
        activateDiv([
          'nom',
          'id',
          'nbr_max',
          'rarete',
          'extension',
          'sous_types',
          'contraintes',
          'texte_effet',
        ]);
        break;
      case CardType.divinity:
        activateDiv([
          'nom',
          'id',
          'nbr_max',
          'rarete',
          'extension',
          'sous_types',
          'devotions',
          'contraintes',
          'texte_effet',
        ]);
        break;
      case CardType.creature:
      default:
        activateDiv([
          'nom',
          'id',
          'nbr_max',
          'rarete',
          'extension',
          'sous_types',
          'devotions',
          'contraintes',
          'mots_cles',
          'texte_effet',
          'puissance',
          'resistance',
        ]);
        break;
    }
  }

  /// Updates the card attribute to match the values from the form and shows the resulting
  /// json in the text area.
  void updateJson() {
    card.updateFromForm(form);
    changeType(card.type);
    querySelector('#json').text = jsonEncode(card.toJson());
  }

  /// Adds an element to the document
  void _addElement(String parentClass, String elementTag, String elementId, String elementClass, String html) {
    var newElement = DivElement();
    newElement.id = elementId;
    newElement.classes = [elementClass];
    newElement.setInnerHtml(html);
    newElement.querySelector('button').onClick.listen((event) {
      newElement.remove();
      updateJson();
    });
    var parent = querySelector(parentClass);
    parent.children.add(newElement);
  }

  void addSubType() {
    subtypes_id++; // increment sous_type_id to get a unique ID for the new element
    var html = '<input type="text" class="sous_types">'
        '<button>&times;</button>';
    _addElement('.sous_types', 'div', 'sous_types_' + subtypes_id.toString(), 'removable', html);
  }

  void addDevotion() {
    devotions_id++; // increment devotion_id to get a unique ID for the new element
    var html = '<input type="text" class="devotions">'
        '<button>&times;</button>';

    _addElement('.devotions', 'div', 'devotions_' + devotions_id.toString(), 'removable', html);
  }

  void addConstraints() {
    constraints_id++; // increment devotion_id to get a unique ID for the new element
    var html = '<input type="text" class="contrainte_text contraintes">'
        '<input type="number" min="1" max="99" class="contrainte_nb contraintes"><br>'
        '<button>&times;</button>';
    _addElement('.contraintes', 'div', 'contraintes_' + constraints_id.toString(), 'removable', html);
  }
}
