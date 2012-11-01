# makefile template

include MakeInclude

PREFIX=/usr
BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/share/man

INSTALL= ginstall

LDLIBS =  

VLAN_OBJS = vconfig.o

ALL_OBJS = ${VLAN_OBJS}

VCONFIG = vconfig                  #program to be created


all: ${VCONFIG} #macvlan_config


#This is pretty silly..
vconfig.h: Makefile
	touch vconfig.h


$(VCONFIG): $(VLAN_OBJS)
	$(CC) $(CCFLAGS) $(LDFLAGS) -o $(VCONFIG) $(VLAN_OBJS) $(LDLIBS)

macvlan_config: macvlan_config.c
	$(CC) $(CCFLAGS) $(LDFLAGS) -o $@ $<

$(ALL_OBJS): %.o: %.c %.h
	@echo " "
	@echo "Making $<"
	$(CC) $(CCFLAGS) -c $<

distclean:	clean

clean:
	rm -f *.o vconfig macvlan_config

purge: clean
	rm -f *.flc ${VCONFIG} macvlan_config vconfig.h
	rm -f *~


install: all
	$(INSTALL) -D vconfig $(DESTDIR)$(BINDIR)/vconfig
	$(INSTALL) -D vconfig.8 $(DESTDIR)$(MANDIR)/man8/vconfig.8

