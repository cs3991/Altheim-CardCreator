import 'dart:convert';
import 'dart:html';

import '../classes/Card.dart';
import '../classes/Collection.dart';
import '../classes/Form.dart';

/// Listen for click on buttons
class ButtonListeners {
  static void initListeners(PropertiesForm propertiesForm, Collection collection) {
    // Button add Sub Type
    querySelector('.sous_types>button').onClick.listen((event) {
      propertiesForm.addSubType();
    });

    // Button add Constraint
    querySelector('.contraintes>button').onClick.listen((event) {
      propertiesForm.addConstraints();
    });

    // Button add Devotion
    querySelector('.devotions>button').onClick.listen((event) {
      propertiesForm.addDevotion();
    });

    // Button "Modifier les effets"
    querySelector('button.effet').onClick.listen((event) {
      querySelector('#popup_bg').style.display = 'unset';
    });

    // Button close popup
    querySelector('#close_popup').onClick.listen((event) {
      querySelector('#popup_bg').style.display = 'none';
    });

    // Click on bg to close popup
    querySelector('#popup_bg').onClick.listen((event) {
      querySelector('#popup_bg').style.display = 'none';
    });
    querySelector('#popup').onClick.listen((event) {
      event.stopPropagation();
    });

    // Delete base subtype
    querySelector('#base_sous_type>button').onClick.listen((event) {
      querySelector('#base_sous_type').remove();
    });

    // Delete base devotion
    querySelector('#base_devotion>button').onClick.listen((event) {
      querySelector('#base_devotion').remove();
    });

    // Delete base subtype
    querySelector('#base_contrainte>button').onClick.listen((event) {
      querySelector('#base_contrainte').remove();
    });

    // Button add to collection
    querySelector('#add_card_collection').onClick.listen((event) {
      collection.add(Card.empty(), propertiesForm);
    });

    // Button clear collection
    querySelector('#empty_btn').onClick.listen((event) {
      collection.clear(propertiesForm);
    });

    // Hover button to show json (card)
    querySelector('#show_json').onMouseOver.listen((event) {
      (querySelector('#json') as TextAreaElement).value = jsonEncode(propertiesForm.card.toJson());
    });

    // Button copy json to clipboard (card)
    querySelector('#copy_card_json').onClick.listen((event) {
      (querySelector('#json') as TextAreaElement).select();
      document.execCommand('copy');
    });

    // Button export json file (card)
    querySelector('#export_card_json').onClick.listen((event) {
      // String code = (querySelector('#json') as TextAreaElement).value;
      var text = jsonEncode(propertiesForm.card.toJson());
      final bytes = utf8.encode(text);
      final blob = Blob([bytes]);
      final url = Url.createObjectUrlFromBlob(blob);
      final anchor = document.createElement('a') as AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = propertiesForm.card.name + '.json';
      document.body.children.add(anchor);
      // download
      anchor.click();
      // cleanup
      document.body.children.remove(anchor);
      Url.revokeObjectUrl(url);
    });

    // Button reset card
    querySelector('#reset_card').onClick.listen((event) {
      // TODO: à faire
    });
  }
}
