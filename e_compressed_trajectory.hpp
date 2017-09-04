#ifndef __ECOMPRESSED_TRAJECTORY_HPP__
#define __ECOMPRESSED_TRAJECTORY_HPP__

#include "e_graphic.hpp"
#include "e_partition.hpp"
#include "e_pddp.hpp"
#include "e_tool.hpp"
#include <iostream>
#include <string>
#include <vector>
using namespace std;

class CompressedTrajectory;
class CompressedTrajectoryQ;

vector<CompressedTrajectory *> *gCTrajectories =
    new vector<CompressedTrajectory *>();
vector<CompressedTrajectoryQ *> *gCTrajectoriesQ =
    new vector<CompressedTrajectoryQ *>();

class Qnode {
public:
  double mTime;
  double mDistance;
  int mOrder;
  int mId;

  Qnode(double time, double dis, int order, int id) {
    this->mTime = time;
    this->mDistance = dis;
    this->mOrder = order;
    this->mId = id;
  }
};

class CompressedTrajectory {
public:
  int mStartTime;
  double mTimeInterval;
  int mStartNode;
  int mPNumber, mLNumber, mTNumber;
  vector<unsigned char> *mPCoding, *mTCoding, *mLCoding;

  CompressedTrajectory() {
    mStartTime = 0;
    mTimeInterval = 30;
    mPCoding = new vector<unsigned char>();
    mTCoding = new vector<unsigned char>();
    mLCoding = new vector<unsigned char>();
  }

  ~CompressedTrajectory() {
    delete this->mPCoding;
    delete this->mTCoding;
    delete this->mLCoding;
  }

  int ByteNumber(int number) { return number / 8 + (number % 8 ? 1 : 0); }

  CompressedTrajectory(FileReader *tPReader, FileReader *tLReader,
                       FileReader *tTReader, FileReader *tIntervatLReader) {
    int i;
    int tByteNumber;

    mStartTime = tIntervatLReader->GetNextInt();
    mStartNode = tIntervatLReader->GetNextInt();
    mTimeInterval = tIntervatLReader->GetNextDouble();

    mPCoding = new vector<unsigned char>();
    mTCoding = new vector<unsigned char>();
    mLCoding = new vector<unsigned char>();
    mPNumber = tPReader->GetNextInt();

    tByteNumber = this->ByteNumber(mPNumber);
    for (i = 0; i < tByteNumber; i++) {
      mPCoding->push_back(tPReader->GetNextChar());
    }

    mLNumber = tLReader->GetNextInt();
    tByteNumber = this->ByteNumber(mLNumber);
    for (i = 0; i < tByteNumber; i++) {
      mLCoding->push_back(tLReader->GetNextChar());
    }

    mTNumber = tTReader->GetNextInt();
    tByteNumber = this->ByteNumber(mTNumber);
    for (i = 0; i < tByteNumber; i++) {
      mTCoding->push_back(tTReader->GetNextChar());
    }
  }

  void Show() {

    int i;

    cout << "tStart time:" << mStartTime << endl;
    cout << "time interval:" << mTimeInterval << endl;
    cout << "mPCoding:" << endl;

    for (i = 0; i < (int)mPCoding->size(); i++) {
      cout << mPCoding->at(i);
    }

    cout << endl;
    cout << "mLCoding:";
    for (i = 0; i < (int)mLCoding->size(); i++) {
      cout << mLCoding->at(i);
    }

    cout << endl;
    cout << "mTCoding:" << endl;
    for (i = 0; i < (int)mTCoding->size(); i++) {
      cout << mTCoding->at(i);
    }
    cout << endl;
  }
};

class CompressedTrajectoryQ {
public:
  int mStartTime;
  double mTimeInterval;
  int mStartNode;
  int mSize;

  vector<unsigned char> *mTCoding, *mPCoding;
  vector<double> *mLCoding;
  vector<Qnode *> *mRNodes;

  CompressedTrajectoryQ() {
    mStartTime = 0;
    mTimeInterval = 30;

    mPCoding = new vector<unsigned char>();
    mTCoding = new vector<unsigned char>();
    mLCoding = new vector<double>();
    mRNodes = new vector<Qnode *>();
  }

  ~CompressedTrajectoryQ() {
    delete this->mPCoding;
    delete this->mTCoding;
    delete this->mLCoding;

    for (int i = 0; i < (int)this->mRNodes->size(); i++) {
      delete this->mRNodes->at(i);
    }

    delete this->mRNodes;
  }

  int ByteNumber(int number) { return number / 8 + (number % 8 ? 1 : 0); }

  CompressedTrajectoryQ(FileReader *tPReader, FileReader *tLReader,
                        FileReader *tTReader, FileReader *tIntervatLReader) {

    int i;
    int ByteNumber;

    mStartTime = tIntervatLReader->GetNextInt();
    mStartNode = tIntervatLReader->GetNextInt();
    mTimeInterval = tIntervatLReader->GetNextDouble();

    mPCoding = new vector<unsigned char>();
    mTCoding = new vector<unsigned char>();
    mLCoding = new vector<double>();
    mRNodes = new vector<Qnode *>();

    Binary *pb = new Binary(tPReader);
    for (i = 0; i < pb->mNumber; i += ENTRY_NUM) {
      switch (ENTRY_NUM) {
      case 3:
        mPCoding->push_back(pb->mBinary->at(i) * 4 +
                            pb->mBinary->at(i + 1) * 2 +
                            pb->mBinary->at(i + 2));
        break;
      case 4:
        mPCoding->push_back(
            pb->mBinary->at(i) * 8 + pb->mBinary->at(i + 1) * 4 +
            pb->mBinary->at(i + 2) * 2 + pb->mBinary->at(i + 3));
        break;
      case 5:
        mPCoding->push_back(
            pb->mBinary->at(i) * 16 + pb->mBinary->at(i + 1) * 8 +
            pb->mBinary->at(i + 2) * 4 + pb->mBinary->at(i + 3) * 2 +
            pb->mBinary->at(i + 4));
        break;
      default:
        mPCoding->push_back(pb->mBinary->at(i) * 4 +
                            pb->mBinary->at(i + 1) * 2 +
                            pb->mBinary->at(i + 2));
        break;
      }
    }

    Binary *tTBinary = new Binary(tTReader);
    for (i = 0; i < tTBinary->mNumber; i++) {
      mTCoding->push_back(tTBinary->mBinary->at(i));
      mLCoding->push_back(-1);
    }

    Binary *tLBinary = new Binary(tLReader);
    int tTmpPos = 0;

    for (i = 0; i < tLBinary->mNumber;) {
      DPNode *tTmpNode = gTree;
      while (tTmpNode && i < tLBinary->mNumber) {

        if (tLBinary->mBinary->at(i) && tTmpNode->mRight) {
          tTmpNode = tTmpNode->mRight;
          i++;
        } else if (!tLBinary->mBinary->at(i) && tTmpNode->mLeft) {
          tTmpNode = tTmpNode->mLeft;
          i++;
        } else {
          break;
        }
      }

      while (!mTCoding->at(tTmpPos)) {
        tTmpPos++;
      }

      mLCoding->at(tTmpPos) = tTmpNode->mRatio;
    }

    double tdis = 0;

    Node *tStartNode = gGraph->GetNodeById(mStartNode);
    Edge *tStartEdge;

    int tPreEdge = -1;
    int tPreGrid = -1;
    int tInterNumber = 0;

    for (i = 0; i < (int)mTCoding->size(); i++) {
      if (!mTCoding->at(i)) {

        tStartEdge = tStartNode->GetOutEdgeById(mPCoding->at(i) - 1);
        tStartNode = tStartEdge->GetEndNode();
        tPreEdge = tStartEdge->GetId();
        tdis += tStartEdge->GetLength();
      } else {
        tInterNumber++;
        if (mPCoding->at(i)) {
          tStartEdge = tStartNode->GetOutEdgeById(mPCoding->at(i) - 1);
          tPreEdge = tStartEdge->GetId();
          int tTmpNodeG = gPartionIndex->Convert2int(tStartNode);
          if (tTmpNodeG != tPreGrid) {
            mRNodes->push_back(
                new Qnode(mStartTime + mTimeInterval * tInterNumber,
                          tdis + tStartEdge->GetLength() * mLCoding->at(i), i,
                          tStartEdge->GetId()));
          }
          tdis += tStartEdge->GetLength();
          tPreGrid = tTmpNodeG;
          tStartNode = tStartEdge->GetEndNode();
        }
      }
    }
    this->mSize = tInterNumber;
  }
  void Show() {

    int i;

    cout << "tStart time:" << mStartTime << endl;
    cout << "time interval:" << mTimeInterval << endl;
    cout << "mPCoding:" << endl;
    for (i = 0; i < (int)mPCoding->size(); i++) {
      cout << mPCoding->at(i);
    }

    cout << endl;
    cout << "mLCoding:";
    for (i = 0; i < (int)mLCoding->size(); i++) {
      cout << mLCoding->at(i);
    }

    cout << endl;
    cout << "mTCoding:" << endl;
    for (i = 0; i < (int)mTCoding->size(); i++) {
      cout << mTCoding->at(i);
    }
    cout << endl;
  }
};

void LoadCompressedgTrajectories(const char *pname, const char *lname,
                                 const char *tname, const char *intervalname) {

  int i;

  FileReader *tPReader = new FileReader(pname, true);
  FileReader *tLReader = new FileReader(lname, true);
  FileReader *tTReader = new FileReader(tname, true);
  FileReader *tIntervatLReader = new FileReader(intervalname, false);

  int tTraSize = tPReader->GetNextInt();
  tLReader->GetNextInt();
  tTReader->GetNextInt();
  tIntervatLReader->GetNextInt();

  for (i = 0; i < tTraSize; i++) {
    gCTrajectories->push_back(new CompressedTrajectory(
        tPReader, tLReader, tTReader, tIntervatLReader));
  }
}

void LoadCompressedgTrajectoriesQ(const char *pname, const char *lname,
                                  const char *tname, const char *intervalname) {

  FileReader *tPReader = new FileReader(pname, true);
  FileReader *tLReader = new FileReader(lname, true);
  FileReader *tTReader = new FileReader(tname, true);
  FileReader *tIntervatLReader = new FileReader(intervalname, false);

  int tTraSize = tPReader->GetNextInt();
  tLReader->GetNextInt();
  tTReader->GetNextInt();
  tIntervatLReader->GetNextInt();

  for (int i = 0; i < tTraSize; i++) {
    gCTrajectoriesQ->push_back(new CompressedTrajectoryQ(
        tPReader, tLReader, tTReader, tIntervatLReader));
  }
}

#endif
