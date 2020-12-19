import 'Action.dart';
import 'ActionPlaceholder.dart';
import 'Template.dart';

abstract class AbstractType {
  final List<AbstractType> _typeParameters = [];

  AbstractType();

  factory AbstractType.fromJson(Map<String, dynamic> typeJson, Map<String, Template> templates) {
    var typeParameters = typeJson['parameters'];
    String typeName = typeJson['type'];

    AbstractType ret;

    // If the type is a template name, this will get the template object associated,
    // else it will be null
    var typeTemplate = (templates != null ? templates[typeName] : null);
    if (typeTemplate != null) {
      ret = TemplateType(typeTemplate);
    } else {
      ret = ExplicitType(typeName);
    }

    if (typeParameters != null) {
      for (var param in typeParameters) {
        ret._typeParameters.add(AbstractType.fromJson(param, templates));
      }
    }

    return ret;
  }

  factory AbstractType.tempFromJson(Map<String, dynamic> typeJson, List<String> templates) {
    var typeParameters = typeJson['parameters'];
    String typeName = typeJson['type'];

    AbstractType ret;

    // If the type is a template name, this will get the template object associated,
    // else it will be null
    if (templates != null && templates.contains(typeName)) {
      ret = TemplateType(Template());
    } else {
      ret = ExplicitType(typeName);
    }

    if (typeParameters != null) {
      for (var param in typeParameters) {
        ret._typeParameters.add(AbstractType.tempFromJson(param, templates));
      }
    }

    return ret;
  }

  String get type;

  bool get isTemplate;

  bool get isParametered {
    return _typeParameters.isNotEmpty;
  }

  bool canUnify(AbstractType other) {
    if (_typeParameters.length != other._typeParameters.length) {
      return false;
    }
    if (type == null || other.type == null) {
      return _typeParameters.isEmpty;
    }
    if (type == other.type) {
      var ret = true;
      for (var i = 0; i < _typeParameters.length; i++) {
        ret &= (_typeParameters[i].canUnify(other._typeParameters[i]));
      }
      return ret;
    }
    return false;
  }

  void unify(AbstractType other, Action caller);

  void subscribeToUpdate(ActionPlaceholder caller);
}

class TemplateType extends AbstractType {
  final Template _template;

  TemplateType(this._template);

  @override
  String get type {
    return _template.instantiation;
  }

  @override
  bool get isTemplate {
    return true;
  }

  @override
  void unify(AbstractType other, Action caller) {
    assert(canUnify(other)); // Temp
    if (other is TemplateType) {
      _template.addUnifiedTemplate(other._template);
    } else {
      _template.setInstantiation(other.type, caller);
      caller.addConstrainedTemplate(_template);
    }
    for (var i = 0; i < _typeParameters.length; i++) {
      _typeParameters[i].unify(other._typeParameters[i], caller);
    }
  }

  @override
  String toString() {
    var ret;
    if (type == null) {
      ret = '[Generic]';
    } else {
      ret = '[' + type + ']';
    }

    if (_typeParameters.isNotEmpty) {
      ret += '<';
      var sep = '';
      for (var p in _typeParameters) {
        ret += sep + p.toString();
        sep = ' ; ';
      }
      ret += '>';
    }
    return ret;
  }

  Template get template => _template;

  @override
  void subscribeToUpdate(ActionPlaceholder caller) {
    _template.subscribeToUpdates(caller);
    _typeParameters.forEach((param) {
      param.subscribeToUpdate(caller);
    });
  }
}

class ExplicitType extends AbstractType {
  final String _type;

  ExplicitType(this._type);

  @override
  String get type {
    return _type;
  }

  @override
  bool get isTemplate {
    return false;
  }

  @override
  void unify(AbstractType other, Action caller) {
    if (other is TemplateType) {
      other._template.setInstantiation(type, caller);
      caller.addConstrainedTemplate(other._template);
    }
    for (var i = 0; i < _typeParameters.length; i++) {
      _typeParameters[i].unify(other._typeParameters[i], caller);
    }
  }

  @override
  String toString() {
    var ret = type;
    if (_typeParameters.isNotEmpty) {
      ret += '<';
      var sep = '';
      for (var p in _typeParameters) {
        ret += sep + p.toString();
        sep = ' ; ';
      }
      ret += '>';
    }
    return ret;
  }

  @override
  void subscribeToUpdate(ActionPlaceholder caller) {
    _typeParameters.forEach((param) {
      param.subscribeToUpdate(caller);
    });
  }
}
