#include "e_decompress.hpp"
#include "e_pddp.hpp"
#include "e_timer.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  NODE_PATH = args[1];
  EDGE_PATH = args[2];
  GEO_PATH = args[3];
  TIME_FILE = args[9];

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *tPDDPReader = new FileReader(args[4], true);
  gPDDPIndex = new PDDPIndex();
  gPDDPIndex->LoadIndexQ(tPDDPReader);

  delete tPDDPReader;


Timer *tTimer = new Timer();
  tTimer->ResetStart();
  LoadCompressedgTrajectories(args[5], args[6], args[7], args[8]);

  DeCompress *tDecompress = new DeCompress();

  

  FileWriter *writer = new FileWriter(args[10], false);

  ENTRY_NUM = atoi(args[11]);

  tDecompress->deCompress(writer);

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete gPDDPIndex;
  delete tDecompress;
  delete writer;
  delete gGraph;
  delete tTimer;

  return 0;
}
