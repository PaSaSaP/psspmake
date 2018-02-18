CC=gcc
CXX=g++
RM=rm -f
STD=
ifeq ("${STD}", "")
	CSTD=c11
	CXXSTD=c++11
else
	CSTD=${STD}
	CXXSTD=${STD}
endif
FLAGS=-g -fPIC -c
CFLAGS=${FLAGS} -std=${CSTD}
CXXFLAGS=${FLAGS} -std=${CXXSTD}
LDFLAGS=
LDLIBS=-lpthread

SRCS= # list of source files
OBJECTS1:=$(subst .cpp,.o,${SRCS})
OBJECTS2:=$(subst .cxx,.o,${OBJECTS1})
OBJECTS3:=$(subst .cc,.o,${OBJECTS2})
OBJECTS:=$(subst .c,.o,${OBJECTS3})
EXEC_FILE=/tmp/$(shell echo ${USER} ${SCRC} | md5sum | cut -d' ' -f1)_compiled_program
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

