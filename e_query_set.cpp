#include "e_query_set.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileWriter *writer = new FileWriter(args[4], true);
  QuerySet *tQuerySet = new QuerySet(atoi(args[6]));

  int type = atoi(args[5]);

  switch (type) {
  case 1:
    tQuerySet->GetKNNSet(writer);
    break;
  case 2:
    tQuerySet->GetWhenSet(writer);
    break;
  case 3:
    tQuerySet->GetCountSet(writer);
    break;
  case 4:
    tQuerySet->GetWhereSet(writer);
    break;
  case 5:
    tQuerySet->GetWindowSet(writer);
    break;
  case 6:
    tQuerySet->GetHowlongSet(writer);
    break;
  case 7:
    tQuerySet->GetDistanceSet(writer);
    break;
  case 8:
    tQuerySet->GetDistanceSingleSet(writer);
    break;
  }

  delete gGraph;
  delete tQuerySet;
  delete writer;

  return 0;
}
