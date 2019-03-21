#include "gtest/gtest.h"
#include "TopCoderABCTest.h"

int main(int argc, char* argv[])
{
   testing::InitGoogleTest(&argc, argv);
   int rc = RUN_ALL_TESTS();
   return rc;
}

