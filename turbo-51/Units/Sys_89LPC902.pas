// 89LPC902 processor definition file
// ==================================


unit Sys_89LPC902;

interface

var
  P0M1      : byte absolute $84;
  P0M2      : byte absolute $85;
  KBMASK    : byte absolute $86;
  P1M1      : byte absolute $91;
  P1M2      : byte absolute $92;
  KBPATN    : byte absolute $93;
  KBCON     : byte absolute $94;
  DIVM      : byte absolute $95;
  TRIM      : byte absolute $96;
  AUXR1     : byte absolute $A2;
  WDCON     : byte absolute $A7;
  IEN0      : byte absolute $A8;
  CMP1      : byte absolute $AC;
  CMP2      : byte absolute $AD;
  PCONA     : byte absolute $B5;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
  RTCCON    : byte absolute $D1;
  RTCH      : byte absolute $D2;
  RTCL      : byte absolute $D3;
  RSTSRC    : byte absolute $DF;
  FMCON     : byte absolute $E4;
  FMDATA    : byte absolute $E5;
  FMADRL    : byte absolute $E6;
  FMADRH    : byte absolute $E7;
  IEN1      : byte absolute $E8;
  PT0AD     : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;

  KBI0      : boolean absolute $80;  // P0
  CMP_2     : boolean absolute $80;  // original Philips name CMP2 conflicts with SFR
  KBI2      : boolean absolute $82;
  CIN2A     : boolean absolute $82;
  KBI4      : boolean absolute $84;
  CIN1A     : boolean absolute $84;
  KBI5      : boolean absolute $85;
  CMPREF    : boolean absolute $85;
  KBI6      : boolean absolute $86;
  CMP_1     : boolean absolute $86;  // original Philips name CMP1 conflicts with SFR


  RST       : boolean absolute $95;  // P1

  EBO       : boolean absolute $AD;
  EWDRT     : boolean absolute $AE;

  PBO       : boolean absolute $BD;
  PWDRT     : boolean absolute $BE;

  F1        : boolean absolute $D1;

  EKBI      : boolean absolute $E9;  // IEN1
  EC        : boolean absolute $EA;

  PKBI      : boolean absolute $F9;  // IP1
  PCMP      : boolean absolute $FA;  // original Philips name PC conflicts with MOV A,@A+PC


const
  BROWN     = $2B;
  KBINT     = $3B;
  COMP      = $43;
  WATCHD    = $53;

implementation

end.
