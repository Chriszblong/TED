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
  THRESHOLD_VALUE = string2double(args[8]);

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *tEdge2EntryReader = new FileReader(args[4], true);
  FileReader *tTraReader = new FileReader(args[5], false);
  FileWriter *tLCodingReader = new FileWriter(args[6], true);

  Controller *tController = new Controller();
  tController->LoadgTrajectories(tTraReader);

  gEdgeToEntry = new Edge2Entry();
  gEdgeToEntry->LoadEdge2EntryTable(tEdge2EntryReader);

  delete gEdgeToEntry;

  PLT *tPLT = new PLT();
  tPLT->LCoding();

  tLCodingReader->WriteInt(gLCodings->size());
  for (i = 0; i < gLCodings->size(); i++) {
    tLCodingReader->WriteInt(gLCodings->at(i)->size());
    for (j = 0; j < gLCodings->at(i)->size(); j++) {
      vector<bool> *tmp = new vector<bool>();
      for (k = 0; k < gLCodings->at(i)->at(j)->size(); k++) {

        tmp->push_back(gLCodings->at(i)->at(j)->at(k) & 0x01);
      }
      Binary *my = new Binary(tmp);
      my->Store(tLCodingReader);
    }
  }

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete gGraph;

  for (i = 0; i < gTrajectories->size(); i++) {
    delete gTrajectories->at(i);
  }
  for (i = 0; i < gLCodings->size(); i++) {
    for (j = 0; j < gLCodings->at(i)->size(); j++) {
      gLCodings->at(i)->at(j)->clear();
      delete gLCodings->at(i)->at(j);
    }
    gLCodings->at(i)->clear();
    delete gLCodings->at(i);
  }
  delete gLCodings;

  return 0;
}
