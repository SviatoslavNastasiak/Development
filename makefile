CC=gcc
CFLAGS=-c -Wall -ansi -g3
INCLUDE=-I include/
INCLUDE_M1=-I src/m1/include
INCLUDE_M2=-I src/m2/include
OUT=output
TARGET=hellomake
SRC:=main.c src/m1/m1.c src/m2/m2.c
all: $(TARGET) ASM

$(TARGET): main.o m1.o m2.o
	$(CC) $(OUT)/main.o $(OUT)/m1.o $(OUT)/m2.o -o $(OUT)/$(TARGET)
#it can be easier like this %.0: %.c
main.o: main.c
	$(CC) $(INCLUDE) $(INCLUDE_M1) $(INCLUDE_M2) $(CFLAGS) main.c -o $(OUT)/main.o

m1.o: src/m1/m1.c
	$(CC) $(INCLUDE_M1) $(CFLAGS) src/m1/m1.c -o output/m1.o

m2.o: src/m1/m1.c
	$(CC) $(INCLUDE_M2) $(CFLAGS) src/m2/m2.c -o output/m2.o

clean:
	-rm -f $(OUT)/*.o
	-rm -f $(OUT)/$(TARGET)
	-rm -f $(OUT)/*.s

install:
	install $(OUT)/$(TARGET) /usr/local/bin

uninstall:
	rm -rf /usr/local/bin/$(TARGET)

install-strip: 
#to tell you the truth I don't know what is it found smth like this by googling
	$(MAKE) Inst_prog='$(Inst_prog) -s' install

ASM: main.s m1.s m2.s

main.s: main.c
	$(CC) $(CFLAGS) -S $(INCLUDE) $(INCLUDE_M1) $(INCLUDE_M2) $< -o $(OUT)/$@

m1.s: src/m1/m1.c
	$(CC) $(CFLAGS) -S $(INCLUDE_M1) $< -o $(OUT)/m1.s

m2.s: src/m2/m2.c
	$(CC) $(CFLAGS) -S $(INCLUDE_M2) $< -o $(OUT)/m2.s
	
