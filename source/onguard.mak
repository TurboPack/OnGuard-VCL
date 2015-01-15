#-------------------------------------------------------------------------
#  ONGUARD.MAK
#-------------------------------------------------------------------------
#  Make file used to build OnGuard
#
#  This make file is designed to be used only with Borland's MAKE utility.
#
#      MAKE -fONGUARD.MAK [optional parameters]
#
#  at the DOS command line or in response to Window's File|Run dialog.
#

#-------------------------------------------------------------------------
#  Compiler choice
#-------------------------------------------------------------------------

# Define only one of the following to by uncommenting the appropriate line
# or undefine all and state the define as part of the make command line

#Delphi1=1
#Delphi2=1
Delphi3=1

#set to the current version (for package naming)
ver=106

Setup1=1 # At work
#Setup2=1 # At home

#-------------------------------------------------------------------------
#  Macros
#-------------------------------------------------------------------------

# Path to compiler
!if $d(Setup1)
  dcc1=c:\borland\delphi\bin\dcc.exe
  dcc2=c:\borland\delphi~1.0\bin\dcc32.exe
  dcc3="c:\borland\delphi 3\bin\dcc32.exe"
!else
  !if $d(Setup2)
    dcc1=d:\progra~1\borland\delphi\bin\dcc.exe
    dcc2=d:\progra~1\borland\delphi~1.0\bin\dcc32.exe
    dcc3=d:\progra~1\borland\delphi3\bin\dcc32.exe
  !endif
!endif

# Path to resource compiler
!if $d(Setup1)
  brc1=c:\borland\delphi\bin\brcc.exe
  brc2=c:\borland\delphi~1.0\bin\brcc32.exe
  brc3=c:\borland\delphi~1\bin\brcc32.exe
  srmgr=d:\srmgr\srmc.exe
!else
  !if $d(Setup2)
    brc1=d:\progra~1\borland\delphi\bin\brcc.exe
    brc2=d:\progra~1\borland\delphi~1.0\bin\brcc32.exe
    brc3=d:\progra~1\borland\delphi3\bin\brcc32.exe
    srmgr=d:\srmgr\srmc.exe
  !endif
!endif

opts=/M /$$D- /$$L- /L

!if $d(Delphi1)
  dcc=$(dcc1) $(opts)
  brc=$(brc1) -31 -dwin16 -fo$&.r16
  res=r16
  srmc=$(srmgr) -16 -fo$&.s16
  srm=s16
!endif

!if $d(Delphi2)
  dcc=$(dcc2) $(opts)
  brc=$(brc2) -w32 -fo$&.r32
  res=r32
  srmc=$(srmgr) -32 -fo$&.s32
  srm=s32
!endif

!if $d(Delphi3)
  dcc=$(dcc3) $(opts)
  brc=$(brc3) -w32 -fo$&.r32
  res=r32
  srmc=$(srmgr) -32 -fo$&.s32
  srm=s32
!endif


#-------------------------------------------------------------------------
#  Implicit rules
#-------------------------------------------------------------------------

.pas.exe:
        $(dcc) $<

.dpr.exe:
        $(dcc) $<

.pas.dcu:
        $(dcc) $<

.pas.dll:
        $(dcc) $<

.dpr.dll:
        $(dcc) $<

.dpk.dcp:
        $(dcc) $<

.dpk.dpl:
        $(dcc) $<

.rc.$(res):
        $(brc) $<

.str.$(srm):
        $(srmc) $<

#-------------------------------------------------------------------------
#  Explicit rules
#-------------------------------------------------------------------------

!if $d(Delphi3)
allog       : onguard resources packages
!else
allog       : onguard resources
!endif

onguard     : ogreg.dcu onguard.dcu onguard1.dcu onguard2.dcu onguard3.dcu \
              onguard4.dcu onguard5.dcu onguard6.dcu onguard7.dcu onguard8.dcu \
              ogconst.dcu ognetwrk.dcu ogproexe.dcu ogutil.dcu onguard.inc \
              onguard1.dfm onguard2.dfm onguard3.dfm onguard4.dfm \
              onguard6.dfm onguard8.dfm


resources : ogconst.$(srm) ogconst.dcu ogconst.$(res) ogReg.$(res)

!if $d(Delphi3)
packages    : onguard resources \
              tog$(ver)_r.dpl tog$(ver)_r.dcp \
              tog$(ver)_d.dpl tog$(ver)_d.dcp
!endif