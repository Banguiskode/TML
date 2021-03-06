g++ tcgen.cpp # compile a program that outputs a tml program calculating transitive closure over a circular graph with $1 vertices
./a.out $1 > $1 # output the tml program into a file
cd ../src
rm CMakeCache.txt
cmake .
make -j4
#g++ -std=c++1y tree.cpp transform.cpp output.cpp bdd.cpp dict.cpp driver.cpp input.cpp lp.cpp main.cpp query.cpp rule.cpp -W -Wall -Wpedantic -otml -O3 -flto # compile tml with optimization flags
cd -
/usr/bin/time -v ../src/tml < $1 > r # run tml, sort the output and save it into file "r"
sort r > r1
g++ tcres.cpp # compile a program that prints the desired result
./a.out $1 | sort > t # run it and output into file "t"
rm a.out # cleanup
diff -w r1 t # diff files "r" and "t"
