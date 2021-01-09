import 'dart:html';

import 'classes/Card.dart';
import 'classes/Collection.dart';
import 'classes/Form.dart';
import 'utils/ButtonListeners.dart';

void main() {
  var propertiesForm = PropertiesForm(querySelector('#form'));
  var collection = Collection();
  ButtonListeners.initListeners(propertiesForm, collection);
  collection.add(Card.empty(), propertiesForm);
  propertiesForm.changeCard(collection.collectionSet.first);

  // Update once after loading
  propertiesForm.update();

  // Each change in the form triggers the update of the card
  querySelector('#form').onInput.listen((event) {
    propertiesForm.update();
    collection.changeName(propertiesForm.card);
  });

  // Show a popup before leaving to not dismiss any unsaved change
  window.onBeforeUnload.listen((event) {
    (event as BeforeUnloadEvent).returnValue = 'Are you sure you want to leave?';
  });
}
