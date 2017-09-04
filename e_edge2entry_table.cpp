#include "e_header.h"
#include "e_edge2entry.hpp"
#include "e_graphic.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include <iostream>
#include <string.h>
using namespace std;

int main(int argv, char *args[]) {

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileWriter *tWriter = new FileWriter(args[4], true);

  gEdgeToEntry = new Edge2Entry();
  gEdgeToEntry->CreateEdge2EntryTable(tWriter);

  delete gEdgeToEntry;

  delete tWriter;
  delete gGraph;

  return 0;
}
