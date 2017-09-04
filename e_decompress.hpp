#ifndef __EDECOMPRESS_HPP__
#define __EDECOMPRESS_HPP__

#include "e_compressed_trajectory.hpp"
#include "e_graphic.hpp"
#include "e_pddp.hpp"
#include "e_tool.hpp"
#include "e_trajectory.hpp"
#include <math.h>

#define LOCATION(a, b, c) a + (b - a) * c

class DeCompress {
public:
  DeCompress() {}

  double GetRatio(int trapos, int &lcodingpos) {
    DPNode *tTmpNode = gTree;
    while (tTmpNode && lcodingpos < gCTrajectories->at(trapos)->mLNumber) {
      if ((gCTrajectories->at(trapos)->mLCoding->at(lcodingpos / 8) &
           MAPTABLE[lcodingpos % 8]) &&
          tTmpNode->mRight) {
        tTmpNode = tTmpNode->mRight;
        lcodingpos++;
      } else if (!(gCTrajectories->at(trapos)->mLCoding->at(lcodingpos / 8) &
                   MAPTABLE[lcodingpos % 8]) &&
                 tTmpNode->mRight) {
        tTmpNode = tTmpNode->mRight;
        lcodingpos++;
      } else {
        break;
      }
    }
    return tTmpNode->mRatio;
  }
  void deCompress(FileWriter *writer) {

    int i, j;

    Trajectory *tResultTra = new Trajectory();
    writer->WriteInt(gCTrajectories->size());
    for (j = 0; j < gCTrajectories->size(); j++) {

      tResultTra->mTrajectory.clear();
      traNode *tNewNode = new traNode();
      tResultTra->mId = j;

      int mStartNode = gCTrajectories->at(j)->mStartNode;
      int tLocationPos = 0;
      int tLL, &tCodePos = tLL;
      unsigned char tBeg = 0;

      switch (ENTRY_NUM) {
      case 3:
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[0]) {
          tBeg |= 4;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[1]) {
          tBeg |= 2;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[2]) {
          tBeg |= 1;
        }
        break;
      case 4:
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[0]) {
          tBeg |= 8;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[1]) {
          tBeg |= 4;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[2]) {
          tBeg |= 2;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[3]) {
          tBeg |= 1;
        }
        break;
      case 5:
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[0]) {
          tBeg |= 16;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[1]) {
          tBeg |= 8;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[2]) {
          tBeg |= 4;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[3]) {
          tBeg |= 2;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[4]) {
          tBeg |= 1;
        }
        break;
      default:
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[0]) {
          tBeg |= 4;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[1]) {
          tBeg |= 2;
        }
        if (gCTrajectories->at(j)->mPCoding->at(0) & MAPTABLE[2]) {
          tBeg |= 1;
        }
        break;
      }

      Edge *tCurrentEdge =
          gGraph->GetNodeById(mStartNode)->GetOutEdgeById(tBeg - 1);
      tNewNode->mTime = gCTrajectories->at(j)->mStartTime;

      double ratio = GetRatio(j, tCodePos);

      tNewNode->mLatitude =
          LOCATION(tCurrentEdge->GetStartNode()->GetLatitude(),
                   tCurrentEdge->GetEndNode()->GetLatitude(), ratio);
      tNewNode->mLongitude =
          LOCATION(tCurrentEdge->GetStartNode()->GetLongitude(),
                   tCurrentEdge->GetEndNode()->GetLongitude(), ratio);
      tResultTra->mTrajectory.push_back(tNewNode);

      for (i = 1; i < gCTrajectories->at(j)->mTNumber; i++) {
        tBeg = 0;

        switch (ENTRY_NUM) {
        case 3:
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i) / 8) &
              MAPTABLE[(ENTRY_NUM * i) % 8]) {
            tBeg |= 4;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 1) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 1) % 8]) {
            tBeg |= 2;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 2) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 2) % 8]) {
            tBeg |= 1;
          }
          break;
        case 4:
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i) / 8) &
              MAPTABLE[(ENTRY_NUM * i) % 8]) {
            tBeg |= 8;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 1) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 1) % 8]) {
            tBeg |= 4;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 2) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 2) % 8]) {
            tBeg |= 2;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 3) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 3) % 8]) {
            tBeg |= 1;
          }
          break;
        case 5:
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i) / 8) &
              MAPTABLE[(ENTRY_NUM * i) % 8]) {
            tBeg |= 16;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 1) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 1) % 8]) {
            tBeg |= 8;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 2) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 2) % 8]) {
            tBeg |= 4;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 3) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 3) % 8]) {
            tBeg |= 2;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 4) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 4) % 8]) {
            tBeg |= 1;
          }
          break;
        default:
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i) / 8) &
              MAPTABLE[(ENTRY_NUM * i) % 8]) {
            tBeg |= 4;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 1) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 1) % 8]) {
            tBeg |= 2;
          }
          if (gCTrajectories->at(j)->mPCoding->at((ENTRY_NUM * i + 2) / 8) &
              MAPTABLE[(ENTRY_NUM * i + 2) % 8]) {
            tBeg |= 1;
          }
          break;
        }

        if (tBeg) {
          tCurrentEdge = tCurrentEdge->GetEndNode()->GetOutEdgeById(tBeg - 1);
        }

        if (gCTrajectories->at(j)->mTCoding->at(i / 8) & MAPTABLE[i % 8]) {
          tLocationPos++;
          traNode *tNewNode1 = new traNode();
          tNewNode1->mTime =
              gCTrajectories->at(j)->mStartTime +
              gCTrajectories->at(j)->mTimeInterval * tLocationPos;
          ratio = GetRatio(j, tCodePos);
          tNewNode1->mLatitude =
              LOCATION(tCurrentEdge->GetStartNode()->GetLatitude(),
                       tCurrentEdge->GetEndNode()->GetLatitude(), ratio);
          tNewNode1->mLongitude =
              LOCATION(tCurrentEdge->GetStartNode()->GetLongitude(),
                       tCurrentEdge->GetEndNode()->GetLongitude(), ratio);
          tResultTra->mTrajectory.push_back(tNewNode1);
        }
      }

      tResultTra->Save2File(writer);
    }
  }
};

#endif
