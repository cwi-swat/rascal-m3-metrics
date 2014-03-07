module oo::Main

import String;
import lang::java::m3::Core;
import lang::java::m3::AST;

bool isClass(loc l) = contains(l.scheme, "class");
bool isInterface(loc l) = contains(l.scheme, "interface");
bool isEnum(loc l) = contains(l.scheme, "enum");
bool isAnonymousClass(loc l) = contains(l.scheme, "anonymousClass");
bool isMethod(loc l) = contains(l.scheme, "method") || contains(l.scheme, "constructor");
bool isField(loc l) = contains(l.scheme, "field");
bool isPackage(loc l) = contains(l.scheme, "package");

bool canContainMethods(loc l) = isClass(l) || isInterface(l) || isEnum(l) || isAnonymousClass(l);
bool canContainFields(loc l) = isClass(l) || isInterface(l) || isAnonymousClass(l);

bool hasPackageModifier(M3 model, loc l) = ({ \public(), \protected(), \private() } & model@modifiers[l]) == {}; 

map[loc, set[loc]] declaredMethodsperClass(M3 model) {
  map[loc, set[loc]] result = ();
  set[loc] emptySet = {};
  for (<c, m> <- model@containment, canContainMethods(c), isMethod(m)) {
    result[c]? emptySet += {m};
  }
  return result;
}

map[loc, set[loc]] declaredFieldsperClass(M3 model) {
  map[loc, set[loc]] result = ();
  set[loc] emptySet = {};
  for (<c, m> <- model@containment, canContainFields(c), isField(m)) {
    result[c]? emptySet += {m};
  }
  return result;
}
