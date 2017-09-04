#include "e_query.hpp"
#include "e_timer.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {
  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];
  gGraph = new Graphic();
  gGraph->InitGraphic();
  Query *query = new Query();
  LoadCompressedgTrajectories(args[4], args[5], args[6], args[7]);
  TIME_FILE = args[8];
  int pos;
  if (strstr(args[4], "beijing") != NULL) {
    pos = 20;
  } else {
    pos = 20;
  }
  Timer *timer = new Timer();
  timer->ResetStart();
  query->LtoT(pos);
  timer->ResetFinish();
  timer->Write2File();
  return 0;
}
