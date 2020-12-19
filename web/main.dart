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

  querySelector('.sous_types>div>button').onClick.listen((event) {
    propertiesForm.addSubType();
  });
  querySelector('.contraintes>div>button').onClick.listen((event) {
    propertiesForm.addConstraints();
  });
  querySelector('.devotions>div>button').onClick.listen((event) {
    propertiesForm.addDevotion();
  });

  var trigger = ActionPlaceholder('Déclencheur', ExplicitType('trigger'), null, parentDiv:querySelector('#trigger_div'), disableTemplates: true);
  ActionPlaceholder('Condition', ExplicitType('bool'), null, parentDiv:querySelector('#condition_div'), triggerPlaceholder: trigger);
  ActionPlaceholder('Action', ExplicitType('void'), null, parentDiv:querySelector('#action_div'), triggerPlaceholder: trigger);

  propertiesForm.card.updateFromForm(querySelector('#form'));
  querySelector('#json').text = jsonEncode(propertiesForm.card.toJson());

  var collection = Collection();

  querySelector('#button_add_collection').onClick.listen((event) {
    collection.add(propertiesForm.card);
  });
  querySelector('#button_clear_collection').onClick.listen((event) {
    collection.clear();
  });
}
