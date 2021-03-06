!>This file contains the automatic differentiation results
!!of the subroutines which perform spline interpolation and
!!spline integration.










 
!        Generated by TAPENADE     (INRIA, Tropics team)
!  Tapenade 3.10 (r5498) - 20 Jan 2015 09:48
!
!  Differentiation of spline in forward (tangent) mode:
!   variations   of useful results: y2
!   with respect to varying inputs: y2 y
!WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
! SUBROUTINE spline
!
! Given arrays x(1:n) and y(1:n) containing a tabulated function,
! i.e., yi = f(xi), with  x1 < x2 < .. . < xN, and given values yp1 and
! ypn for the first derivative of the interpolating function at points 1
! and n, respectively, this routine returns an array y2(1:n) of length n
! which contains the second derivatives of the interpolating function at
! the tabulated points xi. If yp1 and/or ypn are equal to 1  1030 or
! larger, the routine is signaled to set  the corresponding boundary
! condition for a natural spline, with zero second derivative on that
! boundary.
! Parameter: NMAX is the largest anticipated value of n.
!WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
!
SUBROUTINE SPLINE_D(x, y, yd, n, yp1, ypn, y2, y2d)
  IMPLICIT NONE
!
! ----------------------------------------------------------------------
  INTEGER, INTENT(IN) :: n
  REAL, INTENT(IN) :: x(n)
  REAL, INTENT(IN) :: y(n)
  REAL, INTENT(IN) :: yd(n)
  REAL, INTENT(IN) :: yp1
  REAL, INTENT(IN) :: ypn
  REAL, INTENT(OUT) :: y2(n)
  REAL, INTENT(OUT) :: y2d(n)
!
! ----------------------------------------------------------------------
  INTEGER, PARAMETER :: nmax=1000
  INTEGER :: i, k
  REAL :: p, qn, sig, un, u(nmax)
  REAL :: pd, und, ud(nmax)
! ----------------------------------------------------------------------
  IF (yp1 .GT. 0.99e30) THEN
    y2d(1) = 0.0
    y2(1) = 0.0
    u(1) = 0.0
    ud = 0.0
  ELSE
    y2d(1) = 0.0
    y2(1) = -0.5
    ud = 0.0
    ud(1) = 3.0*(yd(2)-yd(1))/(x(2)-x(1))**2
    u(1) = 3.0/(x(2)-x(1))*((y(2)-y(1))/(x(2)-x(1))-yp1)
  END IF
  DO i=2,n-1
    IF ((x(i+1) - x(i) .EQ. 0.0 .OR. x(i) - x(i-1) .EQ. 0.0) .OR. x(i+1)&
&       - x(i-1) .EQ. 0.0) THEN
      GOTO 100
    ELSE
      sig = (x(i)-x(i-1))/(x(i+1)-x(i-1))
      pd = sig*y2d(i-1)
      p = sig*y2(i-1) + 2.0
      y2d(i) = -((sig-1.0)*pd/p**2)
      y2(i) = (sig-1.0)/p
      ud(i) = ((6.0*((yd(i+1)-yd(i))/(x(i+1)-x(i))-(yd(i)-yd(i-1))/(x(i)&
&       -x(i-1)))/(x(i+1)-x(i-1))-sig*ud(i-1))*p-(6.0*((y(i+1)-y(i))/(x(&
&       i+1)-x(i))-(y(i)-y(i-1))/(x(i)-x(i-1)))/(x(i+1)-x(i-1))-sig*u(i-&
&       1))*pd)/p**2
      u(i) = (6.0*((y(i+1)-y(i))/(x(i+1)-x(i))-(y(i)-y(i-1))/(x(i)-x(i-1&
&       )))/(x(i+1)-x(i-1))-sig*u(i-1))/p
    END IF
  END DO
  IF (ypn .GT. 0.99e30) THEN
    qn = 0.0
    un = 0.0
    und = 0.0
  ELSE
    qn = 0.5
    und = -(3.0*(yd(n)-yd(n-1))/(x(n)-x(n-1))**2)
    un = 3.0/(x(n)-x(n-1))*(ypn-(y(n)-y(n-1))/(x(n)-x(n-1)))
  END IF
  y2d(n) = ((und-qn*ud(n-1))*(qn*y2(n-1)+1.0)-(un-qn*u(n-1))*qn*y2d(n-1)&
&   )/(qn*y2(n-1)+1.0)**2
  y2(n) = (un-qn*u(n-1))/(qn*y2(n-1)+1.0)
  DO k=n-1,1,-1
    y2d(k) = y2d(k)*y2(k+1) + y2(k)*y2d(k+1) + ud(k)
    y2(k) = y2(k)*y2(k+1) + u(k)
  END DO
  GOTO 110
 100 WRITE(*, *) 'i x', i, x(i+1), x(i), x(i-1)
  WRITE(*, *) 'error in spline-interpolation'
  STOP
 110 CONTINUE
END SUBROUTINE SPLINE_D






!        Generated by TAPENADE     (INRIA, Tropics team)
!  Tapenade 3.10 (r5498) - 20 Jan 2015 09:48
!
!  Differentiation of splint_integral in forward (tangent) mode:
!   variations   of useful results: integral
!   with respect to varying inputs: y2a ya
!WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
! SUBROUTINE splint_integral
!
! Given the arrays xa(1:n) and ya(1:n) of length n, which tabulate a
! function (with the in order), and given the array y2a(1:n), which is
! the output from spline above, and given a value of x, this routine
! returns a cubic-spline interpolated value y.
!WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
!
SUBROUTINE SPLINT_INTEGRAL_D(xa, ya, yad, y2a, y2ad, n, xlo, xhi, &
& integral, integrald)
  IMPLICIT NONE
! the -1 in (khi_L-1) because khi_L was already counted up
!
! ----------------------------------------------------------------------
  INTEGER, INTENT(IN) :: n
  REAL, INTENT(IN) :: xa(n)
  REAL, INTENT(IN) :: ya(n)
  REAL, INTENT(IN) :: yad(n)
  REAL, INTENT(IN) :: y2a(n)
  REAL, INTENT(IN) :: y2ad(n)
  REAL, INTENT(IN) :: xlo
  REAL, INTENT(IN) :: xhi
  REAL, INTENT(OUT) :: integral
  REAL, INTENT(OUT) :: integrald
!
! ----------------------------------------------------------------------
  INTEGER :: k, khi_l, klo_l, khi_h, klo_h
  REAL :: xl, xh, h, int, x0, x1, y0, y1, y20, y21
  REAL :: intd, y0d, y1d, y20d, y21d
! ----------------------------------------------------------------------
  integral = 0.0
  klo_l = 1
  khi_l = n
 1 IF (khi_l - klo_l .GT. 1) THEN
    k = (khi_l+klo_l)/2
    IF (xa(k) .GT. xlo) THEN
      khi_l = k
    ELSE
      klo_l = k
    END IF
    GOTO 1
  END IF
  klo_h = 1
  khi_h = n
 2 IF (khi_h - klo_h .GT. 1) THEN
    k = (khi_h+klo_h)/2
    IF (xa(k) .GT. xhi) THEN
      khi_h = k
    ELSE
      klo_h = k
    END IF
    GOTO 2
  END IF
! integration in spline pieces, the lower interval, bracketed
! by xa(klo_L) and xa(khi_L) is in steps shifted upward.
! first: determine upper integration bound
  xl = xlo
  integrald = 0.0
 3 IF (khi_h .GT. khi_l) THEN
    xh = xa(khi_l)
  ELSE IF (khi_h .EQ. khi_l) THEN
    xh = xhi
  ELSE
    WRITE(*, *) 'error in spline-integration'
    PAUSE 
  END IF
  h = xa(khi_l) - xa(klo_l)
  IF (h .EQ. 0.0) PAUSE'bad xa input in splint' 
  x0 = xa(klo_l)
  x1 = xa(khi_l)
  y0d = yad(klo_l)
  y0 = ya(klo_l)
  y1d = yad(khi_l)
  y1 = ya(khi_l)
  y20d = y2ad(klo_l)
  y20 = y2a(klo_l)
  y21d = y2ad(khi_l)
  y21 = y2a(khi_l)
! int = -xL/h * ( (x1-.5*xL)*y0 + (0.5*xL-x0)*y1  &
!            +y20/6.*(x1**3-1.5*xL*x1*x1+xL*xL*x1-.25*xL**3)  &
!            -y20/6.*h*h*(x1-.5*xL)  &
!            +y21/6.*(.25*xL**3-xL*xL*x0+1.5*xL*x0*x0-x0**3)  &
!            -y21/6.*h*h*(.5*xL-x0) )
! int = int + xH/h * ( (x1-.5*xH)*y0 + (0.5*xH-x0)*y1  &
!            +y20/6.*(x1**3-1.5*xH*x1*x1+xH*xH*x1-.25*xH**3)  &
!            -y20/6.*h*h*(x1-.5*xH)  &
!            +y21/6.*(.25*xH**3-xH*xH*x0+1.5*xH*x0*x0-x0**3)  &
!            -y21/6.*h*h*(.5*xH-x0) )
  intd = -((xl*((x1-.5*xl)*y0d+(0.5*xl-x0)*y1d)-(x1-xl)**4*y20d/24.+(0.5&
&   *xl*xl-x1*xl)*h**2*y20d/6.+(xl-x0)**4*y21d/24.-(0.5*xl*xl-x0*xl)*h**&
&   2*y21d/6.)/h)
  int = -(1.0/h*(xl*((x1-.5*xl)*y0+(0.5*xl-x0)*y1)-y20/24.*(x1-xl)**4+&
&   y20/6.*(0.5*xl*xl-x1*xl)*h*h+y21/24.*(xl-x0)**4-y21/6.*(0.5*xl*xl-x0&
&   *xl)*h*h))
  intd = intd + (xh*((x1-.5*xh)*y0d+(0.5*xh-x0)*y1d)-(x1-xh)**4*y20d/24.&
&   +(0.5*xh*xh-x1*xh)*h**2*y20d/6.+(xh-x0)**4*y21d/24.-(0.5*xh*xh-x0*xh&
&   )*h**2*y21d/6.)/h
  int = int + 1.0/h*(xh*((x1-.5*xh)*y0+(0.5*xh-x0)*y1)-y20/24.*(x1-xh)**&
&   4+y20/6.*(0.5*xh*xh-x1*xh)*h*h+y21/24.*(xh-x0)**4-y21/6.*(0.5*xh*xh-&
&   x0*xh)*h*h)
  integrald = integrald + intd
  integral = integral + int
! write (*,*) integral,x1,xH
  klo_l = klo_l + 1
  khi_l = khi_l + 1
  xl = x1
  IF (khi_h .NE. khi_l - 1) GOTO 3
END SUBROUTINE SPLINT_INTEGRAL_D



