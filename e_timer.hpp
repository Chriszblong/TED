#ifndef __ETIMER_HPP__
#define __ETIMER_HPP__

#include "e_header.h"
#include "e_tool.hpp"
#include <ctime>
#include <iostream>
#include <stdio.h>
#include <time.h>
using namespace std;

class Timer {
public:
  clock_t GetStart() { return this->mStart; }

  void SetStart(clock_t start) { this->mStart = start; }

  clock_t GetFinish() { return this->mFinish; }

  void SetFinish(clock_t finish) { this->mFinish = finish; }

  void ResetStart() { this->mStart = clock(); }

  void ResetFinish() { this->mFinish = clock(); }

  double GetDuration() {
    return (double)(this->mFinish - this->mStart) / CLOCKS_PER_SEC;
  }

  void Write2File() {

    FileWriter *writer = new FileWriter(TIME_FILE.c_str(), false);
    char *s;

    time_t tTimePtr;

    time(&tTimePtr);

    s = ctime(&tTimePtr);

    for (int i = 0; i < strlen(s); i++) {
      writer->WriteChar(s[i]);
    }

    writer->WriteChar(' ');
    writer->WriteDouble(GetDuration());
    writer->WriteChar('\n');
  }
  void Write2File(double ratio) {

    FileWriter *writer = new FileWriter(TIME_FILE.c_str(), false);
    char *s;

    time_t tTimePtr;

    time(&tTimePtr);

    s = ctime(&tTimePtr);

    for (int i = 0; i < strlen(s); i++) {
      writer->WriteChar(s[i]);
    }

    writer->WriteChar(' ');
    writer->WriteDouble(GetDuration() / ratio);
    writer->WriteChar('\n');
  }

private:
  clock_t mStart, mFinish;
};

#endif
