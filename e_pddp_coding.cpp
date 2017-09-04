#include "e_header.h"
#include "e_pddp.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  int i, j, k;

  FileReader *tPDDPIndexReader = new FileReader(args[1], true);
  FileReader *tLCodingsReader = new FileReader(args[2], true);
  FileWriter *tPDDPCodingWriter = new FileWriter(args[3], true);

  TIME_FILE = args[4];

  gPDDPIndex = new PDDPIndex();
  gPDDPIndex->LoadIndex(tPDDPIndexReader);

  delete tPDDPIndexReader;

  int ttraNum = tLCodingsReader->GetNextInt();
  for (i = 0; i < ttraNum; i++) {
    int tTraSize = tLCodingsReader->GetNextInt();
    vector<vector<unsigned char> *> *tra =
        new vector<vector<unsigned char> *>();
    for (j = 0; j < tTraSize; j++) {
      Binary *tm = new Binary(tLCodingsReader);
      vector<unsigned char> *tmp = new vector<unsigned char>();

      for (k = 0; k < tm->mNumber; k++) {
        tmp->push_back(tm->mBinary->at(k));
      }
      tra->push_back(tmp);
    }
    gLCodings->push_back(tra);
  }

  delete tLCodingsReader;

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  gPDDPIndex->GetPDDPCoding();

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete tTimer;

  tPDDPCodingWriter->WriteInt(gPDDPCodings->size());

  for (i = 0; i < gPDDPCodings->size(); i++) {
    vector<bool> *tr = new vector<bool>();
    for (j = 0; j < gPDDPCodings->at(i)->size(); j++) {
      for (k = 0; k < gPDDPCodings->at(i)->at(j)->size(); k++) {
        tr->push_back(gPDDPCodings->at(i)->at(j)->at(k));
      }
    }
    Binary *re = new Binary(tr);
    re->Store(tPDDPCodingWriter);
    delete re;
  }

  delete tPDDPCodingWriter;
  delete gPDDPIndex;

  for (i = 0; i < gLCodings->size(); i++) {
    delete gLCodings->at(i);
  }
  delete gLCodings;

  for (i = 0; i < gPDDPCodings->size(); i++) {
    delete gPDDPCodings->at(i);
  }
  delete gPDDPCodings;

  return 0;
}
