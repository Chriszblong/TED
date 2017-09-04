#include "e_counter.hpp"
#include "e_header.h"
#include "e_tool.hpp"
#include <iostream>
#include <string>
#include <time.h>
#include <vector>
using namespace std;

int main(int argv, char *args[]) {

  FileReader *tInitReader = new FileReader(args[1], false);
  FileReader *tCodingReader = new FileReader(args[2], true);
  FileWriter *tWriter = new FileWriter(args[3], false);

  Counter *tCounter = new Counter();

  double tratio = tCounter->GetratioT(tInitReader, tCodingReader);
  char *s;

  time_t tTimePtr;
  time(&tTimePtr);

  s = ctime(&tTimePtr);

  for (int i = 0; i < strlen(s); i++) {
    tWriter->WriteChar(s[i]);
  }

  tWriter->WriteChar(' ');
  tWriter->WriteDouble(tratio);
  tWriter->WriteChar('\n');

  return 0;
}
