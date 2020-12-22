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
          'effet',
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
          'effet',
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
          'effet',
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
          'effet',
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
          'effet',
          'puissance',
          'resistance',
        ]);
        break;
    }
  }

  /// Updates the card attribute to match the values from the form
  // and shows the resulting json in the text area (not anymore).
  void updateJson() {
    card.updateFromForm(form);
    changeType(card.type);
    // querySelector('#json').text = jsonEncode(card.toJson());
  }

  /// Adds an element to the document
  void _addElement(String parentClass, String elementClass, String html) {
    var newElement = DivElement();
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
    var html = '<input type="text" class="sous_types">'
        '<button type="button" name="button">-</button>';
    _addElement('.sous_types>.titre_bouton', 'expandable', html);
  }

  void addDevotion() {
    var html = '<input type="text" class="devotions">'
        '<button type="button" name="button">-</button>';
    _addElement('.devotions>.titre_bouton', 'expandable', html);
  }

  void addConstraints() {
    var html = '<input type="number" min="1" max="99" class="contrainte_nb contraintes"> '
        '<input type="text" class="contrainte_text contraintes">'
        '<button type="button" name="button">-</button>';
    _addElement('.contraintes>.titre_bouton', 'expandable', html);
  }
}
