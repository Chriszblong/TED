#include "e_matrix.hpp"
#include "e_timer.hpp"
#include <iostream>
using namespace std;

int main(int argv, char **args) {

  TIME_FILE = args[3];

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  EMATRIX::mEntryNumber = atoi(args[3]);
  EMATRIX::mGroupInnerNumber = atoi(args[4]);

  FileReader *tReader = new FileReader(args[1], true);
  EMATRIX::LoadCompressedFromFile(tReader);

  delete tReader;

  EMATRIX::BasicPathDecomp();
  EMATRIX::ReSortDataSet();

  FileWriter *tWriter = new FileWriter(args[2], true);
  EMATRIX::SaveDataSetToFile(tWriter);

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete tTimer;
  delete tWriter;

  return 0;
}
