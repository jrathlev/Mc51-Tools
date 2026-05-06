// CY7C68013 Cypress USB peripheral controller definition file
// ===========================================================
// contributed by Remy Fourre, 21 Jan 2004
// 
// last modified:  W.W. Heinz, 16 Apr 2004
// ---------------------------------------
// - added bit symbol definitions for port A alternate functions
// - deleted old 8051 bit symbols for port 3
// - renamed all SCON0 bit symbols according to Cypress specification
// - renamed T2CON bits CPRL2 and CT2 according to Cypress specification
// - added missing bit symbol F1 for PSW
// - added missing bit symbols INT6, RESI and ERESI for EICON
// - renamed CODE addresses conforming to historical Intel conventions
// - added XDATA symbol WAVEDATA (address of waveform descriptors)
// - named XDATA symbols GPIFHOLDTIME, EP4CFG, EP6CFG and EP8CFG
// according to Cypress specification
// 
// References:
// 
// - EZ-USB FX2 Technical Reference Manual V2.1
// - CY7C68013 EZ-USB FX2 USB Microcontroller
// High-speed USB Peripheral Controller
// Document #: 38-08012 Rev. *C, revised Dec 19, 2002


unit Sys_EZUSBFX2;

interface

var
  IOA       : byte absolute $80;  // SFR
  DPL0      : byte absolute $82;
  DPH0      : byte absolute $83;
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  IOB       : byte absolute $90;
  EXIF      : byte absolute $91;
  MPAGE     : byte absolute $92;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  AUTOPTRH1 : byte absolute $9A;
  AUTOPTRL1 : byte absolute $9B;
  AUTOPTRH2 : byte absolute $9D;
  AUTOPTRL2 : byte absolute $9E;
  IOC       : byte absolute $A0;  // not present at the 56-pin packages
  INT2CLR   : byte absolute $A1;
  INT4CLR   : byte absolute $A2;
  EP2468STAT: byte absolute $AA;
  EP24FIFOFLGS: byte absolute $AB;
  EP68FIFOFLGS: byte absolute $AC;
  AUTOPTRSETUP: byte absolute $AF;
  IOD       : byte absolute $B0;
  IOE       : byte absolute $B1;  // not present at the 56-pin packages
  OEA       : byte absolute $B2;
  OEB       : byte absolute $B3;
  OEC       : byte absolute $B4;
  OED       : byte absolute $B5;
  OEE       : byte absolute $B6;
  EP01STAT  : byte absolute $BA;
  GPIFTRIG  : byte absolute $BB;
  GPIFSGLDATH: byte absolute $BD;
  GPIFSGLDATLX: byte absolute $BE;
  GPIFSGLDATLNOX: byte absolute $BF;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  EICON     : byte absolute $D8;
  EIE       : byte absolute $E8;
  EIP       : byte absolute $F8;

  SLOE      : boolean absolute $82;
  WU2       : boolean absolute $83;
  FIFOADR0  : boolean absolute $84;
  FIFOADR1  : boolean absolute $85;
  PKTEND    : boolean absolute $86;
  FLAGD     : boolean absolute $87;
  SLCS      : boolean absolute $87;


  RI_0      : boolean absolute $98;  // SCON0
  TI_0      : boolean absolute $99;
  RB8_0     : boolean absolute $9A;
  TB8_0     : boolean absolute $9B;
  REN_0     : boolean absolute $9C;
  SM2_0     : boolean absolute $9D;
  SM1_0     : boolean absolute $9E;
  SM0_0     : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  ES1       : boolean absolute $AE;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  PS1       : boolean absolute $BE;

  RI_1      : boolean absolute $C0;  // SCON1
  TI_1      : boolean absolute $C1;
  RB8_1     : boolean absolute $C2;
  TB8_1     : boolean absolute $C3;
  REN_1     : boolean absolute $C4;
  SM2_1     : boolean absolute $C5;
  SM1_1     : boolean absolute $C6;
  SM0_1     : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  INT6      : boolean absolute $DB;  // EICON
  RESI      : boolean absolute $DC;
  ERESI     : boolean absolute $DD;
  SMOD1     : boolean absolute $DF;

  EUSB      : boolean absolute $E8;  // EIE
  EI2C      : boolean absolute $E9;
  EX4       : boolean absolute $EA;
  EX5       : boolean absolute $EB;
  EX6       : boolean absolute $EC;

  PUSB      : boolean absolute $F8;  // EIP
  PI2C      : boolean absolute $F9;
  PX4       : boolean absolute $FA;
  PX5       : boolean absolute $FB;
  PX6       : boolean absolute $FC;


const
  SINT0     = $23;
  TIMER2    = $2B;
  RESUME    = $33;
  SINT1     = $3B;
  USBINT    = $43;
  I2CINT    = $4B;
  EXTI4     = $53;
  EXTI5     = $5B;
  EXTI6     = $63;

  // waveform

















  // general configuration












  // UDMA

  // endpoint configuration
































  // interrupts

























  // input/output








  // UDMA CRC



  // USB control








  // endpoints



































  // GPIF






  // flowstate






























  // endpoint buffers








implementation

end.
