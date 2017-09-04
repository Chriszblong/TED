#ifndef _EMATRIX_HPP_
#define _EMATRIX_HPP_

#include "e_tool.hpp"
#include <vector>

/*
* Copyright (c) 2016, Yang Kai
* All rights reserved.
*
* File Name: ematrix.h
* File Identifier: --
* Abstract: --
*
* Current Version: 1.1
* Author: Yang Kai
* Date for Completion: 2016/07/20
*
* Replace Version: 1.0
* Original Author: Yang Kai
* Date for Completion: 2016/05/10
*/

class EMATRIX {
public:
  static vector<vector<bool> *> mDataMatrix;
  static vector<vector<bool> *> mResultMatrixHeader;
  static vector<vector<bool> *> mResultMatrixContent;
  static vector<int> mOrder;

  static int mEntryNumber;
  static int mGroupInnerNumber;

  static void LoadDataSetFromFile(FileReader *reader) {

    int i;

    int ttTraSize = reader->GetNextInt();

    for (i = 0; i < ttTraSize; i++) {
      Binary *ttra = new Binary(reader);
      EMATRIX::mDataMatrix.push_back(ttra->mBinary);
      EMATRIX::mResultMatrixContent.push_back(new vector<bool>());
      if (i % EMATRIX::mGroupInnerNumber == 0) {
        EMATRIX::mResultMatrixHeader.push_back(new vector<bool>());
      }
      EMATRIX::mOrder.push_back(i);
    }
  }

  static void SortDataSet() {

    int i, j;

    for (i = 0; i < (int)EMATRIX::mDataMatrix.size(); i++) {
      for (j = 0; j < (int)EMATRIX::mDataMatrix.size() - i - 1; j++) {
        if ((int)EMATRIX::mDataMatrix[j + 1]->size() <
            (int)EMATRIX::mDataMatrix[j]->size()) {

          mOrder[j + 1] = mOrder[j + 1] + mOrder[j];
          mOrder[j] = mOrder[j + 1] - mOrder[j];
          mOrder[j + 1] = mOrder[j + 1] - mOrder[j];

          vector<bool> *tmp = mDataMatrix[j + 1];
          mDataMatrix[j + 1] = mDataMatrix[j];
          mDataMatrix[j] = tmp;
        }
      }
    }
  }

  static void ReSortDataSet() {

    int i, j;

    for (i = 0; i < (int)EMATRIX::mDataMatrix.size(); i++) {
      for (j = 0; j < (int)EMATRIX::mDataMatrix.size() - i - 1; j++) {
        if (mOrder[j + 1] < mOrder[j]) {

          mOrder[j + 1] = mOrder[j + 1] + mOrder[j];
          mOrder[j] = mOrder[j + 1] - mOrder[j];
          mOrder[j + 1] = mOrder[j + 1] - mOrder[j];

          vector<bool> *tmp = mDataMatrix[j + 1];
          mDataMatrix[j + 1] = mDataMatrix[j];
          mDataMatrix[j] = tmp;
        }
      }
    }
  }

  static void PrintDataSet() {

    int i, j;

    cout << (int)EMATRIX::mDataMatrix.size() << endl;
    for (i = 0; i < (int)EMATRIX::mDataMatrix.size(); i++) {

      for (j = 0; j < (int)EMATRIX::mDataMatrix[i]->size(); j++) {
        cout << EMATRIX::mDataMatrix[i]->at(j);
      }

      cout << endl;
    }
    cout << endl;
  }

  static void PrintCompressed() {

    int i, j;

    cout << (int)EMATRIX::mDataMatrix.size() << endl;
    for (i = 0; i < (int)EMATRIX::mDataMatrix.size(); i++) {
      if (i % EMATRIX::mGroupInnerNumber == 0) {
        for (j = 0;
             j <
             (int)EMATRIX::mResultMatrixHeader[i / EMATRIX::mGroupInnerNumber]
                 ->size();
             j++) {
          cout << EMATRIX::mResultMatrixHeader[i / EMATRIX::mGroupInnerNumber]
                      ->at(j);
        }
        cout << endl;
      }

      for (j = 0; j < (int)EMATRIX::mResultMatrixContent[i]->size(); j++) {
        cout << EMATRIX::mResultMatrixContent[i]->at(j);
      }

      cout << endl;
    }
    cout << endl;
  }

  static void Clear() {

    EMATRIX::mDataMatrix.clear();
    EMATRIX::mResultMatrixHeader.clear();
    EMATRIX::mResultMatrixContent.clear();
    EMATRIX::mEntryNumber = 0;
    EMATRIX::mGroupInnerNumber = 0;
  }

  static void LoadCompressedFromFile(FileReader *reader) {

    int tPathNumber = reader->GetNextInt();
    EMATRIX::mGroupInnerNumber = reader->GetNextInt();

    int i, j;

    for (i = 0; i < tPathNumber; i++) {
      EMATRIX::mOrder.push_back(reader->GetNextInt());
    }

    for (i = 0; i < tPathNumber; i++) {

      if (i % EMATRIX::mGroupInnerNumber == 0) {
        Binary *binaryHeader = new Binary(reader);
        EMATRIX::mResultMatrixHeader.push_back(binaryHeader->mBinary);
      }

      Binary *binaryInner = new Binary(reader);
      EMATRIX::mResultMatrixContent.push_back(binaryInner->mBinary);
      EMATRIX::mDataMatrix.push_back(new vector<bool>());
    }
  }

  static void SaveDataSetToFile(FileWriter *writer) {

    int i, j;
    writer->WriteInt((int)EMATRIX::mDataMatrix.size());

    for (i = 0; i < (int)EMATRIX::mDataMatrix.size(); i++) {
      Binary *tmp = new Binary(EMATRIX::mDataMatrix[i]);
      tmp->Store(writer);
    }
  }

  static void SaveCompressedToFile(FileWriter *writer) {

    writer->WriteInt((int)EMATRIX::mDataMatrix.size());
    writer->WriteInt(EMATRIX::mGroupInnerNumber);

    int i, j;

    for (i = 0; i < (int)EMATRIX::mDataMatrix.size(); i++) {
      writer->WriteInt(EMATRIX::mOrder[i]);
    }

    for (i = 0; i < (int)EMATRIX::mDataMatrix.size(); i++) {
      if (i % EMATRIX::mGroupInnerNumber == 0) {
        Binary *binaryHeader = new Binary(
            EMATRIX::mResultMatrixHeader[i / EMATRIX::mGroupInnerNumber]);
        binaryHeader->Store(writer);
      }
      Binary *binaryInner = new Binary(EMATRIX::mResultMatrixContent[i]);
      binaryInner->Store(writer);
    }
  }

  static void BasicPathDecomp() {
    int i, j, k, l;

    int tGroupNum =
        (int)EMATRIX::mDataMatrix.size() % EMATRIX::mGroupInnerNumber == 0
            ? (int)EMATRIX::mDataMatrix.size() / EMATRIX::mGroupInnerNumber
            : (int)EMATRIX::mDataMatrix.size() / EMATRIX::mGroupInnerNumber + 1;

    for (i = 0; i < tGroupNum; i++) {

      int tGroupInnerNumber =
          EMATRIX::mGroupInnerNumber * i + EMATRIX::mGroupInnerNumber >=
                  (int)EMATRIX::mDataMatrix.size()
              ? (int)EMATRIX::mDataMatrix.size() -
                    EMATRIX::mGroupInnerNumber * i
              : EMATRIX::mGroupInnerNumber;

      int tPos = 0;

      for (k = 0; k < (int)EMATRIX::mResultMatrixHeader[i]->size(); k++) {
        int tInPos;
        for (j = 0; j < tGroupInnerNumber; j++) {
          tInPos = tPos;
          if (EMATRIX::mResultMatrixHeader[i]->at(k) == false) {
            EMATRIX::mDataMatrix[i * EMATRIX::mGroupInnerNumber + j]->push_back(
                false);
            for (l = 0; l < EMATRIX::mEntryNumber - 1; l++) {
              EMATRIX::mDataMatrix[i * EMATRIX::mGroupInnerNumber + j]
                  ->push_back(EMATRIX::mResultMatrixContent
                                  [i * EMATRIX::mGroupInnerNumber + j]
                                      ->at(tInPos++));
            }
          } else {
            for (l = 0; l < EMATRIX::mEntryNumber; l++) {
              EMATRIX::mDataMatrix[i * EMATRIX::mGroupInnerNumber + j]
                  ->push_back(EMATRIX::mResultMatrixContent
                                  [i * EMATRIX::mGroupInnerNumber + j]
                                      ->at(tInPos++));
            }
          }
        }
        tPos = tInPos;
      }
      for (l = i * EMATRIX::mGroupInnerNumber;
           l < i * EMATRIX::mGroupInnerNumber + tGroupInnerNumber; l++) {
        for (k = tPos; k < (int)EMATRIX::mResultMatrixContent[l]->size(); k++) {
          EMATRIX::mDataMatrix[l]->push_back(
              EMATRIX::mResultMatrixContent[l]->at(k));
        }
      }
    }
  }
  static void BasicPathComp() {
    int i, j, k, l;

    int tGroupNum =
        (int)EMATRIX::mDataMatrix.size() % EMATRIX::mGroupInnerNumber == 0
            ? (int)EMATRIX::mDataMatrix.size() / EMATRIX::mGroupInnerNumber
            : (int)EMATRIX::mDataMatrix.size() / EMATRIX::mGroupInnerNumber + 1;
    for (i = 0; i < tGroupNum; i++) {

      int tGroupInnerNumber =
          EMATRIX::mGroupInnerNumber * i + EMATRIX::mGroupInnerNumber >=
                  (int)EMATRIX::mDataMatrix.size()
              ? (int)EMATRIX::mDataMatrix.size() -
                    EMATRIX::mGroupInnerNumber * i
              : EMATRIX::mGroupInnerNumber;
      for (k = 0;
           k <
           (int)EMATRIX::mDataMatrix[EMATRIX::mGroupInnerNumber * i]->size();
           k += EMATRIX::mEntryNumber) {

        for (j = 0; j < tGroupInnerNumber; j++) {
          if (EMATRIX::mDataMatrix[i * EMATRIX::mGroupInnerNumber + j]->at(k) ==
              true) {
            break;
          }
        }
        if (j == tGroupInnerNumber) {
          EMATRIX::mResultMatrixHeader[i]->push_back(false);
          for (l = 0; l < tGroupInnerNumber; l++) {
            for (j = 1; j < EMATRIX::mEntryNumber; j++) {
              EMATRIX::mResultMatrixContent[i * EMATRIX::mGroupInnerNumber + l]
                  ->push_back(
                      EMATRIX::mDataMatrix[i * EMATRIX::mGroupInnerNumber + l]
                          ->at(k + j));
            }
          }
        } else {
          EMATRIX::mResultMatrixHeader[i]->push_back(true);
          for (l = 0; l < tGroupInnerNumber; l++) {
            for (j = 0; j < EMATRIX::mEntryNumber; j++) {
              EMATRIX::mResultMatrixContent[i * EMATRIX::mGroupInnerNumber + l]
                  ->push_back(
                      EMATRIX::mDataMatrix[i * EMATRIX::mGroupInnerNumber + l]
                          ->at(k + j));
            }
          }
        }
      }
      for (j = 0; j < tGroupInnerNumber; j++) {
        for (k = EMATRIX::mEntryNumber *
                 (int)EMATRIX::mResultMatrixHeader[i]->size();
             k < (int)EMATRIX::mDataMatrix[j + i * EMATRIX::mGroupInnerNumber]
                     ->size();
             k++) {
          EMATRIX::mResultMatrixContent[i * EMATRIX::mGroupInnerNumber + j]
              ->push_back(
                  EMATRIX::mDataMatrix[i * EMATRIX::mGroupInnerNumber + j]->at(
                      k));
        }
      }
    }
  }
};

vector<vector<bool> *> EMATRIX::mDataMatrix;
vector<vector<bool> *> EMATRIX::mResultMatrixHeader;
vector<vector<bool> *> EMATRIX::mResultMatrixContent;

int EMATRIX::mEntryNumber;
int EMATRIX::mGroupInnerNumber;
vector<int> EMATRIX::mOrder;

#endif
