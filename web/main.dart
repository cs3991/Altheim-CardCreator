import 'dart:html';
import 'dart:convert';
import 'models/Card.dart';

void main() {
  Card test = Card.fromJson({
    "NOM": {
      "type": "creature",
      "sous_types": ["SOUSTYPE1", "SOUSTYPE2"],
      "devotions": ["DEVOTION1", "DEVOTION2"],
      "contraintes": {"CONTRAINTE": 1, "C": 2},
      "mots_cles": {"acclimatation": 1, "percee": 1},
      "texte_effet": "TEXT",
      "puissance": 2,
      "resistance": 1
    }
  });
  print(test);
  querySelector('#json').text = jsonEncode(test.toJson());
}
