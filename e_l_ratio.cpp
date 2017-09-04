#include "e_counter.hpp"
#include "e_header.h"
#include "e_tool.hpp"
#include <iostream>
#include <string>
#include <time.h>
#include <vector>
using namespace std;

int main(int argv, char *args[]) {
  FileReader *ireader = new FileReader(args[1], false);
  FileReader *tLReader = new FileReader(args[2], true);
  FileWriter *writer = new FileWriter(args[3], false);
  int select = atoi(args[4]);
  Counter *counter = new Counter();
  double lRatio = counter->GetratioL(ireader, tLReader, select);
  char *s;
  time_t tTimePtr;
  time(&tTimePtr);
  s = ctime(&tTimePtr);
  for (int i = 0; i < strlen(s); i++) {
    writer->WriteChar(s[i]);
  }
  writer->WriteChar(' ');
  writer->WriteDouble(lRatio);
  writer->WriteChar('\n');
  return 0;
}
