#ifndef __ETRAJECTORY_HPP__
#define __ETRAJECTORY_HPP__

#include "e_graphic.hpp"
#include "e_tool.hpp"
#include <iostream>
#include <string>
#include <vector>
using namespace std;

class Trajectory;

vector<Trajectory *> *gTrajectories = new vector<Trajectory *>();
long nodeNum = 0;

class traNode {
public:
  traNode() {
    this->mTime = 0;
    this->mLatitude = 0;
    this->mLongitude = 0;
    this->mEdge = 0;
  }

  traNode(int time, double latitude, double longitude, int edge) {
    this->mTime = time;
    this->mLatitude = latitude;
    this->mLongitude = longitude;
    this->mEdge = edge;
  }

  void Display() {
    cout << "<" << mTime << "," << mLatitude << "," << mLongitude << ","
         << mEdge << ">"
         << " ";
  }

  void Save2File(FileWriter *writer) {
    writer->WriteInt(mTime);
    writer->WriteDouble(mLatitude);
    writer->WriteDouble(mLongitude);
    writer->WriteInt(mEdge);
  }

  int mTime;
  double mLatitude;
  double mLongitude;
  int mEdge;
};

class Trajectory {
public:
  vector<traNode *> mTrajectory;
  int mId;

  Trajectory() { mTrajectory.clear(); }

  traNode *GetNodeById(int id) {
    if ((int)mTrajectory.size() > id) {
      return mTrajectory[id];
    }
    return NULL;
  }

  ~Trajectory() {
    for (int i = 0; i < (int)this->mTrajectory.size(); i++){
		delete this->mTrajectory[i];
		this->mTrajectory[i]=NULL;
	}
    this->mTrajectory.clear();
  }

  Trajectory(FileReader *nodereader, FileReader *edgereader) {
    mTrajectory.clear();
    LoadFromOriginFile(nodereader, edgereader);
  }

  void Push(traNode *node) { mTrajectory.push_back(node); }

  void Display() {
    cout << "Trajectory id:" << this->mId << " ";
    for (int i = 0; i < (int)mTrajectory.size(); i++) {
      mTrajectory[i]->Display();
    }
    cout << endl;
  }

  const int NodeSize() { return (int)mTrajectory.size(); }

  void LoadFromOriginFile(FileReader *nodereader, FileReader *edgereader) {
    mTrajectory.clear();
    int time, edge;
    double lat = 0, lng = 0;
    int preTime = -1;
    while ((time = nodereader->GetNextInt()) != EOF) {
      nodereader->GetNextChar();
      lat = nodereader->GetNextDouble();
      nodereader->GetNextChar();
      lng = nodereader->GetNextDouble();
      time = edgereader->GetNextInt();
      edgereader->GetNextChar();
      edge = edgereader->GetNextInt();
      edgereader->GetNextChar();
      edgereader->GetNextDouble();

      if (preTime == time)
        continue;
      if (time < preTime) {
        time = time + 24 * 3600;
      }
      traNode *tNewNode = new traNode(time, lat, lng, edge);
      if (tNewNode->mEdge == -1) {
        tNewNode->Display();
      }

      preTime = time;
      mTrajectory.push_back(tNewNode);
    }
  }

  void Save2File(FileWriter *writer) {
    writer->WriteInt(this->mId);
    writer->WriteInt((int)this->mTrajectory.size());
    for (int i = 0; i < (int)mTrajectory.size(); i++) {
      mTrajectory[i]->Save2File(writer);
    }
  }
};

class Controller {
public:
  vector<int> result;

  void LoadgTrajectories(FileReader *reader) {

    int tra_num = reader->GetNextInt();
    for (int i = 0; i < tra_num; i++) {

      Trajectory *tTrajectory = new Trajectory();
      tTrajectory->mId = reader->GetNextInt();

      int tra_size = reader->GetNextInt();
      for (int j = 0; j < tra_size; j++) {

        int time = reader->GetNextInt();
        double lat = reader->GetNextDouble();
        double lng = reader->GetNextDouble();
        int edge = reader->GetNextInt();

        traNode *node = new traNode(time, lat, lng, edge);
        tTrajectory->Push(node);
      }
      gTrajectories->push_back(tTrajectory);
    }
  }

  void ReformatTrajectory(char dirname[], FileWriter *writer, string a,
                          string b) {

    int i;

    vector<string> files;
    FileDir::GetInstance()->GetFiles(dirname, files);

    writer->WriteInt((int)files.size());
    for (i = 0; i < (int)files.size(); i++) {

      string edgename = files[i];
      size_t postime = edgename.find(a);
      edgename.replace(postime, a.length(), b);

      Trajectory *tTrajectory = new Trajectory();
      tTrajectory->mId = i;

      FileReader *nodereader = new FileReader(files[i].c_str(), false);
      FileReader *edgereader = new FileReader(edgename.c_str(), false);

      tTrajectory->LoadFromOriginFile(nodereader, edgereader);
      tTrajectory->Save2File(writer);

      delete nodereader;
      delete edgereader;
      delete tTrajectory;
    }
  }

  int GetLen(int pre, int aim, string nextfile) {

    vector<int> tmp;
    vector<int> edges;

    int a = gGraph->GetEdgeById(pre)->GetEndNode()->GetId();
    int b = gGraph->GetEdgeById(aim)->GetStartNode()->GetId();
    int c, d;

    while (a != b) {

      c = GetNextChar(a, b, nextfile, gGraph->GetNodeNumber() + 2);

      if (c == 8) {
        return -1;
      }

      d = gGraph->GetNodeById(a)->GetOutEdges().at(c - 1)->GetId();
      a = gGraph->GetEdgeById(d)->GetEndNode()->GetId();
      tmp.push_back(d);
    }
    if (a == b) {
      for (int i = 0; i < (int)gGraph->GetNodeById(a)->GetOutEdges().size();
           i++) {
        d = gGraph->GetNodeById(a)->GetOutEdges().at(i)->GetId();
        if (d == aim) {
          tmp.push_back(d);
          this->result = tmp;
        }
      }
    }
    return 1;
  }

  void GetConnectedTrajectories(FileReader *reader, FileWriter *writer) {

    int i, j;
    int tmp;

    Trajectory *tTrajectory = new Trajectory();
    LoadgTrajectories(reader);
    result.clear();

    writer->WriteInt((int)gTrajectories->size());
    for (i = 0; i < (int)gTrajectories->size(); i++) {

      tTrajectory->mTrajectory.clear();
      tTrajectory->mId = gTrajectories->at(i)->mId;
      int startEdge = gTrajectories->at(i)->GetNodeById(0)->mEdge;
      tTrajectory->mTrajectory.push_back(gTrajectories->at(i)->GetNodeById(0));

      for (j = 1; j < gTrajectories->at(i)->NodeSize(); j++) {

        if (gTrajectories->at(i)->GetNodeById(j)->mEdge == startEdge) {
          tTrajectory->Push(gTrajectories->at(i)->GetNodeById(j));
          this->result.clear();
          continue;
        }

        tmp = GetLen(startEdge, gTrajectories->at(i)->GetNodeById(j)->mEdge,
                     NEXT_PATH);
        if (tmp == 1) {
          int l;
          for (l = 0; l < (int)this->result.size() - 1; l++)
            tTrajectory->Push(new traNode(-1, -1, -1, this->result.at(l)));
          tTrajectory->Push(gTrajectories->at(i)->GetNodeById(j));
          this->result.clear();
          startEdge = gTrajectories->at(i)->GetNodeById(j)->mEdge;
        } else if (tmp == -1) {
          tTrajectory->Save2File(writer);
          break;
        }
      }

      if (j == gTrajectories->at(i)->NodeSize()) {
        tTrajectory->Save2File(writer);
      }
    }
  }

  void GetTrajectoryInterval(FileReader *reader, FileWriter *writer) {

    int i;

    LoadgTrajectories(reader);

    writer->WriteInt((int)gTrajectories->size());
    for (i = 0; i < (int)gTrajectories->size(); i++) {

      writer->WriteInt(gTrajectories->at(i)->mTrajectory[0]->mTime);
      writer->WriteInt(
          gGraph->GetEdgeById(gTrajectories->at(i)->GetNodeById(0)->mEdge)
              ->GetStartNode()
              ->GetId());
      writer->WriteDouble(
          (gTrajectories->at(i)
               ->mTrajectory[gTrajectories->at(i)->NodeSize() - 1]
               ->mTime -
           gTrajectories->at(i)->mTrajectory[0]->mTime) *
          1.0 / (gTrajectories->at(i)->NodeSize() - 1));
    }

  }
};

#endif
