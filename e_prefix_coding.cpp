#include "e_header.h"
#include "e_prefix.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include <iostream>
#include <string>
#include <vector>
using namespace std;

int main(int argv, char *args[]) {

  int i, j, k;

  FileReader *tLCodingsReader = new FileReader(args[1], true);
  FileWriter *tPrefixCodingsWriter = new FileWriter(args[2], true);

  TIME_FILE = args[3];

  gPrefix = new Prefix();

  int tTraNum = tLCodingsReader->GetNextInt();
  for (i = 0; i < tTraNum; i++) {

    int tTraSize = tLCodingsReader->GetNextInt();
    vector<vector<unsigned char> *> *tTmpTra =
        new vector<vector<unsigned char> *>();

    for (j = 0; j < tTraSize; j++) {

      Binary *tm = new Binary(tLCodingsReader);
      vector<unsigned char> *tTmpLcoding = new vector<unsigned char>();

      for (k = 0; k < tm->mNumber; k++) {
        tTmpLcoding->push_back(tm->mBinary->at(k));
      }

      tTmpTra->push_back(tTmpLcoding);
    }
    gLCodings->push_back(tTmpTra);
  }

  delete tLCodingsReader;

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  gPrefix->PrefixCoding();

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete gPrefix;
  delete tTimer;

  tPrefixCodingsWriter->WriteInt(gPrefixCodings->size());
  for (i = 0; i < gPrefixCodings->size(); i++) {
    vector<bool> *tr = new vector<bool>();
    for (j = 0; j < gPrefixCodings->at(i)->size(); j++) {
      for (k = 0; k < gPrefixCodings->at(i)->at(j)->size(); k++) {
        tr->push_back(gPrefixCodings->at(i)->at(j)->at(k));
      }
    }
    Binary *re = new Binary(tr);
    re->Store(tPrefixCodingsWriter);
    delete re;
  }

  delete tPrefixCodingsWriter;

  for (i = 0; i < gLCodings->size(); i++) {
    delete gLCodings->at(i);
  }
  delete gLCodings;

  for (i = 0; i < gPrefixCodings->size(); i++) {
    delete gPrefixCodings->at(i);
  }
  delete gPrefixCodings;

  return 0;
}
