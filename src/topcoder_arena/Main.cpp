#include "Timer.h"
#include "spdlog/spdlog.h"
#include "TopCoderABC.h"

int main(int argc, char* argv[])
{
   spdlog::set_pattern("[%H:%M:%S %z] [%n] [%^---%L---%$] [thread %t] %v");
   using millis = std::chrono::milliseconds;
   using micros = std::chrono::microseconds;

   size_t temp = 0;
   Timer tmr;
   TopCoderABC::createString(1, 1);
   tmr.lap().report(Timer::duration_t::millis);

	return 0;
}