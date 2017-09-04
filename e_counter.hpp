#ifndef __ECOUNTER_HPP__
#define __ECOUNTER_HPP__

#include "e_graphic.hpp"
#include "e_tool.hpp"
#include <iostream>
using namespace std;

class Counter {
public:
  double GetInimSize(FileReader *inittreader) {

    double tInitTotal = 0;
    int tTraSize = inittreader->GetNextInt();

    for (int i = 0; i < tTraSize; i++) {
      int tTraId = inittreader->GetNextInt();

      int tTraLength = inittreader->GetNextInt();
      tInitTotal += tTraLength * 8 * (19 + 8 + 8);

      for (int j = 0; j < tTraLength; j++) {

        inittreader->GetNextInt();
        inittreader->GetNextDouble();
        inittreader->GetNextDouble();
        inittreader->GetNextInt();
      }
    }
    return tInitTotal;
  }

  double Getratio(FileReader *inittreader, FileReader *tPReader,
                  FileReader *tLReader, FileReader *tTReader, int indexed = 1) {
    double p_total = 0, t_total = 0, tLTotal = 0, tInitTotal = 0;
    int tTraSize = inittreader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      int tTraId = inittreader->GetNextInt();

      int tTraLength = inittreader->GetNextInt();
      tInitTotal += tTraLength * 8 * (19 + 8 + 8);
      for (int j = 0; j < tTraLength; j++) {
        inittreader->GetNextInt();
        inittreader->GetNextDouble();
        inittreader->GetNextDouble();
        inittreader->GetNextInt();
      }
    }

    tTraSize = tPReader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      Binary *bp = new Binary(tPReader);
      p_total += bp->mNumber;
    }

    tTraSize = tLReader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      if (!indexed) {
        int tLen = tLReader->GetNextInt();
        for (int j = 0; j < tLen; j++) {
          Binary *bl = new Binary(tLReader);
          tLTotal += bl->mNumber;
        }
      } else {
        Binary *bl = new Binary(tLReader);
        tLTotal += bl->mNumber;
      }
    }

    tTraSize = tTReader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      Binary *bt = new Binary(tTReader);
      t_total += bt->mNumber;
    }

    // cout<<tInitTotal / (p_total + tLTotal + t_total)<<endl;
    return tInitTotal / (p_total + tLTotal + t_total + 32 + 32);
  }

  double GetratioP(FileReader *inittreader, FileReader *tPReader) {
    double p_total = 0, tInitTotal = 0;
    int tTraSize = inittreader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      int tTraId = inittreader->GetNextInt();

      int tTraLength = inittreader->GetNextInt();
      tInitTotal += tTraLength * (4 * 8);
      for (int j = 0; j < tTraLength; j++) {
        inittreader->GetNextInt();
        inittreader->GetNextDouble();
        inittreader->GetNextDouble();
        inittreader->GetNextInt();
      }
    }
    tTraSize = tPReader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      Binary *t = new Binary(tPReader);
      p_total += t->mNumber;
    }
    p_total += 32;
    // cout<<tInitTotal /p_total<<endl;
    return tInitTotal / p_total;
  }
  double GetratioL(FileReader *inittreader, FileReader *tLReader, int indexed) {
    double tLTotal = 0, tInitTotal = 0;
    int tTraSize = inittreader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      int tTraId = inittreader->GetNextInt();

      int tTraLength = inittreader->GetNextInt();
      tInitTotal += tTraLength * (8 * 2 * 8);
      for (int j = 0; j < tTraLength; j++) {
        inittreader->GetNextInt();
        inittreader->GetNextDouble();
        inittreader->GetNextDouble();
        inittreader->GetNextInt();
      }
    }

    tTraSize = tLReader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {
      if (!indexed) {

        int tNum = tLReader->GetNextInt();
        for (int j = 0; j < tNum; j++) {
          Binary *t = new Binary(tLReader);
          tLTotal += t->mNumber;
        }
      } else {

        Binary *t = new Binary(tLReader);
        tLTotal += t->mNumber;
        delete t;
      }
    }
    tLReader->Close();
    return tInitTotal / tLTotal;
  }

  double GetratioT(FileReader *inittreader, FileReader *tPReader) {
    double p_total = 0, tInitTotal = 0;
    int tTraSize = inittreader->GetNextInt();

    for (int i = 0; i < tTraSize; i++) {

      int tTraId = inittreader->GetNextInt();
      int tTraLength = inittreader->GetNextInt();
      tInitTotal += tTraLength * (19 * 8);

      for (int j = 0; j < tTraLength; j++) {

        inittreader->GetNextInt();
        inittreader->GetNextDouble();
        inittreader->GetNextDouble();
        inittreader->GetNextInt();
      }
    }

    tTraSize = tPReader->GetNextInt();
    for (int i = 0; i < tTraSize; i++) {

      Binary *t = new Binary(tPReader);
      p_total += t->mNumber;
    }

    p_total += 32;
    return tInitTotal / p_total;
  }

  void Count_0_1_number(FileReader *reader) {
    int tTraSize = reader->GetNextInt();
    double num0 = 0, num1 = 0;
    for (int i = 0; i < tTraSize; i++) {
      Binary *bb = new Binary(reader);
      for (int j = 0; j < bb->mNumber; j++) {
        if (!bb->mBinary->at(j))
          num0++;
        else
          num1++;
      }
    }
    cout << num0 << "," << num1 << endl;
  }
};

#endif
