import 'dart:html';

import 'CardType.dart';

class PropertiesForm {
  FormElement form;

  PropertiesForm(this.form);

  void activateDiv(List<String> list) {
    for (var champ in document.querySelectorAll('div.champ')) {
      champ.style.display = 'none';
    }
    for (var champ in list.map((x) => document.querySelector('div.' + x))) {
      champ.style.display = 'unset';
    }
  }

  void changeType(CardType type) {
    switch (type) {
      case CardType.construction:
        activateDiv([
          'nom',
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
          'sous_types',
          'texte_effet',
        ]);
        break;
      case CardType.miracle:
        activateDiv([
          'nom',
          'sous_types',
          'contraintes',
          'texte_effet',
        ]);
        break;
      case CardType.divinity:
        activateDiv([
          'nom',
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
}
