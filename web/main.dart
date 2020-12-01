import 'dart:html';
import 'dart:convert';
import 'classes/Action.dart';
import 'classes/Collection.dart';
import 'classes/Form.dart';

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

  querySelector('#condition_div').append(Action('bool', 'condition', null).mainDiv);
  querySelector('#action_div').append(Action('void', 'action', null).mainDiv);

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
