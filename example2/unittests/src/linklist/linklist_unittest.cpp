#include "linklist.h"
#include "gtest/gtest.h"

TEST(LinkListTest, GetOrigin)
{
  int zyx = 10;
  EXPECT_TRUE(10 == GetOrigin(zyx));
  zyx = 20;
  EXPECT_TRUE(20 == GetOrigin(zyx));
  zyx = 30;
  EXPECT_TRUE(30 == GetOrigin(zyx));
  zyx = 40;
  EXPECT_TRUE(40 == GetOrigin(zyx));
}