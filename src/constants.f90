!******************************************************BEGINNING***************************************************************
!stores parameters and commonly used variables
module constants
!*****************************************************DECLARATION**************************************************************
    implicit none

    integer, parameter:: dp=selected_real_kind(15)       ! double precision (don't change, lsode integrators are not implemented for arbitrary precision)

    real(dp), parameter :: pi=3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679_dp !pi
    real(dp), parameter :: sigmaB=5.67037321e-8_dp       !Stefan-Boltzmann constant
    real(dp), parameter :: kb=1.380648813e-23_dp         !Boltzmann constant
    real(dp), parameter :: Rg=8.31446218_dp              !gas constant
    real(dp), parameter :: NA=Rg/kb                      !Avogadro constant

!*********************************************************BODY*****************************************************************
end module constants
!**********************************************************END*****************************************************************
