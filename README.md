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

| keywords                     | type  | Description | 
| :---                         |  :--- |     :---       |
| box: real real real        |`char`  `real` `real` `real` | change the size of the box on x,y,z  "default $2\pi,2\pi,2\pi$" |
| random (optional)            |`char` |  start from random geometry (every axis have a random number between  [0,1]  |
| multiply (optional)          |`char` | multiply the input geometry by the size of the box and distrubute the electron all over the box |
| show (optional)              |`char` | show all the result (the geometry in every step of iteration, energy of the system , and the norm of the gradient) |
| density (optional)           |`char` | choose a fixed density (one electron per the unit of length) and ignore the size of the box written before or after  |
| density rectangle (optional) |`char` `char`| choose a fixed density (one electron per the unit of length) in case of 2D if user want to choose the ratio between the first and the second axis as $\sqrt(3)/2$  |
| hessian (optional)           |`char` | show the hessian matrix at the convergance |
| distance (optional)          |`char` | show the euclidean and the geodesic matrix at the convergance |
| animation (optional)         |`char` | make a video for the optimizations steps or if the user are at a fixed point (minimum or saddle point) gives a picture  |
| animation origin (optional)  |`char` `char` | same as animation but force one electron to be at the origin of the torus [0,0,0] |



# Contact

Amer Alrakik - alrakikamer@gmail.com

Project Link: [https://github.com/ALRAKIK/GNI](https://github.com/ALRAKIK/GNI)

# License

Distributed under the MIT License. See `LICENSE.txt` for more information.

# Acknowledgments

Thanks to  Rony J. Letona
