######
#
# For a SHOOTOUT/benchmark
#
######

all:: n-body
all:: n-body-2
all:: n-body_c

######

n-body: n-body.dats
	patscc -O3 -msse2 -mfpmath=sse -o $@ $< -lm

n-body-2: n-body-2.dats
	patscc -pipe -O3 -fomit-frame-pointer -march=native -msse3 -mfpmath=sse $< -o $@ -lm

n-body_c: n-body.c
	gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -msse3 -mfpmath=sse $< -o $@ -lm

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) n-body
cleanall:: ; $(RMF) n-body-2
cleanall:: ; $(RMF) n-body_c

###### end of [Makefile] ######
