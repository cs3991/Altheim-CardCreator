import 'Action.dart';
import 'ActionPlaceholder.dart';

class Template {
  String _instantiation;
  final Set<ActionPlaceholder> _dependentPlaceholders = {};
  final Set<Template> _unifiedTemplates = {};
  final Set<Action> _instantiationSetters = {};

  Template();

  void subscribeToUpdates(ActionPlaceholder action) {
    _dependentPlaceholders.add(action);
  }

  void unsubscribeToUpdates(ActionPlaceholder action) {
    _dependentPlaceholders.remove(action);
  }

  void addUnifiedTemplate(Template other) {
    _unifiedTemplates.add(other);
    other._unifiedTemplates.add(this);
    if (other._instantiation != null && _instantiation == null) {
      _unifiedSetInstanciation(other._instantiation, this);
    }
    if (other._instantiation == null && _instantiation != null) {
      _unifiedSetInstanciation(_instantiation, this);
    }
  }

  void removeUnifiedTemplate(Template other) {
    _unifiedTemplates.remove(other);
    other._unifiedTemplates.remove(this);
    _checkAndUnsetInstantiation();
    other._checkAndUnsetInstantiation();
  }

  void _checkAndUnsetInstantiation() {
    if (_canUnsetInstantiation(this)) {
      _instantiation = null;
      _dependentPlaceholders.forEach((a) {
        a.updateInstantiation(this, null);
      });
      _unifiedTemplates.forEach((t) {
        t._unifiedUnsetInstanciation(this);
      });
    }
  }

  void setInstantiation(String type, Action caller) {
    _instantiation = type;
    _instantiationSetters.add(caller);
    _dependentPlaceholders.forEach((a) {
      a.updateInstantiation(this, type);
    });
    _unifiedTemplates.forEach((t) {
      t._unifiedSetInstanciation(type, this);
    });
  }

  void _unifiedSetInstanciation(String type, Template caller) {
    _instantiation = type;
    _dependentPlaceholders.forEach((a) {
      a.updateInstantiation(this, type);
    });
    _unifiedTemplates.forEach((t) {
      if (t != caller) t._unifiedSetInstanciation(type, this);
    });
  }

  bool _canUnsetInstantiation(Template caller) {
    return _instantiationSetters.isEmpty &&
        _unifiedTemplates.every((t) {
          return t == caller || t._canUnsetInstantiation(this);
        });
  }

  void unsetInstantiation(Action caller) {
    if (_instantiation == null) return;
    _instantiationSetters.remove(caller);
    _checkAndUnsetInstantiation();
  }

  void _unifiedUnsetInstanciation(Template caller) {
    _instantiation = null;
    _dependentPlaceholders.forEach((a) {
      a.updateInstantiation(this, null);
    });
    _unifiedTemplates.forEach((t) {
      if (t != caller) t._unifiedUnsetInstanciation(this);
    });
  }

  void destroy() {
    var toRemove = <Template>{};
    toRemove.addAll(_unifiedTemplates);
    toRemove.forEach((unified) {
      removeUnifiedTemplate(unified);
    });
  }

  String get instantiation => _instantiation;
}
