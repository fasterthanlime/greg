EXAMPLES = test test-greg rule rule-greg accept accept-greg wc dc-greg dc dcv dcv-greg calc basic

CFLAGS = -g -O3

DIFF = diff
TEE = cat >

all : $(EXAMPLES)

test : .FORCE
	../rpeg -o test.peg.c test.peg
	$(CC) $(CFLAGS) -o test test.c
	echo 'ab.ac.ad.ae.afg.afh.afg.afh.afi.afj.' | ./$@ | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

test-greg : .FORCE
	../greg -o $(@:-greg=.leg).c $(@:-greg=.leg)
	sed -e 's/[.]peg[.]c/.leg.c/g' $(@:-greg=.c) > $@.c
	$(CC) $(CFLAGS) -o $@ $@.c
	echo 'ab.ac.ad.ae.afg.afh.afg.afh.afi.afj.' | ./$@ | $(TEE) $@.out
	$(DIFF) $(@:-greg=.ref) $@.out
	rm -f $@.out
	@echo

rule : .FORCE
	../rpeg -o rule.peg.c rule.peg
	$(CC) $(CFLAGS) -o rule rule.c
	echo 'abcbcdabcbcdabcbcdabcbcd' | ./$@ | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

rule-greg : .FORCE
	../greg -o $(@:-greg=.leg).c $(@:-greg=.leg)
	sed -e 's/[.]peg[.]c/.leg.c/g' $(@:-greg=.c) > $@.c
	$(CC) $(CFLAGS) -o $@ $@.c
	echo 'abcbcdabcbcdabcbcdabcbcd' | ./$@ | $(TEE) $@.out
	$(DIFF) $(@:-greg=.ref) $@.out
	rm -f $@.out
	@echo

accept : .FORCE
	../rpeg -o accept.peg.c accept.peg
	$(CC) $(CFLAGS) -o accept accept.c
	echo 'abcbcdabcbcdabcbcdabcbcd' | ./$@ | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

accept-greg : .FORCE
	../greg -o $(@:-greg=.leg).c $(@:-greg=.leg)
	sed -e 's/[.]peg[.]c/.leg.c/g' $(@:-greg=.c) > $@.c
	$(CC) $(CFLAGS) -o $@ $@.c
	echo 'abcbcdabcbcdabcbcdabcbcd' | ./$@ | $(TEE) $@.out
	$(DIFF) $(@:-greg=.ref) $@.out
	rm -f $@.out
	@echo

wc : .FORCE
	../greg -o wc.leg.c wc.leg
	$(CC) $(CFLAGS) -o wc wc.leg.c
	cat wc.leg | ./$@ | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

dc : .FORCE
	../rpeg -o dc.peg.c dc.peg
	$(CC) $(CFLAGS) -o dc dc.c
	echo '  2  *3 *(3+ 4) ' | ./dc | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

dc-greg : .FORCE
	../greg -o $(@:-greg=.leg).c $(@:-greg=.leg)
	sed -e 's/[.]peg[.]c/.leg.c/g' $(@:-greg=.c) > $@.c
	$(CC) $(CFLAGS) -o $@ $@.c
	echo '  2  *3 *(3+ 4) ' | ./$@ | $(TEE) $@.out
	$(DIFF) $(@:-greg=.ref) $@.out
	rm -f $@.out
	@echo

dcv : .FORCE
	../rpeg -o dcv.peg.c dcv.peg
	$(CC) $(CFLAGS) -o dcv dcv.c
	echo 'a = 6;  b = 7;  a * b' | ./dcv | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

dcv-greg : .FORCE
	../greg -o $(@:-greg=.leg).c $(@:-greg=.leg)
	sed -e 's/[.]peg[.]c/.leg.c/g' $(@:-greg=.c) > $@.c
	$(CC) $(CFLAGS) -o $@ $@.c
	echo 'a = 6;  b = 7;  a * b' | ./$@ | $(TEE) $@.out
	$(DIFF) $(@:-greg=.ref) $@.out
	rm -f $@.out
	@echo

calc : .FORCE
	../greg -o calc.leg.c calc.leg
	$(CC) $(CFLAGS) -o calc calc.leg.c
	echo 'a = 6;  b = 7;  a * b' | ./calc | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

basic : .FORCE
	../greg -o basic.leg.c basic.leg
	$(CC) $(CFLAGS) -o basic basic.leg.c
	( echo 'load "test"'; echo "run" ) | ./basic | $(TEE) $@.out
	$(DIFF) $@.ref $@.out
	rm -f $@.out
	@echo

clean : .FORCE
	rm -f *~ *.o *.[pl]eg.[cd] $(EXAMPLES) *-greg.c
	rm -rf *.dSYM

spotless : clean

.FORCE :
