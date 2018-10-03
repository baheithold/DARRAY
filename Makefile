OBJS = integer.o real.o string.o
EXECS = test-da
OOPTS = -Wall -Wextra -Werror -std=c99 -g -c
LOPTS = -Wall -Wextra -Werror -g

all: 	$(OBJS) test-da

integer.o: 	integer.h integer.c
		gcc $(OOPTS) integer.c

real.o: 	real.h real.c
		gcc $(OOPTS) real.c

string.o: 	string.h string.c
		gcc $(OOPTS) string.c

test-da.o: 	test-da.c da.c da.h integer.c integer.h
		gcc $(OOPTS) ./test-da.c

test-da: 	$(OBJS) test-da.o
		gcc $(LOPTS) $(OBJS) test-da.o -o test-da

test: 	test-da
		clear
		@echo Testing...
		@./test-da

clean:
		rm -f $(EXECS) *.o *.vgcore
