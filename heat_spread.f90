program heatequation

character (len = 32) :: input,output,freq_c
character(len = 5) :: x_pos, y_pos
integer:: command_count, freq, xtot, ytot, timesteps, file_end,&
 hold, ierroru, ierroh, i, j, x,y,t,totaltime,ierrorp

real, dimension(:,:,:), allocatable:: u
integer, dimension (:,:), allocatable::hold_array
real, dimension(:,:), allocatable:: u_new
real::alpha, temp

command_count = command_argument_count()


call get_command_argument(1,input)
call get_command_argument(2,freq_c)
call get_command_argument(3,output)

read(freq_c,*) freq
totaltime=freq*timesteps



if((command_count .LT. 3) .or. (command_count .GT. 3)) then
stop "Incorrect number of arguments"
end if

open(1, file=input, status = 'unknown')
open( 2, file=output, status= 'unknown')

read(1,*,IOSTAT = file_end) xtot,ytot,alpha,timesteps

allocate(u(xtot,ytot,timesteps), stat=ierroru)
allocate(hold_array(xtot,ytot),stat=ierrorh)
allocate(u_new(xtot,ytot), stat=ierrorp)
if(ierroru/=0) stop 'error u'
if(ierrorh/=0) stop 'error u'
if(ierrorp/=0) stop 'error u'

do while(file_end==0)

read(1,*,IOSTAT=file_end) x_pos,y_pos,temp, hold

if(x_pos == '*' .AND. y_pos=='*') then
do i=1, xtot
do j=1, ytot
u(i,j,1) = temp
hold_array(i,j) = hold
enddo
enddo

elseif(x_pos =='*') then
do i = 1, xtot
read(y_pos,*) y 
u(i,y+1,1) = temp
hold_array(i,y+1) = hold
enddo

elseif(y_pos =='*') then
do i = 1, ytot
read(x_pos,*) x
u(x+1,i,1)= temp
hold_array(x+1,i) = hold
end do

else 
read(x_pos,*) x
read(y_pos,*) y
u(x+1,y+1,1) = temp
hold_array(x+1,y+1) = hold

end if
end do



do t =2, totaltime
do i =1, xtot
do j=1, ytot

if(hold_array(i,j) ==0) then

if(i==1 .and. j==1) then
u_new(i,j) = u(i,j,t-1) + alpha *(u(i+1,j,t-1)+&
u(i,j+1, t-1) + u(i+1, j+1, t-1) - 3*u(i,j,t-1))

elseif(i ==1 .and. j == ytot) then
u_new(i,j) = u(i,j,t-1) + alpha*(u(i,j-1,t-1) +&
u(i+1,j-1, t-1) + u(i+1, j, t-1) - 3*u(i,j,t-1))

elseif(i == xtot .and. j==1) then
u_new(i,j) = u(i,j,t-1) + alpha*(u(i-1,j,t-1) +&
u(i-1,j+1, t-1) + u(i,j+1,t-1) - 3*u(i,j,t-1))


elseif(i==xtot .and. j==ytot)then 
u_new(i,j) = u(i,j,t-1) + alpha *(u(i-1,j-1, t-1) +&
u(i,j-1,t-1) + u(i-1, j, t-1) -3*u(i,j,t-1))

elseif( i ==1) then
u_new(i,j) = u(i,j,t-1) +&
alpha*(u(i,j-1,t-1) + u(i+1,j-1, t-1) +u(i+1,j,t-1) +  u(i,j+1,t-1) + u(i+1, j+1, t-1) -5*u(i,j,t-1))


elseif(i == xtot)then 
u_new(i,j) = u(i,j,t-1) + alpha*(u(i-1,j-1,t-1) +&
u(i+1, j-1, t-1) + u(i+1, j, t-1) + u(i, j+1, t-1) + u(i+1, j+1, t-1) - 5*u(i,j,t-1))

elseif(j==1)then 
u_new(i,j) = u(i,j,t-1) + alpha*(u(i-1,j,t-1) + u(i+1, j, t-1) +&
u(i-1, j+1, t-1) + u(i,j+1, t-1) +u(i+1, j+1, t-1) - 5*u(i,j,t-1))

elseif(j==ytot)then
u_new(i,j) = u(i,j,t-1) +alpha*(u(i-1,j-1,t-1) + u(i,j-1,t-1) +&
u(i+1, j-1,t-1) + u(i-1,j,t-1)+ u(i+1, j, t-1) - 5*u(i,j,t-1))

else
u_new(i,j) = u(i,j,t-1) + alpha *(u(i-1,j-1,t-1) + u(i,j-1,t-1) + u(i+1, j-1,t-1) + u(i-1,j,t-1) + u(i+1, j,t-1) +&
u(i-1,j+1, t-1) + u(i,j+1, t-1) + u(i+1, j+1, t-1) - 8*u(i,j,t-1))

endif
endif
enddo
enddo
u(:,:,t) = u_new(:,:) + hold_array(:,:) *u(:,:,1)
enddo






do t=1, timesteps

write(2,*) 'T = ' , t
do i = 1, xtot
write(2, '(1000F10.3)') (real(u(j,i,t)), j=1, ytot)

enddo



end do 



end program  heatequation
