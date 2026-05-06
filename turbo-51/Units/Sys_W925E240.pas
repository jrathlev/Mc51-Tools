// W925E240 processor definition file
// ==================================
// W925E240, W925C240


unit Sys_W925E240;

interface

var
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON1    : byte absolute $8E;
  CKCON2    : byte absolute $8F;
  EXIF      : byte absolute $91;
  RPAGE     : byte absolute $92;
  P1SR      : byte absolute $93;
  P0IO      : byte absolute $94;
  P1IO      : byte absolute $95;
  P2IO      : byte absolute $96;
  P3IO      : byte absolute $97;
  P1EF      : byte absolute $9B;
  P1H       : byte absolute $9D;
  P2H       : byte absolute $9E;
  P3H       : byte absolute $9F;
  HB        : byte absolute $A1;
  P4H       : byte absolute $A2;
  P4        : byte absolute $A6;
  P4IO      : byte absolute $AE;
  CIDR      : byte absolute $B1;
  CIDFG     : byte absolute $B2;
  CIDPCR    : byte absolute $B3;
  FSKDR     : byte absolute $B4;
  DTMFDR    : byte absolute $B5;
  DTMFPT    : byte absolute $B6;
  DTMFAT    : byte absolute $B7;
  DTMFG     : byte absolute $BA;
  COMPR     : byte absolute $BB;
  IRC1      : byte absolute $BC;
  IRC2      : byte absolute $BD;
  CASPT     : byte absolute $BE;
  CASAT     : byte absolute $BF;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  REGVC     : byte absolute $C2;
  PMR       : byte absolute $C4;
  STATUS    : byte absolute $C5;
  FSKTC     : byte absolute $C6;
  FSKTB     : byte absolute $C7;
  DIVC      : byte absolute $C8;
  WDCON     : byte absolute $D8;
  EIE       : byte absolute $E8;
  EIP       : byte absolute $F8;
  CIDGD     : byte absolute $F9;
  CIDGA     : byte absolute $FA;


  INT20     : boolean absolute $90;  // P1
  INT21     : boolean absolute $91;
  INT22     : boolean absolute $92;
  INT23     : boolean absolute $93;
  INT30     : boolean absolute $94;
  INT31     : boolean absolute $95;
  INT32     : boolean absolute $96;
  INT33     : boolean absolute $97;

  ES1       : boolean absolute $AE;


  PS1       : boolean absolute $BE;

  SIO       : boolean absolute $C0;  // SCON1
  CLKIO     : boolean absolute $C1;
  SEDG      : boolean absolute $C2;
  SFQ       : boolean absolute $C3;
  REN1      : boolean absolute $C4;
  REGON     : boolean absolute $C5;
  SF1       : boolean absolute $C7;

  DIVA      : boolean absolute $C8;  // DIVC

  F1        : boolean absolute $D1;

  RWT       : boolean absolute $D8;  // WDCON
  EWT       : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  WFS       : boolean absolute $DC;
  POR       : boolean absolute $DE;

  EX2       : boolean absolute $E8;  // EIE
  EX3       : boolean absolute $E9;
  ECID      : boolean absolute $EA;
  EDIV      : boolean absolute $EB;
  ECOMP     : boolean absolute $EC;
  EWDI      : boolean absolute $ED;

  PX2       : boolean absolute $F8;  // EIP
  PX3       : boolean absolute $F9;
  PCID      : boolean absolute $FA;
  PDIV      : boolean absolute $FB;
  PCOMP     : boolean absolute $FC;
  PWDI      : boolean absolute $FD;


const
  SIOINT    = $3B;
  EXTI2     = $43;
  EXTI3     = $4B;
  CIDINT    = $53;
  DIVOVF    = $5B;
  COMP      = $63;
  WATCHD    = $6B;

implementation

end.
