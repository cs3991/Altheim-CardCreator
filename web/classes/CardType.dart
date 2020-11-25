enum CardType { creature, construction, miracle, divinity, place }

extension CardTypeExtension on CardType {
  String toText() {
    switch (this) {
      case (CardType.creature):
        return 'creature';
      case (CardType.construction):
        return 'construction';
      case (CardType.miracle):
        return 'miracle';
      case (CardType.divinity):
        return 'divinity';
      case (CardType.place):
        return 'lieu';
      default:
        return null;
    }
  }

  static CardType fromString(String s) {
    switch (s) {
      case ('creature'):
        return CardType.creature;
      case ('construction'):
        return CardType.construction;
      case ('miracle'):
        return CardType.miracle;
      case ('divinite'):
        return CardType.divinity;
      case ('lieu'):
        return CardType.place;
      default:
        return null;
    }
  }
}
