CFLAGS = -g -Wall $(OFLAGS) $(XFLAGS)
OFLAGS = -O3 -DNDEBUG
#OFLAGS = -pg

OBJS = tree.o compile.o

all : greg rpeg

rpeg : rpeg.o $(OBJS)
	$(CC) $(CFLAGS) -o $@-new rpeg.o $(OBJS)
	mv $@-new $@

greg : greg.o $(OBJS)
	$(CC) $(CFLAGS) -o $@-new greg.o $(OBJS)
	mv $@-new $@

ROOT	=
PREFIX	= /usr
BINDIR	= $(ROOT)$(PREFIX)/bin

install : $(BINDIR)/rpeg $(BINDIR)/greg

$(BINDIR)/% : %
	cp -p $< $@
	strip $@

uninstall : .FORCE
	rm -f $(BINDIR)/rpeg
	rm -f $(BINDIR)/greg

rpeg.o : rpeg.c rpeg.peg-c

%.rpeg-c : %.rpeg
	./rpeg -o $@ $<

greg.o : greg.c

greg.c : greg.g
	./greg -o $@ $<

check : rpeg .FORCE
	./rpeg < rpeg.peg > rpeg.out
	diff rpeg.peg-c rpeg.out
	rm rpeg.out

test examples : .FORCE
	$(SHELL) -ec '(cd examples;  $(MAKE))'

clean : .FORCE
	rm -rf *~ *.o *.greg.[cd] *.rpeg.[cd]
	$(SHELL) -ec '(cd examples;  $(MAKE) $@)'

spotless : clean .FORCE
	rm -f rpeg
	rm -f greg
	$(SHELL) -ec '(cd examples;  $(MAKE) $@)'

.FORCE :
