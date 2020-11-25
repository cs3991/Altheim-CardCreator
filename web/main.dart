import 'dart:html';
import 'dart:convert';
import 'classes/Card.dart';
import 'classes/Form.dart';

void main() {
  var card = Card.empty();
  var propertiesForm = PropertiesForm(querySelector('#form'));

  // Each change in the form triggers the update of the card
  propertiesForm.form.onInput.listen((event) {
    card.updateFromForm(propertiesForm.form);
    propertiesForm.changeType(card.type);
    querySelector('#json').text = jsonEncode(card.toJson());
  });

  card.updateFromForm(querySelector('#form'));
  querySelector('#json').text = jsonEncode(card.toJson());
}
