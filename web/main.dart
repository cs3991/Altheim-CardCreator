import 'dart:html';

void main() {
  querySelector('#type').onChange.listen((event) {
    print((querySelector('#type') as SelectElement).value);
  });
}
