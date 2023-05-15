# GNI (Graphene Nanoisland)
The Huckel matrix-based algorithm employed by this program computes the energy of a triangulene or a graphene nanoisland (GNI) by performing diagonalization.


# Prerequisite

* 1 - Fortran compiler (gfortran 9.4 recommended):

```
sudo apt install gfortran
```
* 2 - Fortran library (llapack, openmp):
  
```
sudo apt install liblapack-dev libopenblas-dev libomp-dev
```
* 3 - for plotting (gnuplot):

```
sudo apt install gnuplot 
```
* 4 - Python (Python 3, not working using python 2 because it need some library )

```
sudo apt install python3 python3-pip
```
* 5 - Python library for (numpy,tkinter,customtkinter) to use the python GUI

```
sudo apt install python3-tk
pip3 install customtkinter numpy 
```

# Build

* build the program
  
```sh
make GNI
```
* clean the bin files
```sh
make clean
```
# Usage 

* Using Python GNI

```sh
python GNI.py
``` 

* using the commend line 

```sh
./GNI 'arguments'
```

* keywords 



# Contact

Amer Alrakik - alrakikamer@gmail.com

Project Link: [https://github.com/ALRAKIK/GNI](https://github.com/ALRAKIK/GNI)

# License

Distributed under the MIT License. See `LICENSE.txt` for more information.

# Acknowledgments

Thanks to  Rony J. Letona
