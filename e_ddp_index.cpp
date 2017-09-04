#include "e_header.h"
#include "e_pddp.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  FileReader *tReader = new FileReader(args[1], true);
  FileWriter *tWriter = new FileWriter(args[2], true);

  gPDDPIndex = new PDDPIndex();
  gPDDPIndex->CreateDDPIndex(tReader, tWriter);

  delete gPDDPIndex;
  delete tReader;
  delete tWriter;

  return 0;
}
