#include "e_matrix.hpp"

#include <iostream>
using namespace std;

int main() {

  FileReader *tReader = new FileReader("/home/yangkai/beijing_20.txt", true);
  EMATRIX::mGroupInnerNumber = 3;
  EMATRIX::mEntryNumber = 3;
  EMATRIX::LoadDataSetFromFile(tReader);

  delete tReader;

  /*
  int i, j;

  EMATRIX::mGroupInnerNumber = 3;
  EMATRIX::mEntryNumber = 3;

  for (i = 0; i < 10; i++) {
    EMATRIX::mDataMatrix.push_back(new vector<bool>());
    EMATRIX::mResultMatrixContent.push_back(new vector<bool>());
    if (i % EMATRIX::mGroupInnerNumber == 0) {
      EMATRIX::mResultMatrixHeader.push_back(new vector<bool>());
    }

    EMATRIX::mOrder.push_back(i);
    int ii = 3 * (rand() % 5 + 5);
    // cout << ii << endl;
    for (j = 0; j < ii; j++) {
      int tmpBool = rand() % 2;
      EMATRIX::mDataMatrix[i]->push_back(tmpBool);
    }
  }
  */

  EMATRIX::PrintDataSet();
  EMATRIX::SortDataSet();
  EMATRIX::PrintDataSet();
  EMATRIX::BasicPathComp();
  // EMATRIX::PrintCompressed();
  FileWriter *writer = new FileWriter("/home/yangkai/test.dat", true);
  EMATRIX::SaveCompressedToFile(writer);
  delete writer;

  EMATRIX::Clear();
  EMATRIX::mEntryNumber = 3;
  EMATRIX::mGroupInnerNumber = 3;

  FileReader *reader = new FileReader("/home/yangkai/test.dat", true);
  EMATRIX::LoadCompressedFromFile(reader);

  // EMATRIX::PrintCompressed();
  EMATRIX::BasicPathDecomp();

  EMATRIX::SortCompressed();
  EMATRIX::PrintDataSet();
  EMATRIX::SaveDataSetToFile(new FileWriter("/home/yangkai/main.dat", true));

  return 0;
}
