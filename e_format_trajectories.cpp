#include "e_header.h"
#include "e_graphic.hpp"
#include "e_timer.hpp"
#include "e_tool.hpp"
#include "e_trajectory.hpp"
#include <iostream>
#include <string>
using namespace std;

int main(int argv, char *args[]) {

  FileWriter *tWriter = new FileWriter(args[1], false);

  Controller *tController = new Controller();
  tController->ReformatTrajectory(args[2], tWriter, args[3], args[4]);

  return 0;
}
