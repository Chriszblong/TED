#include "e_header.h"
#include "e_graphic.hpp"
#include "e_plt.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include "e_trajectory.hpp"
#include <iostream>
#include <string.h>
using namespace std;

int main(int argv, char *args[]) {

  int i, j, k;

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];
  TIME_FILE = args[7];

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *tEdgeToEntryReader = new FileReader(args[4], true);
  FileReader *tTraReader = new FileReader(args[5], false);
  FileWriter *tWriter = new FileWriter(args[6], true);

  Controller *tController = new Controller();
  tController->LoadgTrajectories(tTraReader);

  gEdgeToEntry = new Edge2Entry();
  gEdgeToEntry->LoadEdge2EntryTable(tEdgeToEntryReader);

  delete gEdgeToEntry;

  delete tEdgeToEntryReader;
  delete tTraReader;

  PLT *tPLT = new PLT();
  tPLT->TCoding();

  tWriter->WriteInt(gTrajectories->size());
  for (i = 0; i < gTrajectories->size(); i++) {

    vector<bool> *tTmpVector = new vector<bool>();
    for (j = 0; j < gTCodings->at(i)->size(); j++) {
      tTmpVector->push_back(gTCodings->at(i)->at(j) & 0x01);
    }

    Binary *binary = new Binary(tTmpVector);
    binary->Store(tWriter);
    delete binary;
  }

  delete tWriter;

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete tTimer;

  delete gGraph;

  for (i = 0; i < gTCodings->size(); i++) {
    gTCodings->at(i)->clear();
    delete gTCodings->at(i);
  }

  for (i = 0; i < gTrajectories->size(); i++) {
    delete gTrajectories->at(i);
  }

  return 0;
}
