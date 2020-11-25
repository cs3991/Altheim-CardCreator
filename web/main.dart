import 'dart:html';
import 'dart:convert';
import 'models/Card.dart';

void main() {
  var card = Card.empty();
  var form = querySelector('#form');

  // Each change in the form trigger the update of the card
  form.onInput.listen((event) {
    card.updateFromForm(form);
    querySelector('#json').text = jsonEncode(card.toJson());
  });

  card.updateFromForm(querySelector('#form'));
  querySelector('#json').text = jsonEncode(card.toJson());
}
