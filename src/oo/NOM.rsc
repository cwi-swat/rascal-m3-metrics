module oo::NOM

extend OO;

int NOM(M3 model) = (0 | it + 1 | entity <- model@declarations<0>, isMethod(entity));
                                  
map[loc class, int methodCount] NOMperClass(M3 model) {
  map[loc, int] result = ();
  for (<class, method> <- model@containment, canContainMethods(class), isMethod(method)) {
    result[class] ? 0 += 1;
  }
  return result;
}
