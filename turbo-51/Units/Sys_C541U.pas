// C541U processor definition file
// ===============================


unit Sys_C541U;

interface

var
  WDTREL    : byte absolute $86;
  PCON1     : byte absolute $88;
  SSCCON    : byte absolute $93;
  STB       : byte absolute $94;
  SRB       : byte absolute $95;
  SSCMOD    : byte absolute $96;
  ITCON     : byte absolute $9A;
  IEN0      : byte absolute $A8;
  IEN1      : byte absolute $A9;
  SCF       : byte absolute $AB;
  SCIEN     : byte absolute $AC;
  SYSCON    : byte absolute $B1;
  IP0       : byte absolute $B8;
  IP1       : byte absolute $B9;
  WDCON     : byte absolute $C0;
  DCR       : byte absolute $C1;
  DPWDR     : byte absolute $C2;
  DIER      : byte absolute $C3;
  DIRR      : byte absolute $C4;
  FNRL      : byte absolute $C6;
  FNRH      : byte absolute $C7;
  EPBC0     : byte absolute $C1;
  EPBS0     : byte absolute $C2;
  EPIE0     : byte absolute $C3;
  EPIR0     : byte absolute $C4;
  EPBA0     : byte absolute $C5;
  EPLEN0    : byte absolute $C6;
  EPBC1     : byte absolute $C1;
  EPBS1     : byte absolute $C2;
  EPIE1     : byte absolute $C3;
  EPIR1     : byte absolute $C4;
  EPBA1     : byte absolute $C5;
  EPLEN1    : byte absolute $C6;
  EPBC2     : byte absolute $C1;
  EPBS2     : byte absolute $C2;
  EPIE2     : byte absolute $C3;
  EPIR2     : byte absolute $C4;
  EPBA2     : byte absolute $C5;
  EPLEN2    : byte absolute $C6;
  EPBC3     : byte absolute $C1;
  EPBS3     : byte absolute $C2;
  EPIE3     : byte absolute $C3;
  EPIR3     : byte absolute $C4;
  EPBA3     : byte absolute $C5;
  EPLEN3    : byte absolute $C6;
  EPBC4     : byte absolute $C1;
  EPBS4     : byte absolute $C2;
  EPIE4     : byte absolute $C3;
  EPIR4     : byte absolute $C4;
  EPBA4     : byte absolute $C5;
  EPLEN4    : byte absolute $C6;
  EPSEL     : byte absolute $D2;
  USBVAL    : byte absolute $D3;
  ADROFF    : byte absolute $D4;
  GEPIR     : byte absolute $D6;
  VR0       : byte absolute $FC;
  VR1       : byte absolute $FD;
  VR2       : byte absolute $FE;

  WS        : boolean absolute $8C;
  EWPD      : boolean absolute $8F;
  LED0      : boolean absolute $90;
  LED1      : boolean absolute $91;
  SCLK      : boolean absolute $92;
  SRI       : boolean absolute $93;
  STO       : boolean absolute $94;
  SLS       : boolean absolute $95;
  LED2      : boolean absolute $B0;
  DADD      : boolean absolute $B1;
  SWDT      : boolean absolute $C0;
  WDT       : boolean absolute $C1;
  WDTS      : boolean absolute $C2;
  OWDS      : boolean absolute $C3;
  F1        : boolean absolute $D1;


const
  SSCINT    = $43;
  USBEND    = $4B;
  USBDEV    = $53;
  WAKEUP    = $7B;

implementation

end.
