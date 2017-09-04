#include "e_tool.hpp"
#include <iostream>
#include <vector>
using namespace std;

int main(int argv, char **args) {

  int i;
  vector<string> tFiles;

  FILE *tWriter = fopen(args[1], "w");

  FileDir::GetFiles(args[2], tFiles);

  for (i = 0; i < tFiles.size(); i++) {

    FileReader *tReader = new FileReader(tFiles[i].c_str(), false);

    for (int j = 0; j < 5; j++) {
      tReader->GetNextString();
    }
    tReader->GetNextChar();

    double tValue = tReader->GetNextDouble();
    fprintf(tWriter, "%-80s%lf\n", tFiles[i].c_str(), tValue);

    delete tReader;
  }

  fclose(tWriter);

  return 0;
}
