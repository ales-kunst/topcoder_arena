#ifndef _TOP_CODER_ABC_TEST_H
#define _TOP_CODER_ABC_TEST_H

#include "TopCoderABC.h"
#include "gtest/gtest.h"

class TopCoderABCTest : public ::testing::Test {
protected:
   // You can remove any or all of the following functions if its body
   // is empty.

   TopCoderABCTest() {
      // You can do set-up work for each test here.
   }

   ~TopCoderABCTest() override {
      // You can do clean-up work that doesn't throw exceptions here.
   }

   // If the constructor and destructor are not enough for setting up
   // and cleaning up each test, you can define the following methods:

   void SetUp() override {
      // Code here will be called immediately after the constructor (right
      // before each test).
   }

   void TearDown() override {
      // Code here will be called immediately after each test (right
      // before the destructor).
   }

   // Objects declared here can be used by all tests in the test case for TopCoderABC.
};

// Tests that the Foo::Bar() method does Abc.
TEST_F(TopCoderABCTest, CreateString) {

   EXPECT_EQ(TopCoderABC::createString(0, 0), std::string("Test String!"));
}

#endif // _TOP_CODER_ABC_TEST_H
