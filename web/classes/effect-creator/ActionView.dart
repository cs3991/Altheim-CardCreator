import 'dart:html';

import 'Action.dart';
import 'ActionPlaceholder.dart';
import 'Template.dart';

class ActionView {
  final ActionPlaceholder _placeholder;

  DivElement _mainDiv;
  SelectElement _select;
  DivElement _paramsDiv;
  InputElement _intInput;
  InputElement _strInput;
  SpanElement _returnTypeTxt;

  ActionView(this._placeholder, DivElement div) {
    _mainDiv = document.createElement('div');
    _mainDiv.setAttribute('class', 'action_div');

    var headerDiv = document.createElement('div');
    headerDiv.setAttribute('class', 'action_header');
    _mainDiv.append(headerDiv);

    // Create the label with the name of the action
    var txtName = document.createElement('span');
    txtName.setAttribute('class', 'action_name');
    txtName.innerText = _placeholder.name;
    headerDiv.append(txtName);

    // Create the span with the expected type
    _returnTypeTxt = document.createElement('span');
    _returnTypeTxt.setAttribute('class', 'action_type');
    _updateReturnTypeTxt();
    headerDiv.append(_returnTypeTxt);

    // Create the input for int raw values
    _intInput = document.createElement('input');
    _intInput.setAttribute('type', 'number');
    _intInput.setAttribute('placeholder',
        'Entrez un nombre ici, ou sélectionnez une fonction dans le menu déroulant');
    _intInput.setAttribute('class', 'action_input');
    _intInput.addEventListener('input', _inputChangeCallback);
    _mainDiv.append(_intInput);
    if (_placeholder.isRawValue) {
      _intInput.value = _placeholder.intRawValue.toString();
    }

    // Create the input for string raw values
    _strInput = document.createElement('input');
    _strInput.setAttribute('type', 'text');
    _strInput.setAttribute('placeholder',
        'Entrez un texte ici, ou sélectionnez une fonction dans le menu déroulant');
    _strInput.setAttribute('class', 'action_input');
    _strInput.addEventListener('input', _inputChangeCallback);
    _mainDiv.append(_strInput);
    if (_placeholder.isRawValue) {
      _strInput.value = _placeholder.strRawValue;
    }

    // Create the select representing this action
    _select = document.createElement('select');
    _select.setAttribute('class', 'action_select');
    _populateSelect();
    _select.addEventListener('change', _selectChangeCallback);
    _mainDiv.append(_select);

    _updateRawValuesInputDisplay();

    // Create the div for the parameters
    _paramsDiv = document.createElement('div');
    _paramsDiv.setAttribute('class', 'action_params');
    _populateParams();
    _mainDiv.append(paramsDiv);

    div.append(_mainDiv);
  }

  void _populateSelect() {
    if (_select == null) return;
    var currentValue = _select.value;
    // print(currentValue);

    // Remove all options
    while (_select.children.isNotEmpty) {
      _select.children.first.remove();
    }

    // Create the default null option
    var defaultOption = document.createElement('option');
    defaultOption.setAttribute('class', 'action_option action_default_option');
    defaultOption.setAttribute('value', 'null');
    _select.append(defaultOption);

    for (var action in _placeholder.getCompatibleActions()) {
      var option = document.createElement('option');
      var name = action['name'];
      option.setAttribute('value', name);
      if (action['template'] != null) {
        option.innerText = '-- ' + name + ' --';
      } else {
        option.innerText = name;
      }
      option.setAttribute('title', action['doc']);
      _select.append(option);

      // Select the action contained in the placeholder
      if (name == _placeholder.action?.name) {
        _select.value = name;
      }
    }

    // Reselect the old value if it was set before
    if (currentValue != '') {
      _select.value = currentValue;
    }
  }

  void _populateParams() {
    if (_placeholder.action == null) return;

    for (var par in _placeholder.action.params) {
      par.attachView(_paramsDiv);
    }
  }

  void _selectChangeCallback([Event evt]) {
    _updateRawValuesInputDisplay();
    var val = _select.value;

    _placeholder.unsetAction();

    if (val != 'null') {
      _placeholder.setAction(Action.fromActionName(val, _placeholder));
    }
  }

  void _inputChangeCallback(Event evt) {
    _updateRawValuesInputDisplay();
    var target = evt.currentTarget;
    var val = (target as InputElement).value;

    // Not needed normally
    // _placeholder.unsetAction();

    if (val != '') {
      if (target == _intInput) {
        _placeholder.setRawValue(int.parse(val));
      } else if (target == _strInput) {
        _placeholder.setRawValue(val);
      }
    }
  }

  void destroy() {
    _mainDiv.remove();
  }

  void updateInstantiation(Template template, String typeInst) {
    _populateSelect();
    _updateReturnTypeTxt();
    _updateRawValuesInputDisplay();
  }

  void _updateReturnTypeTxt() {
    _returnTypeTxt.innerText = _placeholder.returnType.toString();
  }

  void _updateRawValuesInputDisplay() {
    _strInput.style.display = 'none';
    _intInput.style.display = 'none';
    _select.style.display = 'inline';
    if (select.value == 'null') {
      if (_placeholder.returnType.type == 'entier') {
        _intInput.style.display = 'inline';
      }
      if (_placeholder.returnType.type == 'texte') {
        _strInput.style.display = 'inline';
      }
    }
    if (_intInput.value != '' || _strInput.value != '') {
      _select.style.display = 'none';
    }
  }

  DivElement get paramsDiv => _paramsDiv;

  DivElement get mainDiv => _mainDiv;

  SelectElement get select => _select;

  InputElement get intInput => _intInput;

  InputElement get stringInput => _strInput;
}
