war1tool: war1tool.o
	$(CC) -o $@ $^ -lz -lpng

clean:
	rm -f war1tool war1tool.o
