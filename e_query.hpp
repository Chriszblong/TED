#ifndef __EQUERY_HPP__
#define __EQUERY_HPP__

#include "e_compressed_trajectory.hpp"
#include "e_look_at_table.hpp"
#include "e_partition.hpp"
#include "e_pddp.hpp"
#include <map>
#include <math.h>
#include <queue>

int gMeetQueryNumber = 0;

struct Location {
  double lat;
  double lng;
};

bool operator<(const pair<int, double> &t1, const pair<int, double> &t2) {
  return t1.second > t2.second;
}

class Query {
public:
  Query(FileReader *pddpReader, FileReader *tPartionReader) {
    gPDDPIndex = new PDDPIndex();
    gPDDPIndex->LoadIndexQ(pddpReader);
    gPartionIndex = new Partion();
    gPartionIndex->loadPartion();
    gPartionIndex->LoadPartionIndex(tPartionReader);
  };

  Query() {}
  ~Query() {
    delete gPDDPIndex;
    delete gPartionIndex;
  };

  int TtoE(int j, int tPos) {
    unsigned char beg = 0;
    if (tPos >= gCTrajectories->at(j)->mTNumber) {
      return -1;
    }
    if (gCTrajectories->at(j)->mPCoding->at((3 * tPos) / 8) &
        MAPTABLE[(3 * tPos) % 8]) {
      beg |= 4;
    }
    if (gCTrajectories->at(j)->mPCoding->at((3 * tPos + 1) / 8) &
        MAPTABLE[(3 * tPos + 1) % 8]) {
      beg |= 2;
    }
    if (gCTrajectories->at(j)->mPCoding->at((3 * tPos + 2) / 8) &
        MAPTABLE[(3 * tPos + 2) % 8]) {
      beg |= 1;
    }
    if (beg) {
      return beg;
    } else {
      int tTmp = 1;
      while (!beg) {
        if (gCTrajectories->at(j)->mPCoding->at((3 * (tPos - tTmp)) / 8) &
            MAPTABLE[(3 * (tPos - tTmp)) % 8]) {
          beg |= 4;
        }
        if (gCTrajectories->at(j)->mPCoding->at((3 * (tPos - tTmp) + 1) / 8) &
            MAPTABLE[(3 * (tPos - tTmp) + 1) % 8]) {
          beg |= 2;
        }
        if (gCTrajectories->at(j)->mPCoding->at((3 * (tPos - tTmp) + 2) / 8) &
            MAPTABLE[(3 * (tPos - tTmp) + 2) % 8]) {
          beg |= 1;
        }
        tTmp++;
      }
    }
    return beg;
  }
  int EtoT(int j, int tPos) {
    tPos++;
    if ((tPos - 1) % 3 == 0)
      return (tPos - 1) / 3;
    else
      return -1;
  }
  int TtoD(int j, int tPos) {
    int ttPos = 0;
    if (tPos >= gCTrajectories->at(j)->mTNumber) {
      return -1;
    }
    for (int i = 0; i < tPos; i++) {
      DPNode *tTmp = gTree;
      while (tTmp && ttPos < gCTrajectories->at(j)->mLNumber) {

        if ((gCTrajectories->at(j)->mLCoding->at(ttPos / 8) &
             MAPTABLE[ttPos % 8]) &&
            tTmp->mRight) {
          tTmp = tTmp->mRight;
          ttPos++;
        } else if (!(gCTrajectories->at(j)->mLCoding->at(ttPos / 8) &
                     MAPTABLE[ttPos % 8]) &&
                   tTmp->mLeft) {
          tTmp = tTmp->mLeft;
          ttPos++;
        } else {
          break;
        }
      }
      if (ttPos >= gCTrajectories->at(j)->mLNumber) {
        return -1;
      }
    }
    return ttPos;
  }

  int DtoT(int j, int tPos) {
    int ttPos = 0;
    if (tPos >= gCTrajectories->at(j)->mLNumber) {
      return -1;
    }
    int t = 0;
    while (1) {
      DPNode *tTmp = gTree;
      while (tTmp && ttPos < gCTrajectories->at(j)->mLNumber) {

        if ((gCTrajectories->at(j)->mLCoding->at(ttPos / 8) &
             MAPTABLE[ttPos % 8]) &&
            tTmp->mRight) {
          tTmp = tTmp->mRight;
          ttPos++;
        } else if (!(gCTrajectories->at(j)->mLCoding->at(ttPos / 8) &
                     MAPTABLE[ttPos % 8]) &&
                   tTmp->mLeft) {
          tTmp = tTmp->mLeft;
          ttPos++;
        } else {
          break;
        }
      }
      t++;
      if (ttPos == tPos) {
        return t;
      }
      if (ttPos > tPos) {
        return -1;
      }
    }
    return -1;
  }

  pair<int, int> TimeToT(int j, int time) {

    int i;
    int tTmp = 0;
    int tStart = 0, tEnd = 0;

    int tCounter = (time - gCTrajectories->at(j)->mStartTime) /
                   gCTrajectories->at(j)->mTimeInterval;

    if (tCounter > gCTrajectories->at(j)->mTNumber)
      return make_pair(-1, -1);
    for (i = 0; i < gCTrajectories->at(j)->mTCoding->size(); i++) {
      if (tTmp +
              gLookAtTable->GetNumOfBit1(
                  gCTrajectories->at(j)->mTCoding->at(i)) >=
          tCounter) {
        int p = tTmp;
        int mask = 0x80;
        for (int k = 0; k < 8; ++k) {
          if (gCTrajectories->at(j)->mTCoding->at(i) & mask) {
            p++;
          }
          if (p == tCounter) {
            tStart = 8 * i + k;
            break;
          }
          mask >>= 1;
        }
        break;
      }
      tTmp +=
          gLookAtTable->GetNumOfBit1(gCTrajectories->at(j)->mTCoding->at(i));
    }
    for (; i < gCTrajectories->at(j)->mTCoding->size(); i++) {
      if (tTmp +
              gLookAtTable->GetNumOfBit1(
                  gCTrajectories->at(j)->mTCoding->at(i)) >=
          tCounter + 1) {
        int mask = 0x80;
        for (int k = 0; k < 8; ++k) {
          if (gCTrajectories->at(j)->mTCoding->at(i) & mask) {
            tTmp++;
          }
          if (tTmp == tCounter + 1) {
            tEnd = 8 * i + k;
            break;
          }
          mask >>= 1;
        }
        break;
      }
      tTmp +=
          gLookAtTable->GetNumOfBit1(gCTrajectories->at(j)->mTCoding->at(i));
    }
    if (tStart == 0 && tEnd == 0)
      return make_pair(-1, -1);
    return make_pair(tStart, tEnd);
  }

  int EdgeToE(int j, int edge) {
    int i;
    Node *start = gGraph->GetNodeById(gCTrajectories->at(j)->mStartNode);
    Edge *curEdge;
    for (i = 0; i < gCTrajectories->at(j)->mPCoding->size(); i += 3) {
      unsigned int beg = 0;
      if (gCTrajectories->at(j)->mPCoding->at(i / 8) & MAPTABLE[i % 8]) {
        beg |= 4;
      }
      if (gCTrajectories->at(j)->mPCoding->at((i + 1) / 8) &
          MAPTABLE[(i + 1) % 8]) {
        beg |= 2;
      }
      if (gCTrajectories->at(j)->mPCoding->at((i + 2) / 8) &
          MAPTABLE[(i + 2) % 8]) {
        beg |= 1;
      }
      if (!beg)
        continue;
      curEdge = start->GetOutEdgeById(beg - 1);
      if (curEdge->GetId() == edge)
        return i / 3;
      start = curEdge->GetEndNode();
    }
    return -1;
  }

  void WhenWithoutIndex(int edgeid, double distance) {

    int i, j;
    int tcount;
    int startPos;
    int endPos;
    bool state = false;
    double tPreDistance, totalDistance;
    Node *mStartNode;
    Node *tTmpNode = NULL;
    Edge *tTmpEdge = NULL;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {

      tTmpNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);
      tcount = 0;
      tPreDistance = 0;
      totalDistance = 0;
      startPos = -1;
      endPos = -1;
      state = false;
      mStartNode = NULL;

      for (j = 0; j < (int)gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {
        if (gCTrajectoriesQ->at(i)->mTCoding->at(j) == 1) {

          if (state) {
            endPos = j;
            break;
          } else {
            startPos = j;
            mStartNode = tTmpNode;
          }
          tcount++;
        }
        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        } else {
          tTmpEdge = tTmpNode->GetOutEdgeById(
              gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
          if (tTmpEdge->GetId() == edgeid) {
            state = true;
          }
          tTmpNode = tTmpEdge->GetEndNode();
        }
      }
      if (state) {
        state = false;
        for (j = startPos; j <= endPos; j++) {
          if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
            continue;
          } else {
            tTmpEdge = mStartNode->GetOutEdgeById(
                gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);

            totalDistance += tTmpEdge->GetLength();
            if (!state) {
              tPreDistance += tTmpEdge->GetLength();
              if (j == startPos) {
                tPreDistance -= tTmpEdge->GetLength() *
                                gCTrajectoriesQ->at(i)->mLCoding->at(j);
                totalDistance -= tTmpEdge->GetLength() *
                                 gCTrajectoriesQ->at(i)->mLCoding->at(j);
              }
            }
            if (tTmpEdge->GetId() == edgeid) {
              state = true;
              tPreDistance -= tTmpEdge->GetLength() *
                              (1 - gCTrajectoriesQ->at(i)->mLCoding->at(j));
            }
            mStartNode = tTmpEdge->GetEndNode();
          }
        }
        // totalDistance -= tTmpEdge->GetLength() *
        //                 (1 - gCTrajectoriesQ->at(i)->mLCoding->at(endPos));

        // cout << gCTrajectoriesQ->at(i)->mStartTime +
        // gCTrajectoriesQ->at(i)->mTimeInterval *(tcount + distance /
        // totalDistance)
        //    << endl;
      }
    }
  }

  void When(int edgeid, double distance) {

    int tTmp = gGraph->GetEdgeById(edgeid)->GetStartNode()->GetId();
    int tPart = gPartionIndex->Convert2int(gGraph->GetNodeById(tTmp));
    int tPre = gGrid[tPart].mPtr;
    int i;

    while (tPre != tPart) {

      gMeetQueryNumber++;
      int tTmpPoint = gGrid[tPre].mEdge;
      int tName = gGrid[tPre].mName;
      int tTmporder = gGrid[tPre].mOrder;

      for (i = 0; i < gGrid[tPre].mLen; i++) {
        if (tTmpPoint == tTmp) {
          double tLength = gGraph->GetEdgeById(edgeid)->GetLength();
          double tInterval = gCTrajectoriesQ->at(tName)->mTimeInterval;
          // cout<<"name: "<<tName<<" ->
          // "<<int2time((int)(gCTrajectoriesQ->at(tName)->mStartTime+tInterval*(tTmporder+distance/tLength)))<<"\t";
          break;
        }
        unsigned char p =
            gCTrajectoriesQ->at(tName)->mPCoding->at(tTmporder + i);
        if (p) {
          tTmpPoint = gGraph->GetNodeById(tTmpPoint)
                          ->GetOutEdgeById(p - 1)
                          ->GetEndNode()
                          ->GetId();
        }
      }
      tPre = gGrid[tPre].mPtr;
    }
  }

  void HowlongWithoutIndex(int edgeid1, double distance1, int edgeid2,
                           double distance2) {
    int i, j;
    int time1, time2;
    int state;
    int tcount1, tcount2;
    int startPos1, startPos2;
    double tPreDistance1, tPreDistance2, totalDistance1, totalDistance2;
    Node *mStartNode1, *mStartNode2;
    int endPos1, endPos2;
    bool state1 = false, state2 = false;
    Node *tTmpNode = NULL;
    Edge *tTmpEdge = NULL;
    bool startState, endState;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {

      tTmpNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);
      tcount1 = 0;
      tcount2 = 0;
      tPreDistance1 = 0;
      tPreDistance2 = 0;
      totalDistance1 = 0;
      totalDistance2 = 0;
      startPos1 = -1;
      startPos2 = -1;
      endPos1 = -1;
      endPos2 = -1;
      state1 = false;
      state2 = false;
      mStartNode1 = NULL;
      mStartNode2 = NULL;
      startState = false;
      endState = false;

      for (j = 0; j < (int)gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {

        if (gCTrajectoriesQ->at(i)->mTCoding->at(j) == 1) {

          if (!startState) {
            if (state1) {
              endPos1 = j;
              startState = true;
            } else {
              startPos1 = j;
              mStartNode1 = tTmpNode;
            }
            tcount1++;
          }
          if (!endState) {

            if (state2) {
              endPos2 = j;
              endState = true;
            } else {
              startPos2 = j;
              mStartNode2 = tTmpNode;
            }
            tcount2++;
          }
          if (startState && endState) {
            break;
          }
        }

        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        } else {
          tTmpEdge = tTmpNode->GetOutEdgeById(
              gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
          if (tTmpEdge->GetId() == edgeid1) {
            state1 = true;
          }
          if (tTmpEdge->GetId() == edgeid2) {
            state2 = true;
          }
          tTmpNode = tTmpEdge->GetEndNode();
        }
      }

      if (state1 && state2) {
        state1 = false;
        state2 = false;
        for (j = startPos1; j <= endPos1; j++) {
          if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
            continue;
          } else {
            tTmpEdge = mStartNode1->GetOutEdgeById(
                gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
            totalDistance1 += tTmpEdge->GetLength();
            if (!state1) {
              tPreDistance1 += tTmpEdge->GetLength();
              if (j == startPos1) {
                tPreDistance1 -= tTmpEdge->GetLength() *
                                 gCTrajectoriesQ->at(i)->mLCoding->at(j);
                totalDistance1 -= tTmpEdge->GetLength() *
                                  gCTrajectoriesQ->at(i)->mLCoding->at(j);
              }
            }
            if (tTmpEdge->GetId() == edgeid1) {
              state1 = true;
              tPreDistance1 -= tTmpEdge->GetLength() *
                               (1 - gCTrajectoriesQ->at(i)->mLCoding->at(j));
            }
            mStartNode1 = tTmpEdge->GetEndNode();
          }
        }
        totalDistance1 -= tTmpEdge->GetLength() *
                          (1 - gCTrajectoriesQ->at(i)->mLCoding->at(endPos1));
        for (j = startPos2; j <= endPos2; j++) {
          if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
            continue;
          } else {
            tTmpEdge = mStartNode2->GetOutEdgeById(
                gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
            totalDistance2 += tTmpEdge->GetLength();
            if (!state2) {
              tPreDistance2 += tTmpEdge->GetLength();
              if (j == startPos2) {
                tPreDistance2 -= tTmpEdge->GetLength() *
                                 gCTrajectoriesQ->at(i)->mLCoding->at(j);
                totalDistance2 -= tTmpEdge->GetLength() *
                                  gCTrajectoriesQ->at(i)->mLCoding->at(j);
              }
            }
            if (tTmpEdge->GetId() == edgeid2) {
              state2 = true;
              tPreDistance2 -= tTmpEdge->GetLength() *
                               (1 - gCTrajectoriesQ->at(i)->mLCoding->at(j));
            }
            mStartNode2 = tTmpEdge->GetEndNode();
          }
        }
        totalDistance2 -= tTmpEdge->GetLength() *
                          (1 - gCTrajectoriesQ->at(i)->mLCoding->at(endPos2));
        // cout << gCTrajectoriesQ->at(i)->mTimeInterval *
        //            (tcount1 + distance1 / totalDistance1 - tcount2 -
        //             distance2 / totalDistance2)
        //     << endl;
      }
    }
  }
  void Howlong(int edgeid1, double distance1, int edgeid2, double distance2) {

    vector<pair<int, int> /**/> tTimes1, tTimes2;

    int tTmtP1 = gGraph->GetEdgeById(edgeid1)->GetStartNode()->GetId();
    int tPart1 = gPartionIndex->Convert2int(gGraph->GetNodeById(tTmtP1));
    int tPre1 = gGrid[tPart1].mPtr;
    int tI1;

    int tMeet1 = 0, tMeet2 = 0;

    while (tPre1 != tPart1) {

      gMeetQueryNumber++;
      int tTmpPoint1 = gGrid[tPre1].mEdge;
      int tName1 = gGrid[tPre1].mName;
      int tTmporder1 = gGrid[tPre1].mOrder;
      for (tI1 = 0; tI1 < gGrid[tPre1].mLen; tI1++) {
        if (tTmpPoint1 == tTmtP1) {
          double tLength1 = gGraph->GetEdgeById(edgeid1)->GetLength();
          double tInterval1 = gCTrajectoriesQ->at(tName1)->mTimeInterval;
          tTimes1.push_back(make_pair(
              tName1, (int)(gCTrajectoriesQ->at(tName1)->mStartTime +
                            tInterval1 * (tTmporder1 + distance1 / tLength1))));
          break;
        }
        unsigned char tP1 =
            gCTrajectoriesQ->at(tName1)->mPCoding->at(tTmporder1 + tI1);
        if (tP1) {
          tTmpPoint1 = gGraph->GetNodeById(tTmpPoint1)
                           ->GetOutEdgeById(tP1 - 1)
                           ->GetEndNode()
                           ->GetId();
        }
      }
      tPre1 = gGrid[tPre1].mPtr;
    }

    int tTmtP2 = gGraph->GetEdgeById(edgeid2)->GetStartNode()->GetId();
    int tPart2 = gPartionIndex->Convert2int(gGraph->GetNodeById(tTmtP2));
    int tPre2 = gGrid[tPart2].mPtr;
    int tI2;
    while (tPre2 != tPart2) {

      //gMeetQueryNumber++;
      int tTmpPoint2 = gGrid[tPre2].mEdge;
      int tName2 = gGrid[tPre2].mName;
      int tTmporder2 = gGrid[tPre2].mOrder;
      for (tI2 = 0; tI2 < gGrid[tPre2].mLen; tI2++) {
        if (tTmpPoint2 == tTmtP2) {
          double tLength2 = gGraph->GetEdgeById(edgeid2)->GetLength();
          double tInterval2 = gCTrajectoriesQ->at(tName2)->mTimeInterval;
          tTimes2.push_back(make_pair(
              tName2, (int)(gCTrajectoriesQ->at(tName2)->mStartTime +
                            tInterval2 * (tTmporder2 + distance2 / tLength2))));
          break;
        }
        unsigned char tP2 =
            gCTrajectoriesQ->at(tName2)->mPCoding->at(tTmporder2 + tI2);
        if (tP2) {
          tTmpPoint2 = gGraph->GetNodeById(tTmpPoint2)
                           ->GetOutEdgeById(tP2 - 1)
                           ->GetEndNode()
                           ->GetId();
        }
      }
      tPre2 = gGrid[tPre2].mPtr;
    }

    int tPos1 = 0, tPos2 = 0;
    while (tPos1 < tTimes1.size() && tPos2 < tTimes2.size()) {
      if (tTimes1[tPos1].first == tTimes2[tPos2].first) {
        tPos1++;
        tPos2++;
      } else if (tTimes1[tPos1].first > tTimes2[tPos2].first) {
        tPos1++;
      } else
        tPos2++;
    }
  }

  void CountWithoutIndex(double lat1, double lng1, double lat2, double lng2) {

    int i, j;
    int count;
    Node *tTmpNode = NULL;
    Edge *tTmpEdge = NULL;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {
      tTmpNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);
      count = 0;

      for (j = 0; j < (int)gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {
        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        } else {
          tTmpEdge = tTmpNode->GetOutEdgeById(
              gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
          if (IsLineIntersectRectangle(
                  lat1, lng1, lat2, lng2,
                  tTmpEdge->GetStartNode()->GetLatitude(),
                  tTmpEdge->GetStartNode()->GetLongitude(),
                  tTmpEdge->GetEndNode()->GetLatitude(),
                  tTmpEdge->GetEndNode()->GetLongitude())) {
            count++;
            break;
          }
          tTmpNode = tTmpEdge->GetEndNode();
        }
      }
      // cout << count << endl;
    }
  }

  void Count(double lat1, double lng1, double lat2, double lng2) {

    int i;
    map<int, int> tras;
    vector<int> tParts;
    int tGridNum = pow(4, gNPart);
    int lineNum = sqrt(tGridNum);
    Node *node1 = new Node(-1, lng1, lat1);
    int tPart1 = gPartionIndex->Convert2int(node1);
    Node *node2 = new Node(-1, lng2, lat2);
    int tPart2 = gPartionIndex->Convert2int(node2);

    for (i = tPart1 / lineNum; i <= tPart2 / lineNum; i++) {
      for (int j = tPart1 % lineNum; j <= tPart2 % lineNum; j++) {
        // cout<<i*lineNum+j<<" ";
        tParts.push_back(i * lineNum + j);
      }
    }
    // cout<<endl;
    int count = 0;
    for (i = 0; i < tParts.size(); i++) {
      int tPart = tParts[i];
      int tPre = gGrid[tPart].mPtr;
      int i;
      int otPre = -1;
      while (tPre != tPart) {

        gMeetQueryNumber++;
        int tTmpPoint = gGrid[tPre].mEdge;

        int name = gGrid[tPre].mName;
        int tTmporder = gGrid[tPre].mOrder;

        map<int, int>::iterator iter = tras.find(name);
        if (name != otPre && iter == tras.end()) {
          count++;
          tras[name] = 1;
        }
        otPre = name;
        tPre = gGrid[tPre].mPtr;
      }
      // cout<<count<<endl;
    }
  }

  void WindowWithoutIndex(double lat1, double lng1, double lat2, double lng2) {

    int i, j;
    Edge *tTmpEdge = NULL;
    Node *tTmpNode = NULL;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {

      tTmpNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);
      for (j = 0; j < (int)gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {
        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        } else {
          tTmpEdge = tTmpNode->GetOutEdgeById(
              gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
          if (IsLineIntersectRectangle(
                  lat1, lng1, lat2, lng2,
                  tTmpEdge->GetStartNode()->GetLatitude(),
                  tTmpEdge->GetStartNode()->GetLongitude(),
                  tTmpEdge->GetEndNode()->GetLatitude(),
                  tTmpEdge->GetEndNode()->GetLongitude())) {
            // cout<<i<<endl;
            break;
          }
          tTmpNode = tTmpEdge->GetEndNode();
        }
      }
    }
  }

  void Window(double lat1, double lng1, double lat2, double lng2, FileWriter *writer) {

    int i;
    vector<int> tParts;
    map<int, int> tras;
    int tGridNum = pow(4, gNPart);
    int lineNum = sqrt(tGridNum);
    Node *node1 = new Node(-1, lng1, lat1);
    int tPart1 = gPartionIndex->Convert2int(node1);
    Node *node2 = new Node(-1, lng2, lat2);
    int tPart2 = gPartionIndex->Convert2int(node2);

    for (i = tPart1 / lineNum; i <= tPart2 / lineNum; i++) {
      for (int j = tPart1 % lineNum; j <= tPart2 % lineNum; j++) {
        tParts.push_back(i * lineNum + j);
      }
    }

    for (i = 0; i < tParts.size(); i++) {

      int tPart = tParts[i];
      int tPre = gGrid[tPart].mPtr;
      int i;
      int otPre = -1;

      while (tPre != tPart) {

        gMeetQueryNumber++;
        int tTmpPoint = gGrid[tPre].mEdge;
        int name = gGrid[tPre].mName;
        int tTmporder = gGrid[tPre].mOrder;
        map<int, int>::iterator iter = tras.find(name);

	if(name<0){
		otPre = name;
        	tPre = gGrid[tPre].mPtr;
		continue;
	}

	//cout<<gCTrajectoriesQ->size()<<","<<name<<endl;
	
	double time=gCTrajectoriesQ->at(name)->mStartTime+gCTrajectoriesQ->at(name)->mTimeInterval*(tTmporder-1);
	
        if (name != otPre && iter == tras.end()&&time>=18000&&time<=43200) {
          // cout<<"name: "<<name<<"\t";
		writer->WriteInt(name);
          tras[name] = 1;
        }
        otPre = name;
        tPre = gGrid[tPre].mPtr;
      }
    }
  }

  void KnnWithoutIndex(double lat, double lng, int k) {

    int i, j;
    double tMinT = 9999999999;
    priority_queue<pair<int, double> /**/> q;
    Node *mStartNode = NULL;
    Edge *tTmpEdge = NULL;

    // For every comtPressed trajectory,to decomtPress it
    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {

      mStartNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);
      double mindis = 9999999999;

      for (j = 0; j < gCTrajectoriesQ->at(i)->mTCoding->size(); j++) {

        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        }

        tTmpEdge = mStartNode->GetOutEdgeById(
            gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);

        double dis = Point2LineDistance(
            tTmpEdge->GetStartNode()->GetLatitude(),
            tTmpEdge->GetStartNode()->GetLongitude(),
            tTmpEdge->GetEndNode()->GetLatitude(),
            tTmpEdge->GetEndNode()->GetLongitude(), lat, lng);

        mindis = mindis > dis ? dis : mindis;

        mStartNode = tTmpEdge->GetEndNode();
      }

      if (q.size() < k || (q.size() >= k && tMinT >= mindis)) {
        q.push(make_pair(i, mindis));
        if (mindis < tMinT)
          tMinT = mindis;
      }
    }

    for (i = 0; i < k && i < q.size(); i++) {
      pair<int, double> t = q.top();
      q.pop();
      // cout<<"name: "<<t.first<<"\t";
    }
    // cout<<endl;
  }

  void Knn(double lat, double lng, int k) {

    priority_queue<pair<int, double> /**/> q;
    Node *node = new Node(-1, lng, lat);
    int tPart = gPartionIndex->Convert2int(node);
    int tPre = gGrid[tPart].mPtr;
    int i;
    double tMinT = 9999999999;
    int ntPre = -1;

    while (tPre != tPart) {

      gMeetQueryNumber++;
      int tTmpPoint = gGrid[tPre].mEdge;
      int name = gGrid[tPre].mName;
      int tTmporder = gGrid[tPre].mOrder;
      int ptPre = -1;
      double mindis = 9999999999;

      if (name == ntPre) {
        tPre = gGrid[tPre].mPtr;
        continue;
      }

      ntPre = name;
      for (i = 0; i < gGrid[tPre].mLen; i++) {

        if (ptPre != tTmpPoint) {
          double dis = calDistance(
              lat, lng, gGraph->GetNodeById(tTmpPoint)->GetLatitude(),
              gGraph->GetNodeById(tTmpPoint)->GetLongitude());
          mindis = mindis > dis ? dis : mindis;
          ptPre = tTmpPoint;
        }

        unsigned char p =
            gCTrajectoriesQ->at(name)->mPCoding->at(tTmporder + i);

        if (p) {
          tTmpPoint = gGraph->GetNodeById(tTmpPoint)
                          ->GetOutEdgeById(p - 1)
                          ->GetEndNode()
                          ->GetId();
        }
      }

      if (q.size() < k || (q.size() >= k && tMinT >= mindis)) {
        q.push(make_pair(name, mindis));
        if (mindis < tMinT)
          tMinT = mindis;
      }

      tPre = gGrid[tPre].mPtr;
    }

    for (i = 0; i < k && i < q.size(); i++) {
      pair<int, double> t = q.top();
      q.pop();
      // cout<<"name: "<<t.first<<"\t";
    }
    // cout<<endl;
  }

  void WhereWithoutIndex(int time) {

    int i, j, k;
    int start, end;
    int tcount;
    int tcountMax;
    double startratio, endRatio;
    double resultLat, resultLng;
    vector<Edge *> edges;
    Node *tTmpNode = NULL;
    Edge *tTmpEdge = NULL;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {

      tTmpNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);

      if (gCTrajectoriesQ->at(i)->mTimeInterval < 1e-15) {
        tTmpEdge = tTmpNode->GetOutEdgeById(
            gCTrajectoriesQ->at(i)->mPCoding->at(0) - 1);
        gMeetQueryNumber--;
        continue;
      }
      tcount = 0;
      tcountMax = (int)((time - gCTrajectoriesQ->at(i)->mStartTime) /
                        gCTrajectoriesQ->at(i)->mTimeInterval);
      if (time < gCTrajectoriesQ->at(i)->mStartTime ||
          time > gCTrajectoriesQ->at(i)->mStartTime +
                     gCTrajectoriesQ->at(i)->mTimeInterval *
                         (gCTrajectoriesQ->at(i)->mSize - 1)) {
        gMeetQueryNumber--;
        continue;
      }

      double distance = 0;

      for (j = 0; j < (int)gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {

        if (gCTrajectoriesQ->at(i)->mTCoding->at(j) == 0) {
          tcount++;
        }

        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        } else {

          tTmpEdge = tTmpNode->GetOutEdgeById(
              gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);

          if (tcount == tcountMax + 1) {
            edges.push_back(tTmpEdge);
            distance += tTmpEdge->GetLength();
            startratio = gCTrajectoriesQ->at(i)->mTCoding->at(j);
          } else if (tcount == tcountMax + 2) {
            edges.push_back(tTmpEdge);
            distance += tTmpEdge->GetLength();
            endRatio = gCTrajectoriesQ->at(i)->mTCoding->at(j);
            double timeRatio =
                (time - (gCTrajectoriesQ->at(i)->mStartTime +
                         gCTrajectoriesQ->at(i)->mTimeInterval * tcountMax)) /
                gCTrajectoriesQ->at(i)->mTimeInterval;
            distance -= startratio * edges[0]->GetLength();
            distance -= (1 - endRatio) * edges[edges.size() - 1]->GetLength();
            distance *= timeRatio;
            if (distance >= (1 - startratio) * edges[0]->GetLength()) {
              distance -= (1 - startratio) * edges[0]->GetLength();
              for (k = 1; k < edges.size(); k++) {
                if (distance >= edges[k]->GetLength()) {
                  distance -= edges[k]->GetLength();
                } else {
                  break;
                }
              }
              double tTmpRatio = edges[k]->GetLength() < 1e-15
                                     ? 0.0
                                     : distance / edges[k]->GetLength();
              resultLat = edges[k]->GetStartNode()->GetLatitude() +
                          tTmpRatio * (edges[k]->GetEndNode()->GetLatitude() -
                                       edges[k]->GetStartNode()->GetLatitude());
              resultLng =
                  edges[k]->GetStartNode()->GetLongitude() +
                  tTmpRatio * (edges[k]->GetEndNode()->GetLongitude() -
                               edges[k]->GetStartNode()->GetLongitude());
              // cout << resultLat << "," << resultLng << endl;
            } else {
              double tTmpRatio =
                  timeRatio + (tTmpEdge->GetLength() < 1e-15
                                   ? 0.0
                                   : distance / tTmpEdge->GetLength());
              resultLat = tTmpEdge->GetStartNode()->GetLatitude() +
                          tTmpRatio * (tTmpEdge->GetEndNode()->GetLatitude() -
                                       tTmpEdge->GetStartNode()->GetLatitude());
              resultLng =
                  tTmpEdge->GetStartNode()->GetLongitude() +
                  tTmpRatio * (tTmpEdge->GetEndNode()->GetLongitude() -
                               tTmpEdge->GetStartNode()->GetLongitude());
              // cout << resultLat << "," << resultLng << endl;
            }
            break;
          }

          tTmpNode = tTmpEdge->GetEndNode();
        }
      }
    }
  }

  void Where(int time) {

    int i, j;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {
      int start = 0;
      int end = gCTrajectoriesQ->at(i)->mRNodes->size() - 1;
      if (time < gCTrajectoriesQ->at(i)->mStartTime ||
          time > gCTrajectoriesQ->at(i)->mStartTime +
                     gCTrajectoriesQ->at(i)->mTimeInterval *
                         (gCTrajectoriesQ->at(i)->mSize - 1)) {
        //gMeetQueryNumber--;
        continue;
      }
      int tCenter = (start + end) / 2;
      while (tCenter != start) {
        if (time < gCTrajectoriesQ->at(i)->mRNodes->at(tCenter)->mTime) {
          end = tCenter;
        } else {
          start = tCenter;
        }
        tCenter = (start + end) / 2;
      }
      if ((gCTrajectoriesQ->at(i)->mRNodes->at(end)->mTime -
           gCTrajectoriesQ->at(i)->mRNodes->at(start)->mTime) == 0) {
        continue;
      }
      double ratio =
          (time - gCTrajectoriesQ->at(i)->mRNodes->at(start)->mTime) /
          (gCTrajectoriesQ->at(i)->mRNodes->at(end)->mTime -
           gCTrajectoriesQ->at(i)->mRNodes->at(start)->mTime);

      // adding
      double distance =
          ratio * (gCTrajectoriesQ->at(i)->mRNodes->at(end)->mDistance -
                   gCTrajectoriesQ->at(i)->mRNodes->at(start)->mDistance);
      Edge *tTmpE =
          gGraph->GetEdgeById(gCTrajectoriesQ->at(i)->mRNodes->at(start)->mId);
      if (tTmpE->GetLength() * (1 - ratio) >= distance) {
        double rT =
            ratio +
            (tTmpE->GetLength() < 1e-15 ? 0.0 : distance / tTmpE->GetLength());
        continue;
      } else {
        distance -= tTmpE->GetLength() * (1 - ratio);
      }
      for (j = gCTrajectoriesQ->at(i)->mRNodes->at(start)->mOrder + 1;
           j < (int)gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {
        if (!gCTrajectoriesQ->at(i)->mPCoding->at(j))
          continue;
        tTmpE = tTmpE->GetEndNode()->GetOutEdgeById(
            gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
        if (distance >= tTmpE->GetLength()) {
          distance -= tTmpE->GetLength();
        } else {
          double raT =
              tTmpE->GetLength() < 1e-15 ? 0.0 : distance / tTmpE->GetLength();
          // cout<<"name: "<<i<<" ->
          // "<<"("<<tTmpE->GetStartNode()->GetLatitude()+raT*(tTmpE->GetEndNode()->GetLatitude()-tTmpE->GetStartNode()->GetLatitude())<<","<<tTmpE->GetStartNode()->GetLongitude()+raT*(tTmpE->GetEndNode()->GetLongitude()-tTmpE->GetStartNode()->GetLongitude())<<")"<<"
          // ";
        }
      }
    }
    // cout<<endl;
  }

  void DistanceWithoutIndex(int time1, int time2) {

    int i, j;
    int end1, end2, start1, start2;
    bool state;
    int tcount;
    double distance;
    int tcountMax1, tcountMax2;
    Node *tTmpNode = NULL;
    Edge *tTmpEdge = NULL;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {

      tTmpNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);

      /* If the query time is less than the starting time or more than the
       * final
       * time, then ended */
      if (time1 < gCTrajectoriesQ->at(i)->mStartTime ||
          time1 > gCTrajectoriesQ->at(i)->mStartTime +
                      gCTrajectoriesQ->at(i)->mTimeInterval *
                          (gCTrajectoriesQ->at(i)->mSize - 1) ||
          time2 < gCTrajectoriesQ->at(i)->mStartTime ||
          time2 > gCTrajectoriesQ->at(i)->mStartTime +
                      gCTrajectoriesQ->at(i)->mTimeInterval *
                          (gCTrajectoriesQ->at(i)->mSize - 1)) {
        gMeetQueryNumber--;
        continue;
      }

      /* The tIntervals traveled by the two time point */
      tcountMax1 = (int)((time1 - gCTrajectoriesQ->at(i)->mStartTime) /
                         gCTrajectoriesQ->at(i)->mTimeInterval);
      tcountMax2 = (int)((time2 - gCTrajectoriesQ->at(i)->mStartTime) /
                         gCTrajectoriesQ->at(i)->mTimeInterval);
      tcount = 0;
      distance = 0;
      state = false;
      /* DecomtPress the codings and get the query result */
      for (j = 0; j < (int)gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {
        if (gCTrajectoriesQ->at(i)->mTCoding->at(j) == 1) {
          tcount++;
          if (tcount > tcountMax2) {
            break;
          } else if (tcount > tcountMax1) {
            state = true;
          }
        }
        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        } else {
          tTmpEdge = tTmpNode->GetOutEdgeById(
              gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
          if (state) {
            distance += tTmpEdge->GetLength();
          }
          tTmpNode = tTmpEdge->GetEndNode();
        }
      }
      // cout<<distance<<endl;
    }
  }

  void Distance(int time1, int time2) {
    int i;
    double dis1 = 0, dis2 = 0;
    int start1, start2;
    int end1, end2;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {

      start1 = 0;
      start2 = 0;
      end1 = gCTrajectoriesQ->at(i)->mRNodes->size() - 1;
      end2 = end1;

      /* If the query time is less than the starting time or more than the
       * final
       * time, then ended */
      if (time1 < gCTrajectoriesQ->at(i)->mStartTime ||
          time1 > gCTrajectoriesQ->at(i)->mStartTime +
                      gCTrajectoriesQ->at(i)->mTimeInterval *
                          (gCTrajectoriesQ->at(i)->mSize - 1) ||
          time2 < gCTrajectoriesQ->at(i)->mStartTime ||
          time2 > gCTrajectoriesQ->at(i)->mStartTime +
                      gCTrajectoriesQ->at(i)->mTimeInterval *
                          (gCTrajectoriesQ->at(i)->mSize - 1)) {
        gMeetQueryNumber--;
        continue;
      }

      /* Binary search and decomtPress the codings to get the query result */
      int tCenter1 = (start1 + end1) / 2;
      while (tCenter1 != start1) {
        if (time1 < gCTrajectoriesQ->at(i)->mRNodes->at(tCenter1)->mTime) {
          end1 = tCenter1;
        } else {
          start1 = tCenter1;
        }
        tCenter1 = (start1 + end1) / 2;
      }
      if ((gCTrajectoriesQ->at(i)->mRNodes->at(end1)->mTime -
           gCTrajectoriesQ->at(i)->mRNodes->at(start1)->mTime) == 0) {
        dis1 = gCTrajectoriesQ->at(i)->mRNodes->at(end1)->mDistance;

      } else {
        double ratio1 =
            (time1 - gCTrajectoriesQ->at(i)->mRNodes->at(start1)->mTime) /
            (gCTrajectoriesQ->at(i)->mRNodes->at(end1)->mTime -
             gCTrajectoriesQ->at(i)->mRNodes->at(start1)->mTime);
        dis1 =
            gCTrajectoriesQ->at(i)->mRNodes->at(start1)->mDistance +
            ratio1 *
                (time1 - gCTrajectoriesQ->at(i)->mRNodes->at(end1)->mDistance -
                 gCTrajectoriesQ->at(i)->mRNodes->at(start1)->mDistance);
      }

      int tCenter2 = (start2 + end2) / 2;
      while (tCenter2 != start2) {
        if (time2 < gCTrajectoriesQ->at(i)->mRNodes->at(tCenter2)->mTime) {
          end2 = tCenter2;
        } else {
          start2 = tCenter2;
        }
        tCenter2 = (start2 + end2) / 2;
      }
      if ((gCTrajectoriesQ->at(i)->mRNodes->at(end2)->mTime -
           gCTrajectoriesQ->at(i)->mRNodes->at(start2)->mTime) == 0) {
        dis2 = gCTrajectoriesQ->at(i)->mRNodes->at(end2)->mDistance;

      } else {
        double ratio2 =
            (time2 - gCTrajectoriesQ->at(i)->mRNodes->at(start2)->mTime) /
            (gCTrajectoriesQ->at(i)->mRNodes->at(end2)->mTime -
             gCTrajectoriesQ->at(i)->mRNodes->at(start2)->mTime);
        dis2 =
            gCTrajectoriesQ->at(i)->mRNodes->at(start2)->mDistance +
            ratio2 *
                (time2 - gCTrajectoriesQ->at(i)->mRNodes->at(end2)->mDistance -
                 gCTrajectoriesQ->at(i)->mRNodes->at(start2)->mDistance);
      }

      // cout<<"name: "<<i<<" -> "<<dis2-dis1<<" ";
    }
    // cout<<endl;
  }

  void DistanceWithoutIndex(int time) {

    int i, j;
    int start, end;
    Node *tTmpNode = NULL;
    Edge *tTmpEdge = NULL;
    double distance = 0;
    int tcount;
    int tcountMax;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {
      start = 0;
      end = gCTrajectoriesQ->at(i)->mRNodes->size() - 1;

      /* If the query time is less than the starting time or more than the
       * final
       * time, then ended */
      if (time < gCTrajectoriesQ->at(i)->mStartTime ||
          time > gCTrajectoriesQ->at(i)->mStartTime +
                     gCTrajectoriesQ->at(i)->mTimeInterval *
                         (gCTrajectoriesQ->at(i)->mSize - 1)) {
        gMeetQueryNumber--;
        continue;
      }

      tTmpNode = gGraph->GetNodeById(gCTrajectoriesQ->at(i)->mStartNode);

      /* The tIntervals traveled by the two time point */
      tcountMax = (int)((time - gCTrajectoriesQ->at(i)->mStartTime) /
                        gCTrajectoriesQ->at(i)->mTimeInterval);
      distance = 0;
      tcount = 0;

      /* DecomtPress the codings and get the query result */
      for (j = 0; j < gCTrajectoriesQ->at(i)->mPCoding->size(); j++) {
        if (gCTrajectoriesQ->at(i)->mTCoding->at(j) == 1) {
          tcount++;
          if (tcount > tcountMax) {
            break;
          }
        }
        if (gCTrajectoriesQ->at(i)->mPCoding->at(j) == 0) {
          continue;
        } else {
          tTmpEdge = tTmpNode->GetOutEdgeById(
              gCTrajectoriesQ->at(i)->mPCoding->at(j) - 1);
          distance += tTmpEdge->GetLength();
          tTmpNode = tTmpEdge->GetEndNode();
        }
      }
      // cout << distance << endl;
    }
  }

  void Distance(int time) {

    int i;

    for (i = 0; i < (int)gCTrajectoriesQ->size(); i++) {
      int start = 0;
      int end = gCTrajectoriesQ->at(i)->mRNodes->size() - 1;

      if (time < gCTrajectoriesQ->at(i)->mStartTime ||
          time > gCTrajectoriesQ->at(i)->mStartTime +
                     gCTrajectoriesQ->at(i)->mTimeInterval *
                         (gCTrajectoriesQ->at(i)->mSize - 1)) {
        gMeetQueryNumber--;
        continue;
      }

      int tCenter = (start + end) / 2;
      while (tCenter != start) {
        if (time < gCTrajectoriesQ->at(i)->mRNodes->at(tCenter)->mTime) {
          end = tCenter;
        } else {
          start = tCenter;
        }
        tCenter = (start + end) / 2;
      }
      if ((gCTrajectoriesQ->at(i)->mRNodes->at(end)->mTime -
           gCTrajectoriesQ->at(i)->mRNodes->at(start)->mTime) == 0) {
        // cout<<"name: "<<i<<" ->
        // "<<gCTrajectoriesQ->at(i)->mRNodes->at(start)->mDistance<<" ";
        continue;
      }
      double ratio =
          (time - gCTrajectoriesQ->at(i)->mRNodes->at(start)->mTime) /
          (gCTrajectoriesQ->at(i)->mRNodes->at(end)->mTime -
           gCTrajectoriesQ->at(i)->mRNodes->at(start)->mTime);
      // cout << "name: " << i << " -> "<<
      // gCTrajectoriesQ->at(i)->mRNodes->at(start)->mDistance +ratio *(time -
      // gCTrajectoriesQ->at(i)->mRNodes->at(end)->mDistance
      // -gCTrajectoriesQ->at(i)->mRNodes->at(start)->mDistance)<< " ";
    }
    // cout<<endl;
  }
};

#endif
