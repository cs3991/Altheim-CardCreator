import 'dart:html';
import 'dart:convert';
import 'classes/Collection.dart';
import 'classes/Form.dart';
import 'classes/effect-creator/ActionPlaceholder.dart';
import 'classes/effect-creator/Type.dart';

void main() {
  var propertiesForm = PropertiesForm(querySelector('#form'));

  // Each change in the form triggers the update of the card
  propertiesForm.form.onInput.listen((event) {
    propertiesForm.updateJson();
  });

  // --- Listen for click on buttons ---
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

  var trigger = ActionPlaceholder(
    'Déclencheur',
    ExplicitType('trigger'),
    null,
    parentDiv: querySelector('#trigger_div'),
    disableTemplates: true,
  );
  ActionPlaceholder(
    'Condition',
    ExplicitType('bool'),
    null,
    parentDiv: querySelector('#condition_div'),
    triggerPlaceholder: trigger,
  );
  ActionPlaceholder(
    'Action',
    ExplicitType('void'),
    null,
    parentDiv: querySelector('#action_div'),
    triggerPlaceholder: trigger,
  );

  propertiesForm.card.updateFromForm(querySelector('#form'));
  // querySelector('#json').text = jsonEncode(propertiesForm.card.toJson());

  var collection = Collection();

  // querySelector('#button_add_collection').onClick.listen((event) {
  //   collection.add(propertiesForm.card);
  // });
  // querySelector('#button_clear_collection').onClick.listen((event) {
  //   collection.clear();
  // });
}
