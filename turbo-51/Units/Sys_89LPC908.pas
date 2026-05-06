// 89LPC908 processor definition file
// ==================================


unit Sys_89LPC908;

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
  SADDR     : byte absolute $A9;
  CMP1      : byte absolute $AC;
  PCONA     : byte absolute $B5;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  SSTAT     : byte absolute $BA;
  BRGCON    : byte absolute $BD;
  BRGR0     : byte absolute $BE;
  BRGR1     : byte absolute $BF;
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

  KBI4      : boolean absolute $84;  // P0
  CIN1A     : boolean absolute $84;
  KBI5      : boolean absolute $85;
  CMPREF    : boolean absolute $85;
  KBI6      : boolean absolute $86;
  CMP_1     : boolean absolute $86;  // original Philips name CMP1 conflicts with SFR


  RST       : boolean absolute $95;

  FE        : boolean absolute $9F;

  ESR       : boolean absolute $AC;
  EBO       : boolean absolute $AD;
  EWDRT     : boolean absolute $AE;

  PSR       : boolean absolute $BC;
  PBO       : boolean absolute $BD;
  PWDRT     : boolean absolute $BE;

  F1        : boolean absolute $D1;

  EKBI      : boolean absolute $E9;  // IEN1
  EC        : boolean absolute $EA;
  EST       : boolean absolute $EE;

  PKBI      : boolean absolute $F9;  // IP1
  PCMP      : boolean absolute $FA;  // original Philips name PC conflicts with MOV A,@A+PC
  PST       : boolean absolute $FE;


const
  BROWN     = $2B;
  KBINT     = $3B;
  COMP      = $43;
  WATCHD    = $53;
  SINTX     = $6B;

implementation

end.
