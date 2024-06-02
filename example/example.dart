import 'package:heart/heart.dart';

/// Small sample of package features
void main() {
  List<String> cardValues = [
        'A',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        'J',
        'Q',
        'K',
      ] *
      4;

  List<String> cardSuits =
      ['spades'] * 13 + ['hearts'] * 13 + ['diamonds'] * 13 + ['clubs'] * 13;

  List deckOfCards = zip([cardValues, cardSuits]);
  List shuffledDeck = zip([cardValues, cardSuits]).shuffled();

  print('Sorted deck: \n$deckOfCards\n');

  print('Shuffled deck: \n$shuffledDeck');

  List redCards = shuffledDeck
      .filter((elem) => elem.contains('hearts') || elem.contains('diamonds'));

  print('\nRed cards:\n$redCards');
  // ----------

  String countdown = nums(10, 1).toStringList().intercalate('-');
  print('\n$countdown HAPPY NEW YEAR!');
}
