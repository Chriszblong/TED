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

  FileReader *tPReader = new FileReader(args[2], true);
  FileReader *tLReader = new FileReader(args[3], true);
  FileReader *tTReader = new FileReader(args[4], true);

  FileWriter *tWriter = new FileWriter(args[5], false);

  int tSelect = atoi(args[6]);

  Counter *tCounter = new Counter();

  double tPDDPRatio =
      tCounter->Getratio(tInitReader, tPReader, tLReader, tTReader, tSelect);

  char *s;

  time_t tTimePtr;
  time(&tTimePtr);
  s = ctime(&tTimePtr);

  for (int i = 0; i < strlen(s); i++) {
    tWriter->WriteChar(s[i]);
  }

  tWriter->WriteChar(' ');
  tWriter->WriteDouble(tPDDPRatio);
  tWriter->WriteChar('\n');

  return 0;
}
