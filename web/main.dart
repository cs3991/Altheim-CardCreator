import 'dart:html';
import 'classes/Card.dart';
import 'classes/Collection.dart';
import 'classes/Form.dart';
import 'classes/effect-creator/ActionPlaceholder.dart';
import 'classes/effect-creator/Type.dart';
import 'utils/ButtonListeners.dart';

void main() {
  var propertiesForm = PropertiesForm(querySelector('#form'));
  var collection = Collection();
  ButtonListeners.initListeners(propertiesForm, collection);
  collection.add(Card.empty(), propertiesForm);
  collection.collectionSet.first.activate(propertiesForm);

  // Each change in the form triggers the update of the card
  querySelector('#nom').onInput.listen((event) {
    propertiesForm.updateJson();
    collection.changeName(propertiesForm.card);
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

  propertiesForm.card.updateFromForm(propertiesForm.form);

  // querySelector('#json').text = jsonEncode(propertiesForm.card.toJson());

  // querySelector('#button_add_collection').onClick.listen((event) {
  //   collection.add(propertiesForm.card);
  // });
  // querySelector('#button_clear_collection').onClick.listen((event) {
  //   collection.clear();
  // });

  window.onBeforeUnload.listen((event) {
    (event as BeforeUnloadEvent).returnValue = 'Are you sure you want to leave?';
  });
}
