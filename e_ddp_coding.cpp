#include "e_header.h"
#include "e_pddp.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  int i, j, k;

  FileReader *tPDDPIndexReader = new FileReader(args[1], true);
  FileReader *tLcodingReader = new FileReader(args[2], true);
  FileWriter *tDDPcodingWriter = new FileWriter(args[3], true);

  TIME_FILE = args[4];

  gPDDPIndex = new PDDPIndex();
  gPDDPIndex->LoadIndex(tPDDPIndexReader);

  delete tPDDPIndexReader;

  int ttraNum = tLcodingReader->GetNextInt();
  for (i = 0; i < ttraNum; i++) {
    int tTraSize = tLcodingReader->GetNextInt();

    vector<vector<unsigned char> *> *tra =
        new vector<vector<unsigned char> *>();

    for (j = 0; j < tTraSize; j++) {
      Binary *tm = new Binary(tLcodingReader);
      vector<unsigned char> *tmp = new vector<unsigned char>();

      for (k = 0; k < tm->mNumber; k++) {
        tmp->push_back(tm->mBinary->at(k));
      }

      delete tm;
      tra->push_back(tmp);
    }

    gLCodings->push_back(tra);
  }

  delete tLcodingReader;

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  gPDDPIndex->GetDDPCoding();

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete tTimer;

  tDDPcodingWriter->WriteInt(gDDPCodings->size());
  for (i = 0; i < gDDPCodings->size(); i++) {
    vector<bool> *tr = new vector<bool>();
    for (j = 0; j < gDDPCodings->at(i)->size(); j++) {
      for (k = 0; k < gDDPCodings->at(i)->at(j)->size(); k++) {
        tr->push_back(gDDPCodings->at(i)->at(j)->at(k));
      }
    }
    Binary *re = new Binary(tr);
    re->Store(tDDPcodingWriter);
    delete re;
  }

  delete tDDPcodingWriter;
  delete gPDDPIndex;

  for (i = 0; i < gLCodings->size(); i++) {
    delete gLCodings->at(i);
  }
  delete gLCodings;

  for (i = 0; i < gDDPCodings->size(); i++) {
    delete gDDPCodings->at(i);
  }
  delete gDDPCodings;

  return 0;
}
