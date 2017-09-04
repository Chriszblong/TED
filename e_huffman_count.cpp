#include "e_header.h"
#include "e_huffman.hpp"
#include "e_tool.hpp"
#include <iostream>
using namespace std;

int main(int argv, char *args[]) {

  FileReader *tReader = new FileReader(args[1], true);
  FileWriter *tWriter = new FileWriter(args[2], true);

  gHuffman = new Huffman();
  gHuffman->CountHuffman(tReader, tWriter);

  delete tReader;
  delete tWriter;
  delete gHuffman;

  return 0;
}
