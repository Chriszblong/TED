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
  ENTRY_NUM = atoi(args[8]);

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *tEdge2EntryReader = new FileReader(args[4], true);
  FileReader *tTraReader = new FileReader(args[5], false);
  FileWriter *tPCodingReader = new FileWriter(args[6], true);

  Controller *tController = new Controller();
  tController->LoadgTrajectories(tTraReader);

  delete tTraReader;

  gEdgeToEntry = new Edge2Entry();
  gEdgeToEntry->LoadEdge2EntryTable(tEdge2EntryReader);

  delete gEdgeToEntry;

  PLT *tPLT = new PLT();
  tPLT->PCoding();

  delete tPLT;

  tPCodingReader->WriteInt(gTrajectories->size());
  for (i = 0; i < gTrajectories->size(); i++) {

    vector<bool> *tmp = new vector<bool>();
    for (j = 0; j < gPCodings->at(i)->size(); j++) {

      switch (ENTRY_NUM) {
      case 4:
        /* The entry num is between 8 to 15 */
        tmp->push_back(gPCodings->at(i)->at(j) & 0x08);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x04);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x02);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x01);
        break;
      case 5:
        /* The entry num is between 16 to 31 */
        tmp->push_back(gPCodings->at(i)->at(j) & 0x10);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x08);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x04);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x02);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x01);
        break;
      case 3:
      /* The entry num is less than 8 */
      default:
        tmp->push_back(gPCodings->at(i)->at(j) & 0x04);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x02);
        tmp->push_back(gPCodings->at(i)->at(j) & 0x01);
        break;
      }
    }
    Binary *binary = new Binary(tmp);
    binary->Store(tPCodingReader);
    delete tmp;
  }

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete gGraph;

  for (i = 0; i < gPCodings->size(); i++) {
    delete gPCodings->at(i);
  }
  delete gPCodings;

  for (i = 0; i < gTrajectories->size(); i++) {
    delete gTrajectories->at(i);
  }
  delete gTrajectories;

  return 0;
}
