CFLAGS := -O2 -W -Wall -Wsign-compare -fsigned-char
CXXFLAGS := $(CFLAGS)
LDFLAGS :=

all: war1tool

win32: war1tool.exe

war1tool war1tool.exe: war1tool.o xmi2mid.o
	$(CXX) $(LDFLAGS) $^ -lz -lpng -o $@

clean:
	rm -f war1tool war1tool.o xmi2mid.o
