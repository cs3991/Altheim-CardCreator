import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'Card.dart';

class Collection {
  Set<Card> collectionSet = {};
  Map collectionJson = {};

  /// Adds a div corresponding to a card in the element collection in the html
  HtmlElement _createListElement(Card card) {
    var newElement = DivElement();
    newElement.children.add(ButtonElement()
      ..text = '×'
      ..onClick.listen((event) {
        remove(card);
      }));
    newElement.appendText('   ' + card.name);
    return newElement;
  }

  void updateJson() {
    collectionJson = {};
    for (var card in collectionSet) {
      collectionJson[card.name] = card.toJson()[card.name];
    }
    (querySelector('#collection_text_area') as TextAreaElement).value = jsonEncode(collectionJson);
  }

  void updateHtml() {
    querySelector('#liste_collection').children.clear(); // empty the list before adding all elements of collectionSet
    for (var card in collectionSet) {
      querySelector('#liste_collection').children.add(_createListElement(card));
    }
  }

  void add(Card card) {
    collectionSet.add(card.copy()).toString();
    updateJson();
    updateHtml();
  }

  void remove(Card card) {
    collectionSet.remove(card).toString();
    updateJson();
    updateHtml();
  }

  void clear() {
    collectionSet = {};
    updateHtml();
    updateJson();
  }
}
