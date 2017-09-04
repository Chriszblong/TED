#include "e_query.hpp"
#include "e_timer.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  int i, j;

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *tPDDPReader = new FileReader(args[4], true);
  FileReader *tPartionReader = new FileReader(args[5], true);

  Query *tQuery = new Query(tPDDPReader, tPartionReader);

  ENTRY_NUM = atoi(args[13]);

  LoadCompressedgTrajectoriesQ(args[6], args[7], args[8], args[9]);

  delete tPDDPReader;
  delete tPartionReader;

  FileReader *tQueryReader = new FileReader(args[12], true);

  TIME_FILE = args[10];
  DIVID_NUM = atoi(args[11]);

  vector<double> querySetlat1;
  vector<double> querySetlat2;
  vector<double> querySetlng1;
  vector<double> querySetlng2;

  int tSetSize = tQueryReader->GetNextInt();
  for (i = 0; i < tSetSize; i++) {

    double a = tQueryReader->GetNextDouble();
    double b = tQueryReader->GetNextDouble();
    double c = tQueryReader->GetNextDouble();
    double d = tQueryReader->GetNextDouble();
    querySetlat1.push_back(a);
    querySetlng1.push_back(b);
    querySetlat2.push_back(c);
    querySetlng2.push_back(d);
  }

  delete tQueryReader;

  gMeetQueryNumber = 0;

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  for (j = 0; j < tSetSize; j++) {
    // cout<<"Query "<<j<<":"<<endl;
    tQuery->Count(querySetlat1[j], querySetlng1[j], querySetlat2[j],
                  querySetlng2[j]);
  }

  tTimer->ResetFinish();
  double tMeetResult =
      ((double)gMeetQueryNumber / ((int)gCTrajectoriesQ->size() * tSetSize)) *
      tSetSize;
  tTimer->Write2File(tMeetResult > 0 ? tMeetResult : 1);

  delete gGraph;
  delete tQuery;
  delete tTimer;

  for (i = 0; i < gCTrajectoriesQ->size(); i++) {
    delete gCTrajectoriesQ->at(i);
  }
  delete gCTrajectoriesQ;

  return 0;
}
