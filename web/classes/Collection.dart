import 'dart:convert';
import 'dart:html';
import 'Card.dart';
import 'Form.dart';

class Collection {
  Set<Card> collectionSet = {};
  Map<Card, HtmlElement> collectionElementsMap = {};
  Map<int, dynamic> collectionJson = {};

  /// Create a div corresponding to a card in the element collection
  HtmlElement _createListElement(Card card, PropertiesForm propertiesForm) {
    return DivElement()
      ..className = 'collectioncarte'
      ..onClick.listen((event) {
        propertiesForm.changeCard(card);
        collectionElementsMap.forEach((key, value) {
          value.classes.remove('selected');
        });
        collectionElementsMap[card].classes.add('selected');
      })
      ..children.add(ParagraphElement()..text = card.name)
      ..children.add(ImageElement()
        ..src = 'cross.png'
        ..onClick.listen((event) {
          remove(card, propertiesForm);
          event.stopPropagation();
        }));
  }

  void _incrementId() {
    (querySelector('#id') as InputElement).valueAsNumber += 1;
  }

  // todo: rewrite for the new collection
  void updateJson() {
    collectionJson = {};
    for (var card in collectionSet) {
      card.addToMap(collectionJson);
    }
    (querySelector('#collection_text_area') as TextAreaElement).value = jsonEncode(collectionJson);
  }

  // Not used anymore
  void updateHtml(PropertiesForm propertiesForm) {
    querySelector('#liste_collection').children.clear(); // empty the list before adding all elements of collectionSet
    for (var card in collectionSet) {
      querySelector('#liste_collection').children.add(_createListElement(card, propertiesForm));
    }
  }

  void add(Card card, PropertiesForm propertiesForm) {
    collectionSet.add(card);
    if (!collectionElementsMap.containsKey(card)) {
      collectionElementsMap[card] = _createListElement(card, propertiesForm);
      querySelector('#liste_collection').children.add(collectionElementsMap[card]);
      _incrementId();
    }
    card.activate(propertiesForm);
    collectionElementsMap.forEach((key, value) {
      value.classes.remove('selected');
    });
    collectionElementsMap[card].classes.add('selected');
    print('CollectionElem : $collectionElementsMap');
    // updateJson();
  }

  void remove(Card card, PropertiesForm propertiesForm) {
    collectionSet.remove(card).toString();
    collectionElementsMap[card].remove();
    collectionElementsMap.remove(card);
    if (collectionSet.isNotEmpty) {
      collectionSet.last.activate(propertiesForm);
      collectionElementsMap.forEach((key, value) {
        value.classes.remove('selected');
      });
      collectionElementsMap[collectionSet.last].classes.add('selected');
    }
    // updateJson();
    print('Collection : $collectionSet');
  }

  void clear() {
    collectionSet = <Card>{};
    collectionElementsMap = <Card, HtmlElement>{};
    // updateJson();
    print('Collection : $collectionSet');
  }

  void changeName(Card card) {
    collectionElementsMap[card].firstChild.text = card.name;
  }
}
