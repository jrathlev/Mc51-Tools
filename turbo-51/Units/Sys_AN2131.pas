// Cypress EZ-USB Series 2100 Family
// =================================
// AN2121, AN2122, AN2125, AN2126, AN2131, AN2135, AN2136


// 8051 Core
// ---------


unit Sys_AN2131;

interface

var
  DPL0      : byte absolute $82;
  DPH0      : byte absolute $83;
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  SPC_FNC   : byte absolute $8F;
  EXIF      : byte absolute $91;
  MPAGE     : byte absolute $92;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
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

  RI_0      : boolean absolute $98;
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
  RI_1      : boolean absolute $C0;
  TI_1      : boolean absolute $C1;
  RB8_1     : boolean absolute $C2;
  TB8_1     : boolean absolute $C3;
  REN_1     : boolean absolute $C4;
  SM2_1     : boolean absolute $C5;
  SM1_1     : boolean absolute $C6;
  SM0_1     : boolean absolute $C7;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  F1        : boolean absolute $D1;
  INT6      : boolean absolute $DB;
  RESI      : boolean absolute $DC;
  ERESI     : boolean absolute $DD;
  SMOD1     : boolean absolute $DF;
  EUSB      : boolean absolute $E8;
  EI2C      : boolean absolute $E9;
  EX4       : boolean absolute $EA;
  EX5       : boolean absolute $EB;
  EX6       : boolean absolute $EC;
  PUSB      : boolean absolute $F8;
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


// USB-Registers
// -------------

// Endpoint 0-7 Data Buffers:


















// Isochronous Data:


















// Isochronous Byte Counts:


















// CPU Registers:






// Input-Output Port Registers:












// Isochronous Control/Status Registers:





// I2C Registers:





// Interrupts:














// Bulk Endpoints 0-7:

































// Global USB Registers:


















// Setup Data:

  // (8 bytes)

// Isochronous FIFO Sizes:


















implementation

end.
