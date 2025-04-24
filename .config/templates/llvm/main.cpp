#include "llvm/ADT/StringRef.h"
#include <iostream>

int main() {
  llvm::StringRef hello = "hello world";
  std::cout << hello.str() << std::endl;
}
