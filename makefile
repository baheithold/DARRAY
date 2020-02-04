OBJS = integer.o real.o string.o da.o
TESTS0 = 	da-0-0 da-0-1 da-0-2 da-0-3 da-0-4 da-0-5 da-0-6 da-0-7 da-0-8 \
				da-0-9
TEST_OBJS0 = da-0-0.o da-0-1.o da-0-2.o da-0-3.o da-0-4.o da-0-5.o da-0-6.o \
			 da-0-7.o da-0-8.o da-0-9.o
EXECS = test-da $(TESTS0)
OOPTS = -Wall -Wextra -std=c99 -g -c
LOPTS = -Wall -Wextra -g

all: 	$(OBJS) test-da $(TESTS0)

###############################################################################
# 													Modules for Primitive Types
# 	INTEGER
integer.o: 	integer.h integer.c
		gcc $(OOPTS) integer.c

# 	REAL
real.o: 	real.h real.c
		gcc $(OOPTS) real.c

# 	STRING
string.o: 	string.h string.c
		gcc $(OOPTS) string.c

###############################################################################
# 																		DA
da.o: 	da.c da.h
		gcc $(OOPTS) da.c

test-da.o: 	test-da.c da.c da.h integer.c integer.h real.c real.h string.c string.h
		gcc $(OOPTS) ./test-da.c

test-da: 	$(OBJS) test-da.o
		gcc $(LOPTS) $(OBJS) test-da.o -o test-da

###############################################################################
# 																		TEST
test: 	test-da
		clear
		@echo Testing...
		@./test-da

###############################################################################
# 																		TEST 0
da-0-0.o: 	./testing/0/da-0-0.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-0.c

da-0-1.o: 	./testing/0/da-0-1.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-1.c

da-0-2.o: 	./testing/0/da-0-2.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-2.c

da-0-3.o: 	./testing/0/da-0-3.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-3.c

da-0-4.o: 	./testing/0/da-0-4.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-4.c

da-0-5.o: 	./testing/0/da-0-5.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-5.c

da-0-6.o: 	./testing/0/da-0-6.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-6.c

da-0-7.o: 	./testing/0/da-0-7.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-7.c

da-0-8.o: 	./testing/0/da-0-8.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-8.c

da-0-9.o: 	./testing/0/da-0-9.c da.h da.h integer.h real.h string.h
		gcc $(OOPTS) ./testing/0/da-0-9.c

da-0-0: 	./testing/0/da-0-0.c $(OBJS) da-0-0.o
		gcc $(LOPTS) $(OBJS) da-0-0.o -o da-0-0

da-0-1: 	./testing/0/da-0-1.c $(OBJS) da-0-1.o
		gcc $(LOPTS) $(OBJS) da-0-1.o -o da-0-1

da-0-2: 	./testing/0/da-0-2.c $(OBJS) da-0-2.o
		gcc $(LOPTS) $(OBJS) da-0-2.o -o da-0-2

da-0-3: 	./testing/0/da-0-3.c $(OBJS) da-0-3.o
		gcc $(LOPTS) $(OBJS) da-0-3.o -o da-0-3

da-0-4: 	./testing/0/da-0-4.c $(OBJS) da-0-4.o
		gcc $(LOPTS) $(OBJS) da-0-4.o -o da-0-4

da-0-5: 	./testing/0/da-0-5.c $(OBJS) da-0-5.o
		gcc $(LOPTS) $(OBJS) da-0-5.o -o da-0-5

da-0-6: 	./testing/0/da-0-6.c $(OBJS) da-0-6.o
		gcc $(LOPTS) $(OBJS) da-0-6.o -o da-0-6

da-0-7: 	./testing/0/da-0-7.c $(OBJS) da-0-7.o
		gcc $(LOPTS) $(OBJS) da-0-7.o -o da-0-7

da-0-8: 	./testing/0/da-0-8.c $(OBJS) da-0-8.o
		gcc $(LOPTS) $(OBJS) da-0-8.o -o da-0-8

da-0-9: 	./testing/0/da-0-9.c $(OBJS) da-0-9.o
		gcc $(LOPTS) $(OBJS) da-0-9.o -o da-0-9

test0: 	$(TESTS_OBJS0)
		@for x in $(TESTS0); do \
			echo Testing $$x...; \
			./$$x > ./testing/0/actual/$$x.actual; \
			diff ./testing/0/expected/$$x.expected ./testing/0/actual/$$x.actual; \
			done

###############################################################################
# 																		VALGRIND
valgrind: 	test-da
		clear
		@echo Testing with Valgrind...
		@valgrind ./test-da

###############################################################################
# 																		CLEAN
clean:
		rm -f $(EXECS) *.o *.vgcore
