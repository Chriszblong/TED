#include "e_header.h"
#include "e_huffman.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  int i, j, k;

  FileReader *reader1 = new FileReader(args[1], true);
  FileReader *reader2 = new FileReader(args[2], true);
  FileWriter *writer = new FileWriter(args[3], true);

  TIME_FILE = args[4];

  gHuffman = new Huffman();
  gHuffman->LoadHuffmanIndex(reader1);

  delete reader1;

  int ttraNum = reader2->GetNextInt();
  for (i = 0; i < ttraNum; i++) {
    int tTraSize = reader2->GetNextInt();
    vector<vector<unsigned char> *> *tra =
        new vector<vector<unsigned char> *>();
    for (j = 0; j < tTraSize; j++) {
      Binary *tm = new Binary(reader2);
      vector<unsigned char> *tmp = BoolToChar(tm->mBinary);
      tra->push_back(tmp);
    }
    gLCodings->push_back(tra);
  }

  delete reader2;

  Timer *tTimer = new Timer();
  tTimer->ResetStart();

  gHuffman->HuffmanCoding();

  tTimer->ResetFinish();
  tTimer->Write2File();

  delete tTimer;

  writer->WriteInt(gHuffmanCodings->size());

  for (i = 0; i < gHuffmanCodings->size(); i++) {
    vector<bool> *tr = new vector<bool>();
    for (j = 0; j < gHuffmanCodings->at(i)->size(); j++) {
      for (k = 0; k < gHuffmanCodings->at(i)->at(j)->size(); k++) {
        tr->push_back(gHuffmanCodings->at(i)->at(j)->at(k));
      }
    }
    Binary *re = new Binary(tr);
    re->Store(writer);
    delete re;
  }

  delete writer;
  delete gHuffman;

  for (i = 0; i < gLCodings->size(); i++) {
    delete gLCodings->at(i);
  }
  delete gLCodings;

  for (i = 0; i < gHuffmanCodings->size(); i++) {
    delete gHuffmanCodings->at(i);
  }
  delete gPDDPCodings;

  return 0;
}
