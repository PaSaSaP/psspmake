CC=gcc
CXX=g++
RM=rm -f
FLAGS=-g -fPIC -c
CFLAGS=${FLAGS} -std=c11
CXXFLAGS=${FLAGS} -std=c++11
LDFLAGS=
LDLIBS=-lpthread

SRCS= # list of source files
OBJECTS1:=$(subst .cpp,.o,${SRCS})
OBJECTS2:=$(subst .cxx,.o,${OBJECTS1})
OBJECTS3:=$(subst .cc,.o,${OBJECTS2})
OBJECTS:=$(subst .c,.o,${OBJECTS3})
EXEC_FILE=/tmp/${USER}_compiled_program
ARGS=

all: ${EXEC_FILE}

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

%.o: %.cpp %.cxx %.cc
	$(CXX) $(CXXFLAGS) $< -o $@

${EXEC_FILE}: ${OBJECTS}
	$(CXX) ${LDFLAGS} $^ -o $@ ${LDLIBS}

run: ${EXEC_FILE}
	${EXEC_FILE} ${ARGS}

.PHONY: clean

clean:
	${RM} ${OBJECTS} ${EXEC_FILE}

