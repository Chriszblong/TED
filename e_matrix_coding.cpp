#include "e_matrix.hpp"
#include "e_timer.hpp"
#include <iostream>
using namespace std;

int main(int argv, char **args) {

  TIME_FILE = args[3];

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  EMATRIX::mGroupInnerNumber = atoi(args[5]);
  EMATRIX::mEntryNumber = atoi(args[4]);

  FileReader *tReader = new FileReader(args[1], true);
  EMATRIX::LoadDataSetFromFile(tReader);

  delete tReader;

  EMATRIX::SortDataSet();
  EMATRIX::BasicPathComp();

  FileWriter *tWriter = new FileWriter(args[2], true);
  EMATRIX::SaveCompressedToFile(tWriter);

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete tTimer;
  delete tWriter;

  return 0;
}
