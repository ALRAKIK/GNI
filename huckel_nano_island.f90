program huckel

implicit none 


! $$$$$$$$$$$$$$$$$$$$$$$ !  
!  variable defination    !
! $$$$$$$$$$$$$$$$$$$$$$$ !

! --- ! input ! --- ! 

integer                            :: n_hexagon 
double precision,allocatable       :: x(:)  
double precision,allocatable       :: y(:)
integer,allocatable                :: taste(:)
integer,allocatable                :: N(:)
character(len=100)                 :: string_lec           ! To read input data
character(len=100)                 :: filename
character(len=100)                 :: answer

! --- ! local ! --- ! 

integer                            :: i,j
integer                            :: n_atom = 6
integer                            :: x_line 
integer                            :: y_line
integer                            :: term 
integer                            :: start
integer                            :: nlines
integer                            :: skip_l
integer                            :: skip_r
integer                            :: t_rm = 0 , l_rm = 0 , r_rm = 0 
double precision                   :: beta 
double precision                   :: dist 
double precision                   :: dx , dy , c , d
logical                            :: he , pe , ee , eev 


! --- ! output ! --- ! 

double precision,allocatable       :: H(:,:)
double precision,allocatable       :: eigenvalues(:)


! $$$$$$$$$$$$$$$$$$$$$$$ !  
!  The code start here    !
! $$$$$$$$$$$$$$$$$$$$$$$ !


call system("clear")
    he   = .FALSE.
    pe   = .FALSE.
    ee   = .FALSE.
    eev  = .FALSE.
    Beta = 2.0d0
if (COMMAND_ARGUMENT_COUNT().eq.0) then
    write(*,*) ""
    write(*,*) "Bienvenue          /)"
    write(*,*) "          /\___/\ (("
    write(*,*) "          \`@_@'/  ))"
    write(*,*) "   Amer   {_:Y:.}_// Alrakik  "
    write(*,*) "----------{_}^-'{_}---------- "
    
    write(*,*) ""
    write(*,*) "This a kind of Manual for your program!"
        write(*,*) ""
        write(*,*) "OPTIONS: "
        write(*,*) ""
        write(*,*) " -N_HEXA   Write the number of hexagon on each side"
        write(*,*) " -t        Write the number to remove from the Top side"
        write(*,*) " -l        Write the number to remove from the left side"
        write(*,*) " -r        Write the number to remove from the right side"
        write(*,*) " -Beta     Write the beta coefficient (hopping integral)"
        write(*,*) " -H        Write the hessian matrix to a file called       'hessian'         (write 1 for this option)"
        write(*,*) " -OR       Write the Eigenvector (Orbitals) to file called 'EigenVector'     (write 1 for this option)"
        write(*,*) " -P        Generate a png pic for the coordinates called   'scatter.png'     (write 1 for this option)"
        write(*,*) " -EV       Generate the eigenvalues figure as              'EigenValues.png' (write 1 for this option)"
    write(*,*) ""
        stop
endif

do i = 1, COMMAND_ARGUMENT_COUNT()

    call getarg(i,string_lec)
    if (index(string_lec,'-N_HEXA').NE.0) then
      call getarg(i+1,string_lec)     
      read(string_lec,*) n_hexagon            ! number of hexagon in each side 
    endif
    if (index(string_lec,'-Beta').NE.0) then
      call getarg(i+1,string_lec)     
      read(string_lec,*) beta                 ! beta coeffecient
    endif
    if (index(string_lec,'-t').NE.0) then
      call getarg(i+1,string_lec)     
      read(string_lec,*) t_rm                 ! the number to remove from Top                  
    endif
    if (index(string_lec,'-l').NE.0) then
      call getarg(i+1,string_lec)     
      read(string_lec,*) l_rm                 ! the number to remove from left                  
    endif
    if (index(string_lec,'-r').NE.0) then
      call getarg(i+1,string_lec)     
      read(string_lec,*) r_rm                 ! the number to remove from right                  
    endif
    if (index(string_lec,'-H').NE.0) then    
      he  = .TRUE.                            ! to write the hessian matrix
    endif
    if (index(string_lec,'-P').NE.0) then
      pe = .TRUE.                  ! to plot for the coordinates                  
    endif
    if (index(string_lec,'-EV').NE.0) then
      ee = .TRUE.                  ! to plot the EigenValues                  
    endif
    if (index(string_lec,'-OR').NE.0) then
      eev = .TRUE.                 ! to write the Eigenvector                   
    endif
enddo

  call compare_lambda(t_rm,l_rm,r_rm)


  call num_of_atoms(n_hexagon,n_atom)         ! The total number of Carbon atom 

! &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& !


  write(*,'(a)')    ""
  write(*,'(a,I5)') "The number of hexagon          ", n_hexagon
  write(*,'(a)')    ""
  write(*,'(a,I5)') "The Total number of Carbon atom before removing", n_atom
  write(*,'(a)')    ""
  
  if (t_rm + r_RM >= n_hexagon .or. t_rm + l_RM >= n_hexagon .or. r_rm+l_RM >= n_hexagon ) then 
    if (t_rm == l_rm .or. t_rm == r_rm) then 
      write(*,'(a)')    "----------------------------------------------------------------"
      write(*,'(a)')    " Warning:: you may not have island shape for hexagon in this"
      write(*,'(a)')    "           case,and the program will not work as expected "
      write(*,'(a)')    "----------------------------------------------------------------"
      write(*,'(a)')    "Do you want to continue (Y/N) ??!"
      write(*,'(a)')    ""
      read(*,*)         answer
      write(*,'(a)')    ""
      if (answer == 'n' .or. answer == 'N') then
      write(*,'(a)')    ""
      write(*,'(a)')    "Hint :: try to increase the number of hexagon" 
      write(*,'(a)')    "        or change the number of removed hexagon on the sides"
      write(*,'(a)')    ""
      write(*,'(a)')    "Bonne journee"
      write(*,'(a)')    ""
        stop
      end if
    end if 
  end if 
  
  dx     = sqrt(3.d0)/2
  dy     = 0.5   
  
  open(1,file="null")
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  y_line = n_hexagon                                 !
  skip_l = -2*(y_line-2) - 1 + 2*(l_RM-1) + 2*(t_RM) !
  skip_r =  2*y_line + 1 - 2*(r_RM-1)                !
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  do j = 1+t_RM , y_line 
    
    x_line = 2*j+1
    start  = - x_line/2 - 1
      
    do i = 1 , x_line
      
      start  = start + 1      
      term   = (-1)**i
           
      if ( l_rm > 0 .and.  i <= skip_l ) then 
        cycle
      end if 
            
      if ( r_rm > 0 .and.  i >= skip_r ) then  
        exit
      end if 
      
      if (j > 1) then
          c = (j - 2)
          d = (j - 1)
        if (term == 1) then 
          write(1,'(f10.6,3x,f10.6,3x,I5)')     j+dy*c , dx*start, term    
        else
          write(1,'(f10.6,3x,f10.6,3x,I5)')     j+dy*d , dx*start, term
        end if 
      else if(j == 1) then 
        if (term == 1) then 
          write(1,'(f10.6,3x,f10.6,3x,I5)')     j-0.5, dx*start, term    
        else
          write(1,'(I5,3x,f10.6,3x,I5)')        j    , dx*start, term
        end if  
      end if 
        
    end do 
    
    skip_l = skip_l + 2 

  end do 
  
  x_line = 2*y_line+1
  start  = -(x_line/2 + 1) 
  
  skip_l = skip_l - 1
  skip_r = skip_r - 1
  
    do i = 1 , x_line
        
      
      term   = -((-1)**(i))
      start  = start + 1
      
      if ( l_rm > 0 .and.  i <= skip_l ) then 
        cycle
      end if 
      
      if ( r_rm > 0 .and.  i >= skip_r ) then 
        cycle
      end if
      
      
      if (y_line > 1) then 
          c = (y_line - 1)
          d =  y_line
        if (term == 1) then 
          write(1,'(f10.6,3x,f10.6,3x,I5)')     j+dy*c   ,dx*start , term   
        else 
          write(1,'(f10.6,3x,f10.6,3x,I5)')     j+dy*d   ,dx*start , term
        end if 
      else if (y_line == 1) then 
        if (term == 1) then 
          write(1,'(I5,3x,f10.6,3x,I5)')        j        ,dx*start , term   
        else 
          write(1,'(f10.6,3x,f10.6,3x,I5)')     j+0.5    ,dx*start , term
        end if
      end if 
  end do
  
  close(1)
  
  nlines = 0 
  
  open (1,file ="null")
  do
    read (1,*, end=1)
    nlines = nlines + 1
  end do 
  1 close (1)
  
  n_atom = nlines
  
  write(*,'(a,I5)') "The Total number of Carbon atom after removing ", n_atom
  write(*,'(a)')    ""
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  allocate(N          (n_atom))!
  allocate(x          (n_atom))!
  allocate(y          (n_atom))!
  allocate(taste      (n_atom))!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  open(1,file="null")
  do i = 1,n_atom
    read(1,*)  y(i) , x(i) , taste(i)
  end do 
  close(1)
  
  call system("rm -rf null")
   
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  allocate(H   (n_atom,n_atom))!
  allocate(eigenvalues(n_atom))!
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  do i = 1, n_atom-1
    do j = i+1,n_atom
     
    if (taste(i) /= taste(j)) then 
    
    dist = sqrt((x(i)-x(j))**2 + (y(i)-y(j))**2)
    
      if (dist < 1.2d0) then 
    
        H(i,j) = beta 
        H(j,i) = beta
      
      end if 
    
    end if 
    
    end do 
  end do
  
  if (pe) then 
    call gplot(n_atom,x,y,taste,n_hexagon,t_RM,r_RM,l_RM)
  end if 
  
  if (he) then 
  write(filename, "(a,I2,I2,I2,I2,a)") "Hessian_",n_hexagon,t_rm,l_rm,r_rm
  open(2,file=filename)
    write(2,'(a)'    ) ""
    write(2,'(a)'    ) ""
    write(2,'(22x,a)')       "/-------------------/"
    write(2,'(22x,a)')       "/ The Hessian matrix/"
    write(2,'(22x,a)')       "/-------------------/"
    write(2,'(a)'    ) ""
    write(2,'(a)'    ) ""
    write(2,'(a)',advance='no') "          "
  do i = 1,n_atom
    write(2,'(I5,a)',advance='no') i,"     " 
  end do
    write(2,'(a)'    ) ""
    write(2,'(a)'    ) ""
  do i = 1,n_atom
    write(2,'(I5,2x,1000(2x,f8.4))') i ,  H(i,:)
    write(2,'(a)') ""
  end do 
    close(2)
  end if 

  call diagonalize_matrix(n_atom,H,eigenvalues)
  
  write(filename, "(a,I2,I2,I2,I2,a)") "EigenValues_",n_hexagon,t_rm,l_rm,r_rm
  
  open(4,file=filename)

  write(4,'(a)') ""
  write(4,'(2x,a)')       "/-------------------/"
  write(4,'(2x,a)')       "/  The EigenValues  /"
  write(4,'(2x,a)')       "/-------------------/"
  write(4,'(a)') ""
  do i = 1,n_atom
    write (4,'(4x,f15.12)') eigenvalues(i)  
  end do
  
  close(4)
  
  if (ee) then 
    call eplot(n_atom,EigenValues,beta,n_hexagon,t_RM,l_RM,r_RM)
  end if 
  
  if (eev) then 
    
    write(filename, "(a,I2,I2,I2,I2,a)") "EigenVectors_",n_hexagon,t_rm,l_rm,r_rm
    
    open(5,file=filename)
    
    write(5,'(a)') ""
    write(5,'(a)') ""
    write(5,'(22x,a)')       "/-------------------/"
    write(5,'(22x,a)')       "/ The EigenVectors  /"
    write(5,'(22x,a)')       "/-------------------/"
    write(5,'(a)'    ) ""
    write(5,'(a)'    ) ""
    write(5,'(a)',advance='no') "          "
    do i = 1,n_atom
      write(5,'(I5,a)',advance='no') i,"     " 
    end do
    write(5,'(a)'    ) ""
    write(5,'(a)'    ) ""
    do i = 1,n_atom
      write(5,'(I5,2x,1000(2x,f8.4))') i ,  H(i,:)
      write(5,'(a)') ""
    end do
    
    close(5)
    
  end if 
    
end program 


subroutine num_of_atoms(n,Tn) 

implicit none 

integer,intent(in)         :: n
integer,intent(inout)      :: Tn
integer                    :: i , term 

do i = 1,n-1 
  term = 7  + 2*(i-1) 
  Tn   = Tn + term 
end do  


end subroutine num_of_atoms


subroutine diagonalize_matrix(N,A,e)

! Diagonalize a square matrix

  implicit none

! Input variables

  integer,intent(in)            :: N
  double precision,intent(inout):: A(N,N)
  double precision,intent(out)  :: e(N)

! Local variables

  integer                       :: lwork,info
  integer                       :: i
  double precision,allocatable  :: work(:)
  

! Memory allocation

  allocate(work(3*N))
  lwork = size(work)

  call dsyev('V','U',N,A,N,e,work,lwork,info)
 
  if(info /= 0) then 
    print*,'Problem in diagonalize_matrix (dsyev)!!'
    stop
  endif
  
  do i = 1 , N
    if (abs(e(i)) < 1e-10) e(i) = 0
  end do  
  
  end subroutine diagonalize_matrix

  subroutine gplot(n_atom,x,y,taste,n_hexagon,t,l,r)
  
  implicit none 
  
  ! --- ! input ! --- ! 
  
  integer,intent(in)            ::       n_atom
  integer,intent(in)            ::    n_hexagon
  integer,intent(in)            ::            t
  integer,intent(in)            ::            l
  integer,intent(in)            ::            r
  integer, intent(in)           :: taste(n_atom)
  double precision, intent(in)  ::     x(n_atom) 
  double precision, intent(in)  ::     y(n_atom)
  
  ! --- ! local ! --- ! 
  
  integer :: i 
  
  ! --- ! code  ! --- !
  
  open(2,file="null")
  
  do i = 1,n_atom
    write(2,'(2x,I5,4x,f10.6,4x,f10.6,4x,I5)') i , x(i) , -y(i) , taste(i)
  end do 
  
  close(2)

  open(3,file="plot")
  
    write(3,'(a)') "set terminal pngcairo enhanced font 'Verdana,12' size 16in,12in "
    write(3,'(a,I2,I2,I2,I2,a)') "set output 'scatter_",n_hexagon,t,l,r,".png'"
    write(3,'(a)') "set size ratio sqrt(3)/2"
    write(3,'(a)') "unset xtics"
    write(3,'(a)') "unset ytics"
    write(3,'(a)') "set tmargin 2"
    write(3,'(a)') "set bmargin 1"
    write(3,'(a)') "unset border"
    write(3,'(a)') "plot 'null' using 2:3:(($4 == 1) ? 0xff0000 : 0x0000ff) w p pt 7 ps 2 lc rgb variable notitle,\"
    write(3,'(a)') "'' using 2:3:(sprintf('%d', $0+1)) with labels font ',12' offset 0,1.5 notitle"
    
  close(3)

    call system("gnuplot plot")
    call system("rm -rf  plot")
    call system("rm -rf  null")

  end subroutine gplot
  
  subroutine eplot(N,E,beta,n_hexagon,t,l,r)
  
  implicit none 
  
  ! --- ! input ! --- ! 
  
  integer,intent(in)            ::  N
  integer,intent(in)            ::  n_hexagon
  integer,intent(in)            ::  t
  integer,intent(in)            ::  l
  integer,intent(in)            ::  r
  double precision, intent(in)  ::  E(N) 
  double precision, intent(in)  ::  beta
  
  ! --- ! local ! --- ! 
  
  integer                       :: i 
  double precision              :: dx 
  
  ! --- ! code  ! --- !
  
  open(2,file="null")
  
  dx = 1.d0/N
  
  do i = 1,N
    write (2,'(4x,f15.12,4x,f10.6)') E(i) , dx*i 
  end do 
  
  close(2)

  open(3,file="plot")
  
    write(3,'(a)') "set terminal pngcairo enhanced font 'Verdana,12' size 16in,12in "
    write(3,'(a,I2,I2,I2,I2,a)') "set output 'EigenValues_",n_hexagon,t,l,r,".png'"
    write(3,'(a)') "set border"
    write(3,'(a,f5.2,a,I2,a,I2,I2,I2,a)') "set title '{/Symbol b} = ",beta,"  (",n_hexagon," |",t,l,r," )&
                                           & ' font 'Helvetica,16' enhanced"
    write(3,'(a)') "plot 'null' u 2:1 w lp pt 7 ps 1 notitle"
    
  close(3)

    call system("gnuplot plot")
    call system("rm -rf  plot")
    call system("rm -rf  null")

  end subroutine eplot
  
  subroutine compare_lambda(a,b,c)
  
  implicit none 
  
  ! --- ! input ! --- ! 
  
  integer, intent(in) :: a,b,c
    
  ! --- ! code  ! --- ! 
  
  if (a < b .and. a < c) then 
    write(*,*) ""
    write(*,*) ""
    write(*,*) "The number of hexagon you remove from top should be bigger than the number you remove from other sides"
    write(*,*) ""
    write(*,*) ""
    stop     
  else 
    if ( b  < c ) then 
      write(*,*) ""
      write(*,*) ""
      write(*,*) "The number of hexagon you remove from left should be bigger than the number you remove from right"
      write(*,*) ""
      write(*,*) ""
      stop
    end if 
  end if 
  
  end subroutine