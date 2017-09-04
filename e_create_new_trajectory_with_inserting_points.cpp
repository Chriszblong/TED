#include "e_graphic.hpp"
#include "e_tool.hpp"
#include "e_trajectory.hpp"
#include <iostream>
#include <vector>
using namespace std;

vector<Trajectory *> *gInsertTrajectories = new vector<Trajectory *>();

int main(int argv, char **args) {

  int i, j, k, p;
  int tInsertPointNumber = atoi(args[1]);

  NODE_PATH = args[2];
  EDGE_PATH = args[3];
  GEO_PATH = args[4];

  gGraph = new Graphic();
  gGraph->InitGraphic();

  FileReader *reader2 = new FileReader(args[5], false);
  FileWriter *writer = new FileWriter(args[6], false);
  FileWriter *formatWriter = new FileWriter(args[7], false);

  Controller *tController = new Controller();
  tController->LoadgTrajectories(reader2);

  delete reader2;

  for (i = 0; i < gTrajectories->size(); i++) {

    Trajectory *tTmpTra = new Trajectory();

    vector<int> preEdges;
    tTmpTra->mTrajectory.push_back(gTrajectories->at(i)->mTrajectory[0]);
    preEdges.push_back(gTrajectories->at(i)->mTrajectory[0]->mEdge);
    traNode *preNode = gTrajectories->at(i)->mTrajectory[0];

    for (j = 1; j < gTrajectories->at(i)->NodeSize(); j++) {
      preEdges.push_back(gTrajectories->at(i)->mTrajectory[j]->mEdge);

      if (gTrajectories->at(i)->mTrajectory[j]->mTime != -1) {
        traNode *tmpNode = gTrajectories->at(i)->mTrajectory[j];

        for (k = 1; k <= tInsertPointNumber; k++) {
          double ratio = k * 1.0 / (tInsertPointNumber + 1);
          int tPos = (int)preEdges.size() * k / (tInsertPointNumber + 1);
          for (p = (int)preEdges.size() * (k - 1) / (tInsertPointNumber + 1);
               p < (int)preEdges.size() * k / (tInsertPointNumber + 1) - 1;
               p++) {
            if (preNode->mEdge != preEdges[p]) {
              tTmpTra->mTrajectory.push_back(
                  new traNode(-1, -1, -1, preEdges[p]));
            }
          }
          tTmpTra->mTrajectory.push_back(new traNode(
              preNode->mTime + ratio * (tmpNode->mTime - preNode->mTime),
              preNode->mLatitude +
                  ratio * (tmpNode->mLatitude - preNode->mLatitude),
              preNode->mLongitude +
                  ratio * (tmpNode->mLongitude - preNode->mLongitude),
              preEdges[p]));
        }
        for (p = p + 1; p < (int)preEdges.size() - 1; p++) {
          if (tmpNode->mEdge != preEdges[p]) {
            tTmpTra->mTrajectory.push_back(
                new traNode(-1, -1, -1, preEdges[p]));
          }
        }
        tTmpTra->mTrajectory.push_back(tmpNode);
        preEdges.clear();
        preEdges.push_back(tmpNode->mEdge);

        preNode = tmpNode;
      }
    }

    tTmpTra->mId = gTrajectories->at(i)->mId;
    gInsertTrajectories->push_back(tTmpTra);
  }

  writer->WriteInt(gInsertTrajectories->size());
  formatWriter->WriteInt(gInsertTrajectories->size());

  for (i = 0; i < gInsertTrajectories->size(); i++) {
    gInsertTrajectories->at(i)->Save2File(writer);

    Trajectory *tmp = gInsertTrajectories->at(i);
    int writeSize = 0;
    for (j = 0; j < (int)tmp->mTrajectory.size(); j++) {
      if (tmp->mTrajectory[j]->mTime != -1) {
        writeSize++;
      }
    }
    formatWriter->WriteInt(tmp->mId);
    formatWriter->WriteInt(writeSize);

    for (j = 0; j < (int)tmp->mTrajectory.size(); j++) {
      if (tmp->mTrajectory[j]->mTime != -1) {
        formatWriter->WriteInt(tmp->mTrajectory[j]->mTime);
        formatWriter->WriteDouble(tmp->mTrajectory[j]->mLatitude);
        formatWriter->WriteDouble(tmp->mTrajectory[j]->mLongitude);
        formatWriter->WriteInt(tmp->mTrajectory[j]->mEdge);
      }
    }
  }

  delete writer;
  delete formatWriter;

  /*
  for (i = 0; i < (int)gInsertTrajectories->size(); i++) {
    delete gInsertTrajectories->at(i);
  }
  delete gInsertTrajectories;

  for (i = 0; i < (int)gTrajectories->size(); i++) {
    delete gTrajectories->at(i);
  }
  delete gTrajectories;
  */

  return 0;
}
