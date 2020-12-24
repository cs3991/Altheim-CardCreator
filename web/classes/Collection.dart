import 'dart:convert';
import 'dart:html';
import 'Card.dart';

class Collection {
  Set<Card> collectionSet = {};
  Map<Card, HtmlElement> collectionElementsMap = {};
  Map<int, dynamic> collectionJson = {};

  /// Create a div corresponding to a card in the element collection
  HtmlElement _createListElement(Card card) {
    return DivElement()
      ..className = 'collectioncarte'
      ..children.add(ParagraphElement()..text = card.name)
      ..children.add(ImageElement()
        ..src = 'cross.png'
        ..onClick.listen((event) {
          remove(card);
        }));
  }

  void _incrementId() {
    (querySelector('#id') as InputElement).valueAsNumber += 1;
  }

  void updateJson() {
    collectionJson = {};
    for (var card in collectionSet) {
      card.addToMap(collectionJson);
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
    if (!collectionElementsMap.containsKey(card)) {
      collectionElementsMap[card] = _createListElement(card);
      querySelector('#liste_collection').children.add(collectionElementsMap[card]);
      _incrementId();
    }
    print('Collection : $collectionSet');
    // updateJson();
    // updateHtml();
  }

  void remove(Card card) {
    collectionSet.remove(card).toString();
    collectionElementsMap[card].remove();
    collectionElementsMap.remove(card);
    // updateJson();
    // updateHtml();
    print('Collection : $collectionSet');
  }

  void clear() {
    collectionSet = {};
    collectionElementsMap = {};
    // updateHtml();
    // updateJson();
    print('Collection : $collectionSet');
  }
}
