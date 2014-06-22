#include "hello.h"
#include <gtest/gtest.h>
 
TEST(HelloTest, NameNotNull) { 
    ASSERT_STREQ("Hello World",hello("World"));

    ASSERT_STREQ("Hello GooooooooooooooooooooooooooooooooooooooD", 
    	hello("GooooooooooooooooooooooooooooooooooooooD"));    
}
 
TEST(HelloTest, NameIsNull) {
    ASSERT_STREQ("Hello ",hello(""));
    ASSERT_STREQ("Hello ",hello(NULL));
}
 
int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
