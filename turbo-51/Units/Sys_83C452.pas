// 83C452 processor definition file
// ================================


unit Sys_83C452;

interface

var
  DCON0     : byte absolute $92;
  DCON1     : byte absolute $93;
  SARL0     : byte absolute $A2;
  SARH0     : byte absolute $A3;
  SARL1     : byte absolute $B2;
  SARH1     : byte absolute $B3;
  P4        : byte absolute $C0;
  DARL0     : byte absolute $C2;
  DARH0     : byte absolute $C3;
  DARL1     : byte absolute $D2;
  DARH1     : byte absolute $D3;
  BCRL0     : byte absolute $E2;
  BCRH0     : byte absolute $E3;
  HSTAT     : byte absolute $E6;
  HCON      : byte absolute $E7;
  SLCON     : byte absolute $E8;
  SSTAT     : byte absolute $E9;
  IWPR      : byte absolute $EA;
  IRPR      : byte absolute $EB;
  CBP       : byte absolute $EC;
  FIN       : byte absolute $EE;
  CIN       : byte absolute $EF;
  BCRL1     : byte absolute $F2;
  BCRH1     : byte absolute $F3;
  ITHR      : byte absolute $F6;
  OTHR      : byte absolute $F7;
  IEP       : byte absolute $F8;
  MODE      : byte absolute $F9;
  ORPR      : byte absolute $FA;
  OWPR      : byte absolute $FB;
  IMIN      : byte absolute $FC;
  IMOUT     : byte absolute $FD;
  FOUT      : byte absolute $FE;
  COUT      : byte absolute $FF;

  HLD       : boolean absolute $95;
  HLDA      : boolean absolute $96;
  OFRS      : boolean absolute $E8;
  IFRS      : boolean absolute $E9;
  FRZ       : boolean absolute $EB;
  ICOI      : boolean absolute $EC;
  ICII      : boolean absolute $ED;
  OFI       : boolean absolute $EE;
  IFI       : boolean absolute $EF;
  EFIFO     : boolean absolute $F8;
  PDMA1     : boolean absolute $F9;
  PDMA0     : boolean absolute $FA;
  EDMA1     : boolean absolute $FB;
  EDMA0     : boolean absolute $FC;
  PFIFO     : boolean absolute $FD;


const
  FIFO      = $2B;
  DMA0      = $33;
  DMA1      = $3B;

implementation

end.
