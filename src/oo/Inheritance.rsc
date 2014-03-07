module oo::Inheritance

extend oo::Main;

rel[loc, loc] inheritedEntities(M3 model) {
  rel[loc, loc] allInheritances = {<a, b> | <loc a, loc b> <- model@extends o model@containment, \private() notin model@modifiers[b] };
  // remove overridden methods
  allInheritances = allInheritances - (model@containment o model@methodOverrides);
  // add the inheritances from all classes in the inheritances chain
  return ((model@extends+ o allInheritances) + allInheritances);
}