#ifndef __EEDGETOENTRY_HPP__
#define __EEDGETOENTRY_HPP__

#include "e_graphic.hpp"

vector<unsigned char> *gEdgeToEntryTable = new vector<unsigned char>();

class Edge2Entry {
public:
  ~Edge2Entry() {}

  static void CreateEdge2EntryTable(FileWriter *writer) {

    writer->WriteInt(gGraph->GetEdgeNumber());
    for (int i = 0; i < gGraph->GetEdgeNumber(); i++) {

      Edge *tmpEdge = gGraph->GetEdgeById(i);
      Node *tmpNode = tmpEdge->GetStartNode();

      for (int j = 0; j < tmpNode->GetEdgeNumber(); j++) {

        if (tmpNode->GetOutEdgeById(j)->GetId() == i) {
          writer->WriteChar(j + '0');
          break;
        }
      }
    }
  }

  static void LoadEdge2EntryTable(FileReader *reader) {

    int number = reader->GetNextInt();

    for (int i = 0; i < number; i++) {

      gEdgeToEntryTable->push_back(reader->GetNextChar() - '0');
    }
  }
};

Edge2Entry *gEdgeToEntry = NULL;

#endif
