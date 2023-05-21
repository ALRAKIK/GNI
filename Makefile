GF90 = gfortran

XFLAG = -ffree-line-length-none -O3  -march=native  -fimplicit-none   -fwhole-file 

LIBS = -llapack

BIN = GNI 

FFFLAGS = -Wall -g -msse4.2 -fcheck=all -Waliasing -Wampersand -Wconversion -Wsurprising -Wintrinsics-std -Wno-tabs -Wintrinsic-shadow -Wline-truncation -Wreal-q-constant

FFLAGS = -Wall -Wno-unused -Wno-unused-dummy-argument -O2 

help:
	@echo  " -----------------------------------------\n to make the code you should do :  \n ----------------------------------------- \n make GNI |  to compiled with gfortran \n -----------------------------------------";\
 

GNI:
	$(GF90) *.f90 -o $(BIN) $(FFLAGS) $(LIBS)

clean:
	$(RM)  $(BIN)

GNI_d: 
	$(GF90) *.f90 -o $(BIN) $(FFFLAGS) $(LIBS)