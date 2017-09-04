#include "e_header.h"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include "e_trajectory.hpp"
#include <iostream>
#include <string>
using namespace std;

int main(int argv, char *args[]) {

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *tReader = new FileReader(args[4], false);
  FileWriter *tWriter = new FileWriter(args[5], false);

  Controller *tController = new Controller();
  tController->GettrajectoryInterval(tReader, tWriter);

  delete tReader;
  delete tWriter;
  delete gGraph;
  delete tController;

  return 0;
}
