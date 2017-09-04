#include "e_header.h"
#include "e_graphic.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include "e_trajectory.hpp"
#include <iostream>
#include <string>
using namespace std;

int main(int argv, char *args[]) {

  int i;

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];
  NEXT_PATH = args[4];
  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *tReader = new FileReader(args[5], false);
  FileWriter *tWriter = new FileWriter(args[6], false);
  Controller *tController = new Controller();
  tController->GetConnectedTrajectories(tReader, tWriter);

  delete tReader;
  delete tWriter;
  delete tController;
  delete gGraph;

  
  for (i = 0; i < (int)gTrajectories->size(); i++) {
    delete gTrajectories->at(i);
	gTrajectories->at(i)=NULL;
  }
  delete gTrajectories;
  gTrajectories=NULL;  

  return 0;
}
