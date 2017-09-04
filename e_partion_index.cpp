#include "e_header.h"
#include "e_partition.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];

  DIVID_NUM = atoi(args[6]);
  // cout<<DIVID_NUM<<endl;
  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *reader = new FileReader(args[4], false);

  Controller *tController = new Controller();
  tController->LoadgTrajectories(reader);
  Partion *partion = new Partion();
  partion->CreatePartion();

  for (int i = 0; i < gTrajectories->size(); i++) {
    partion->MakeIndex(i, i);
  }

  FileWriter *writer = new FileWriter(args[5], true);
  partion->Save2File(writer);

  return 0;
}
