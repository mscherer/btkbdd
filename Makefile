# Bluetooth software keyboard
# Lubomir Rintel <lkundrak@v3.sk>
# License: GPL

CFLAGS += -Wall -g3
override LDFLAGS += $(shell pkg-config bluez --libs)
override LDFLAGS += -Wl,--as-needed

BINS = btkbdd
all: $(BINS)

btkbdd: main.o keyb.o sdp.o l2cap.o hci.o

keyb.o: btkbdd.h hid.h linux2hid.h
l2cap.o: btkbdd.h
main.o: btkbdd.h
sdp.o: btkbdd.h apple.h

$(BINS):
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

clean:
	rm -f *.o $(BINS)
