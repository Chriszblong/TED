#ifndef __EPARTITION_HPP__
#define __EPARTITION_HPP__

#include "e_graphic.hpp"
#include "e_header.h"
#include "e_trajectory.hpp"

const int INIT_PART_NUM = 6;

struct PAIR_NODE {
  int mPtr;
  int mName;
  int mEdge;
  int mOrder;
  double mDistance;
  int mLen;
};

vector<PAIR_NODE> gGrid;

Node gLL, gUR;
int gNPart;

class Partion {
public:
  Partion() { gNPart = INIT_PART_NUM; }
  int Convert2int(Node *p) {
    int tGridNum = pow(4, gNPart);
    int lineNum = sqrt(tGridNum);
    double latWidth = (gUR.GetLatitude() - gLL.GetLatitude()) / lineNum;
    double lngWidth = (gUR.GetLongitude() - gLL.GetLongitude()) / lineNum;
    return lineNum * (p->GetLatitude() - gLL.GetLatitude()) / latWidth +
           (p->GetLongitude() - gLL.GetLongitude()) / lngWidth;
  }
  void CreatePartion() {

    gLL.SetLatitude(10000);
    gLL.SetLongitude(10000);
    gUR.SetLatitude(-10000);
    gUR.SetLongitude(-10000);

    if (DIVID_NUM == -1) {
      gNPart = INIT_PART_NUM;
    } else {
      gNPart = DIVID_NUM;
    }
    // gNPart :  The depth of partion

    for (int i = 0; i < gGraph->GetNodeNumber(); i++) {
      if (gLL.GetLatitude() > gGraph->GetNodeById(i)->GetLatitude())
        gLL.SetLatitude(gGraph->GetNodeById(i)->GetLatitude());
      if (gLL.GetLongitude() > gGraph->GetNodeById(i)->GetLongitude())
        gLL.SetLongitude(gGraph->GetNodeById(i)->GetLongitude());
      if (gUR.GetLatitude() < gGraph->GetNodeById(i)->GetLatitude())
        gUR.SetLatitude(gGraph->GetNodeById(i)->GetLatitude());
      if (gUR.GetLongitude() < gGraph->GetNodeById(i)->GetLongitude())
        gUR.SetLongitude(gGraph->GetNodeById(i)->GetLongitude());
    }

    for (int i = 0; i <= pow(4, gNPart); i++) {
      PAIR_NODE node = {i, -1, -1, 0, 0.0, 0};
      gGrid.push_back(node);
    }
  }
  void loadPartion() {

    gLL.SetLatitude(10000);
    gLL.SetLongitude(10000);
    gUR.SetLatitude(-10000);
    gUR.SetLongitude(-10000);

    if (DIVID_NUM == -1) {
      gNPart = 4;
    } else {
      gNPart = DIVID_NUM;
    }

    // gNPart :  The depth of partion
    for (int i = 0; i < gGraph->GetNodeNumber(); i++) {
      if (gLL.GetLatitude() > gGraph->GetNodeById(i)->GetLatitude())
        gLL.SetLatitude(gGraph->GetNodeById(i)->GetLatitude());
      if (gLL.GetLongitude() > gGraph->GetNodeById(i)->GetLongitude())
        gLL.SetLongitude(gGraph->GetNodeById(i)->GetLongitude());
      if (gUR.GetLatitude() < gGraph->GetNodeById(i)->GetLatitude())
        gUR.SetLatitude(gGraph->GetNodeById(i)->GetLatitude());
      if (gUR.GetLongitude() < gGraph->GetNodeById(i)->GetLongitude())
        gUR.SetLongitude(gGraph->GetNodeById(i)->GetLongitude());
    }
  }
  void MakeIndex(int name, int pos) {

    int i;
    double total_distance = 0;
    int ppre = -1;
    int qqq, b, pre = -1;
    int part;
    double c;
    for (i = 0; i < gTrajectories->at(pos)->NodeSize(); i++) {

      b = gTrajectories->at(pos)->GetNodeById(i)->mEdge;

      if (pre != b) {
        total_distance += gGraph->GetEdgeById(b)->GetLength();
      }
      pre = b;
      part = Convert2int(gGraph->GetEdgeById(b)->GetStartNode());

      if (ppre == part) {
        continue;
      }
      if (gGrid[gGrid.size() - 1].mName == name) {
        gGrid[gGrid.size() - 1].mLen = i - gGrid[gGrid.size() - 1].mOrder;
      }

      int prev = gGrid[part].mPtr;
      PAIR_NODE tNewNode;
      tNewNode.mPtr = prev;
      tNewNode.mName = name;
      tNewNode.mOrder = i;
      tNewNode.mEdge = gGraph->GetEdgeById(b)->GetStartNode()->GetId();
      tNewNode.mDistance = total_distance;
      tNewNode.mLen = 1;

      gGrid.push_back(tNewNode);
      gGrid[part].mPtr = gGrid.size() - 1;

      ppre = part;
    }
  }
  void Save2File(FileWriter *writer) {
    writer->WriteInt(gGrid.size());
    for (int i = 0; i < gGrid.size(); i++) {
      writer->WriteInt(gGrid.at(i).mPtr);
      writer->WriteInt(gGrid.at(i).mName);
      writer->WriteInt(gGrid.at(i).mEdge);
      writer->WriteInt(gGrid.at(i).mOrder);
      writer->WriteDouble(gGrid.at(i).mDistance);
      writer->WriteInt(gGrid.at(i).mLen);
    }
  }
  void LoadPartionIndex(FileReader *reader) {
    gGrid.clear();
    int indexSize = reader->GetNextInt();
    for (int i = 0; i < indexSize; i++) {
      PAIR_NODE tmp;
      tmp.mPtr = reader->GetNextInt();
      tmp.mName = reader->GetNextInt();
      tmp.mEdge = reader->GetNextInt();
      tmp.mOrder = reader->GetNextInt();
      tmp.mDistance = reader->GetNextDouble();
      tmp.mLen = reader->GetNextInt();
      gGrid.push_back(tmp);
    }
  }
};

Partion *gPartionIndex = NULL;

#endif
