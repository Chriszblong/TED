#ifndef __EPLT_HPP__
#define __EPLT_HPP__

#include "e_edge2entry.hpp"
#include "e_graphic.hpp"
#include "e_pddp.hpp"
#include "e_tool.hpp"
#include "e_trajectory.hpp"
#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>
using namespace std;

#define DBL_MAX 999999999

vector<vector<unsigned char> *> *gPCodings =
    new vector<vector<unsigned char> *>();

vector<vector<unsigned char> *> *gTCodings =
    new vector<vector<unsigned char> *>();

#ifndef __GLCODINGS__
#define __GLCODINGS__
vector<vector<vector<unsigned char> *> *> *gLCodings =
    new vector<vector<vector<unsigned char> *> *>();
#endif

vector<vector<unsigned char> *> *nulls = new vector<vector<unsigned char> *>();

class PLT {
public:
  static string alphabet;
  string result;
  PLT() { result = ""; }
  PLT(FileReader *fr) {
    result = "";
    LoadFromFile(fr);
  }
  void LoadFromFile(FileReader *fr) {}
  void Save2File(FileWriter *writer) {}
  vector<unsigned char> *location_encoding(double distance, double ratio) {
    double aim = distance * ratio;
    vector<unsigned char> *result = new vector<unsigned char>();
    int du = 1;
    double tmp = 0;
    double t_ratio = 0;
    double t_distance = 0;
    while (ratio > 0) {
      tmp = pow(0.5, du);
      if (ratio >= tmp) {
        ratio -= tmp;
        result->push_back(1);
        t_ratio += tmp;
        t_distance += distance * tmp;
      } else {
        result->push_back(0);
      }
      if (abs(t_distance - aim) < THRESHOLD_VALUE) {
        break;
      }
      du++;
    }
    if (result->size() > 0)
      return result;
    else {
      result->push_back(0);
      return result;
    }
  }

  double getDistanceToStart(vector<Node *> nodes, Node *node, double &latitude,
                            double &longitude) {
    double result = DBL_MAX;
    double total_distance = 0;
    double tmp_distance = 0;
    int po = 0;
    for (int i = 1; i < nodes.size(); i++) {
      double tmp = getDistanceFromPointToSegment(
          nodes[i - 1]->GetLatitude(), nodes[i - 1]->GetLongitude(),
          nodes[i]->GetLatitude(), nodes[i]->GetLongitude(),
          node->GetLatitude(), node->GetLongitude());
      tmp_distance +=
          calDistance(nodes[i - 1]->GetLatitude(), nodes[i - 1]->GetLongitude(),
                      nodes[i]->GetLatitude(), nodes[i]->GetLongitude());
      if (tmp < result) {
        result = tmp;
        total_distance = tmp_distance;
        po = i;
      }
    }
    if ((node->GetLatitude() >= nodes[po - 1]->GetLatitude() &&
         node->GetLatitude() <= nodes[po]->GetLatitude()) ||
        (node->GetLatitude() <= nodes[po - 1]->GetLatitude() &&
         node->GetLatitude() >= nodes[po]->GetLatitude())) {
      if (nodes[po]->GetLatitude() - nodes[po - 1]->GetLatitude() != 0) {
        double tmp = (rand() % 10001) / 10000.0;
        longitude =
            nodes[po - 1]->GetLongitude() +
            (nodes[po]->GetLongitude() - nodes[po - 1]->GetLongitude()) *
                (node->GetLatitude() - nodes[po - 1]->GetLatitude()) /
                (nodes[po]->GetLatitude() - nodes[po - 1]->GetLatitude());
        latitude = node->GetLatitude();
      } else {
        if ((node->GetLongitude() >= nodes[po - 1]->GetLongitude() &&
             node->GetLongitude() <= nodes[po]->GetLongitude()) ||
            (node->GetLongitude() <= nodes[po - 1]->GetLongitude() &&
             node->GetLongitude() >= nodes[po]->GetLongitude())) {
          latitude = node->GetLatitude();
          longitude = node->GetLongitude();
        } else {
          double tmp = (rand() % 10001) / 10000.0;
          longitude =
              nodes[po - 1]->GetLongitude() +
              (nodes[po]->GetLongitude() - nodes[po - 1]->GetLongitude()) * tmp;
          latitude = node->GetLatitude();
        }
      }
    } else {
      double tmp = (rand() % 10001) / 10000.0;
      latitude =
          nodes[po - 1]->GetLatitude() +
          (nodes[po]->GetLatitude() - nodes[po - 1]->GetLatitude()) * tmp;
      longitude =
          nodes[po - 1]->GetLongitude() +
          (nodes[po]->GetLongitude() - nodes[po - 1]->GetLongitude()) * tmp;
    }
    total_distance -= calDistance(latitude, longitude, nodes[po]->GetLatitude(),
                                  nodes[po]->GetLongitude());
    return total_distance;
  }

  int GetPLen(int pre, int aim, string nextfile) {
    // Get the route of two edges by the NEXT-table.
    string tmp = "";
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
      tmp += (this->alphabet.at(c));
    }
    if (a == b) {
      for (int i = 0; i < gGraph->GetNodeById(a)->GetOutEdges().size(); i++) {
        d = gGraph->GetNodeById(a)->GetOutEdges().at(i)->GetId();
        if (d == aim) {
          tmp += this->alphabet.at(i + 1);
          this->result = tmp;
        }
      }
    }
    return 1;
  }

  int GetTLen(int pre, int aim, string NEXT_FILE_PATH) {
    // Get the route of two edges by the NEXT-table.
    string tmp = "";
    vector<int> edges;
    int a = gGraph->GetEdgeById(pre)->GetEndNode()->GetId();
    int b = gGraph->GetEdgeById(aim)->GetStartNode()->GetId();
    int c, d;
    while (a != b) {
      c = GetNextChar(a, b, NEXT_FILE_PATH, gGraph->GetNodeNumber() + 2);
      if (c == 8) {
        return -1;
      }
      d = gGraph->GetNodeById(a)->GetOutEdges().at(c - 1)->GetId();
      a = gGraph->GetEdgeById(d)->GetEndNode()->GetId();
      tmp += '0';
    }
    if (a == b) {
      for (int i = 0; i < gGraph->GetNodeById(a)->GetOutEdges().size(); i++) {
        d = gGraph->GetNodeById(a)->GetOutEdges().at(i)->GetId();
        if (d == aim) {
          tmp += '1';
          this->result = tmp;
        }
      }
    }
    return 1;
  }

  void PCoding() {
    int i, j;
    unsigned char tmp;
    for (j = 0; j < gTrajectories->size(); j++) {

      vector<unsigned char> *codings = new vector<unsigned char>();
      if (gTrajectories->at(j)->NodeSize() == 0) {
        gPCodings->push_back(codings);
        return;
      }
      int startedge = gTrajectories->at(j)->GetNodeById(0)->mEdge;
      int startnode = gGraph->GetEdgeById(startedge)->GetStartNode()->GetId();
      tmp = gEdgeToEntryTable->at(startedge) + 1;
      codings->push_back(tmp);
      for (i = 1; i < gTrajectories->at(j)->NodeSize(); i++) {
        if (gTrajectories->at(j)->GetNodeById(i)->mEdge == startedge) {
          codings->push_back(0);
          continue;
        }
        startedge = gTrajectories->at(j)->GetNodeById(i)->mEdge;
        startnode = gGraph->GetEdgeById(startedge)->GetStartNode()->GetId();
        if (gGraph->GetNodeById(startnode)
                ->GetOutEdgeById(gEdgeToEntryTable->at(startedge))
                ->GetId() == startedge) {
          tmp = gEdgeToEntryTable->at(startedge) + 1;
          codings->push_back(tmp);
        } else {
          gPCodings->push_back(codings);
          return;
        }
      }

      gPCodings->push_back(codings);
    }
  }

  void TCoding() {
    for (int j = 0; j < gTrajectories->size(); j++) {
      vector<unsigned char> *codings = new vector<unsigned char>();
      if (gTrajectories->at(j)->NodeSize() == 0) {
        gTCodings->push_back(codings);
        return;
      }
      for (int i = 0; i < gTrajectories->at(j)->NodeSize(); i++) {
        if (gTrajectories->at(j)->GetNodeById(i)->mTime != -1) {
          codings->push_back(1);
        } else {
          codings->push_back(0);
        }
      }
      gTCodings->push_back(codings);
    }
  }
  void LCoding() {
    gLCodings->clear();
    vector<unsigned char> *coding = new vector<unsigned char>();
    vector<Node *> nodes;
    double lng, lat, &tt_lng = lng, &tt_lat = lat;
    for (int j = 0; j < gTrajectories->size(); j++) {
      vector<vector<unsigned char> *> *codings =
          new vector<vector<unsigned char> *>();
      if (gTrajectories->at(j)->NodeSize() == 0) {
        gLCodings->push_back(nulls);
        continue;
      }
      for (int i = 0; i < gTrajectories->at(j)->NodeSize(); i++) {
        nodes = gGraph->GetEdgeById(gTrajectories->at(j)->GetNodeById(i)->mEdge)
                    ->GetEdgeGeometry();
        double distance = getDistanceToStart(
            nodes,
            new Node(-1, gTrajectories->at(j)->GetNodeById(i)->mLongitude,
                     gTrajectories->at(j)->GetNodeById(i)->mLatitude),
            tt_lat, tt_lng);
        coding = location_encoding(
            gGraph->GetEdgeById(gTrajectories->at(j)->GetNodeById(i)->mEdge)
                ->GetLength(),
            distance /
                gGraph->GetEdgeById(gTrajectories->at(j)->GetNodeById(i)->mEdge)
                    ->GetLength());
        codings->push_back(coding);
      }
      gLCodings->push_back(codings);
    }
  }
};
string PLT::alphabet = "0123456789ABCDEF";

#endif
