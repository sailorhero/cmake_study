#!/bin/sh 

BuildPath=build
CPPCheckReport=cppcheck.xml
CPPCheckApp=`which cppcheck`
CPPNCSSReport=cppncss.xml
CPPNCSSApp=`which cppncss`
GCOVReport=gcovreport.xml
GCOVRApp=`which gcovr`

echo "BuildPath:$BuildPath"
#GTestReport=gtestreport.xml
if test -d "$BuildPath"; then 
     cd $BuildPath 
     echo "clean older build files "

     make clean
     #rm -rf build
     rm $BuildPath/*.gcov               > /dev/null
     rm $BuildPath/$CPPCheckReport      > /dev/null
     rm $BuildPath/$CPPNCSSReport  > /dev/null
     rm $BuildPath/$GCOVReport          > /dev/null
     rm -rf $BuildPath/xunit            > /dev/null  
else
     mkdir "$BuildPath"
     cd $BuildPath
fi

cmake  ..
export CPPFLAGS=" -fprofile-arcs -ftest-coverage"
export LDFLAGS=" -lgcov"
make

if  test -n "$BuildPath" ; then
     echo "Make Success"
     echo "Make CPPCheck Report $CPPCheckReport"
     $CPPCheckApp -v --enable=all --xml -I ../src -I ../libhello ../src  2> $CPPCheckReport

     echo "Make CCCC Report $CCCCReport"
     find ../src ../libhello -type f | grep -E '(*\.cc|*\.c|*\.hpp|*\.h|*\.cc)$' | xargs cccc --lang=c++ --outdir=.cccc

     echo "Make CPPNCSS Report $CPPNCSSReport"
     $CPPNCSSApp   -r -p -x -k -f=./$CPPNCSSReport ../src ../libhello

     echo "Make sloccount Report "
     sloccount --duplicates --wide --details ../src ../libhello > sloccount.sc
     
     echo "Run gtest Test Program, Make Test Report"
     export GTEST_OUTPUT="xml:xunit/"
     #make test
     
     echo "Make GCovr"
     #$GCOVRApp -x -r .. > $GCOVReport

else
     echo "Make Fail!"
fi
