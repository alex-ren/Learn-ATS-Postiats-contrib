######
#
# For a SHOOTOUT/benchmark
#
######

all:: spectral-norm

######

spectral-norm: spectral-norm.dats ; \
  patscc -O3 -msse2 -mfpmath=sse -o $@ $< -lm

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) spectral-norm

###### end of [Makefile] ######
