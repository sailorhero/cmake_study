BuildPath=build
CPPCheckReport=cppcheck.xml
CPPCheckApp=`which cppcheck`
CPPNCSSReport=cppncss.xml
CPPNCSSApp=`which cppncss`
GCOVReport=gcovreport.xml
GCOVRApp=`which gcovr`

SRCDir=src

#GTestReport=gtestreport.xml
mkdir $BuildPath
echo "clean older build files "
cd $BuildPath
make clean
rm build/*.gcov 		 	> /dev/null
rm build/$CPPCheckReport 	> /dev/null
rm build/$CPPNCSSReport 	> /dev/null
rm build/$GCOVReport 		> /dev/null
rm -rf build/xunit 			> /dev/null  

#export CFLAGS=" -fprofile-arcs -ftest-coverage"
export LDFLAGS=" -lgcov"
cmake -DCMAKE_C_FLAGS="-fprofile-arcs -ftest-coverage" ..

make

if  test -n "$BuildPath" ; then
     echo "Make Success"
     echo "Make CPPCheck Report $CPPCheckReport"
     $CPPCheckApp -v --enable=all --xml -I ../libhello ../src  2> $CPPCheckReport

     echo "Make CCCC Report $CCCCReport"
     find ../src ../libhello -type f | grep -E '(*\.cc|*\.c|*\.hpp|*\.h|*\.cc)$' | xargs cccc --lang=c++ --outdir=.cccc

     echo "Make CPPNCSS Report $CPPNCSSReport"
     $CPPNCSSApp   -r -p -x -k -f=./$CPPNCSSReport ../src ../libhello

     echo "Make sloccount Report "
     sloccount --duplicates --wide --details ../src ../libhello > sloccount.sc
     
     #echo "Run gtest Test Program, Make Test Report"
     #export GTEST_OUTPUT="xml:xunit/"
     #make test
     #$RunPath/vodservertest.out --gtest_output=xml:$GTestReport > /dev /null
     
     echo "Make GCovr"
     $GCOVRApp -x  > $GCOVReport
	 #-fprofile-arcs -ftest-coverage -fPIC
else
     echo "Make Fail!"
fi
