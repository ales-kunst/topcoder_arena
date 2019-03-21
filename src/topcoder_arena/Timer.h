#ifndef TIMER_H
#define TIMER_H

#include <string>
#include <chrono>
#include <vector>
#include <optional>
#include "fmt/format.h"

class Timer {

   using high_res_clock = std::chrono::high_resolution_clock;
   using steady_clock   = std::chrono::steady_clock;
   using secs_t         = std::chrono::seconds;
   using millis_t       = std::chrono::milliseconds;
   using micros_t       = std::chrono::microseconds;
   using nanos_t        = std::chrono::nanoseconds;

public:

   enum class duration_t {
      secs,
      millis,
      micros,
      nanos
   };

   std::string                           mName;
   steady_clock::time_point              mStartTime;
   std::vector<steady_clock::time_point> mSplits;

   Timer(std::string name = std::string("")) : mName(name), mStartTime(high_res_clock::now()) {}

   template<class T = std::chrono::milliseconds>
   Timer& lap() {
      mSplits.push_back(high_res_clock::now());
      return *this;
   }

   template<class T = std::chrono::milliseconds>
   std::optional<T> elapsed() const {
      return std::chrono::duration_cast<T>(mSplits.back() - mStartTime);
   }

   template<class T = std::chrono::milliseconds>
   std::optional<T> elapsed(size_t n) const {
      if (n > mSplits.size()) {
         return {};
      }
      return std::chrono::duration_cast<T>(mSplits[n] - mStartTime);
   }

   template<class T = std::chrono::milliseconds>
   std::optional<T> pop() {
      if (mSplits.empty()) {
         return {};
      }
      steady_clock::time_point last_split = mSplits.back();
      mSplits.erase(mSplits.back());
      return std::chrono::duration_cast<T>(last_split - mStartTime);
   }

   void reset() {
      mStartTime = high_res_clock::now();
      mSplits.clear();
   }

   size_t splitsSize() const {
      return mSplits.size();
   }

   std::optional<steady_clock::time_point> split(size_t n) {
      if (n > mSplits.size()) {
         return {};
      }
      return mSplits.at(n);
   }

   bool report(duration_t duration, size_t n) {
      if (mSplits.empty() || (n >= mSplits.size())) {
         return false;
      }

      switch (duration) {
      case duration_t::secs:
         fmt::print("Time elapsed: {} s", elapsed<secs_t>(n)->count());
         break;
      case duration_t::micros:
         fmt::print("Time elapsed: {} us", elapsed<micros_t>(n)->count());
         break;
      case duration_t::nanos:
         fmt::print("Time elapsed: {} ns", elapsed<nanos_t>(n)->count());
         break;
      default:
         fmt::print("Time elapsed: {} ms", elapsed<millis_t>(n)->count());
         break;
      }
      return true;
   }

   bool report(duration_t duration) {
      return report(duration, (mSplits.size() - 1));
   }

};

#endif
