// C868 processor definition file
// ==============================
// The Infineon C868 data sheet contains many errors.
// Please be sure to first read the comments below!


unit Sys_C868;

interface

var
  DPSEL     : byte absolute $84;
  PMCON0    : byte absolute $8E;
  CMCON     : byte absolute $8F;  // The CMCON address may also be 9FH, but I think
  P1DIR     : byte absolute $90;
  EXICON    : byte absolute $91;
  IRCON0    : byte absolute $92;
  IRCON1    : byte absolute $93;
  WDTCON    : byte absolute $A2;
  WDTREL    : byte absolute $A3;
  PSLRL     : byte absolute $A6;
  IEN0      : byte absolute $A8;
  IEN1      : byte absolute $A9;
  IEN2      : byte absolute $AA;
  IP1       : byte absolute $AC;
  SYSCON0   : byte absolute $AD;
  SYSCON1   : byte absolute $AF;
  P3DIR     : byte absolute $B0;
  P3ALT     : byte absolute $B1;
  WDTL      : byte absolute $B2;
  WDTH      : byte absolute $B3;
  P1ALT     : byte absolute $B4;
  CC63SRL   : byte absolute $B6;
  CC63SRH   : byte absolute $B7;
  IP0       : byte absolute $B8;
  ISSL      : byte absolute $BC;
  ISRL      : byte absolute $BC;
  ISSH      : byte absolute $BD;
  ISRH      : byte absolute $BD;
  IENL      : byte absolute $BE;
  INPL      : byte absolute $BE;
  IENH      : byte absolute $BF;
  INPH      : byte absolute $BF;
  SCUWDT    : byte absolute $C0;
  CC60RL    : byte absolute $C2;
  CC60RH    : byte absolute $C3;
  CC61RL    : byte absolute $C4;
  CC61RH    : byte absolute $C5;
  CC62RL    : byte absolute $C6;
  CC62RH    : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RC2L      : byte absolute $CA;
  RC2H      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  TRPCTRL   : byte absolute $CE;
  TRPCTRH   : byte absolute $CF;
  T13PRL    : byte absolute $D2;
  T13PRH    : byte absolute $D3;
  CC63RL    : byte absolute $D4;
  CC63RH    : byte absolute $D5;
  MCMCTR    : byte absolute $D6;  // Picked the most probable name from the data sheet!
  MODCTRL   : byte absolute $D6;
  MODCTRH   : byte absolute $D7;
  ADCON0    : byte absolute $D8;
  ADCON1    : byte absolute $D9;
  ADDATH    : byte absolute $DB;
  MCMOUTL   : byte absolute $DC;
  MCMOUTSL  : byte absolute $DC;
  MCMOUTH   : byte absolute $DD;
  MCMOUTSH  : byte absolute $DD;
  T12PRL    : byte absolute $DE;
  T12PRH    : byte absolute $DF;
  TCTR0L    : byte absolute $E2;
  TCTR0H    : byte absolute $E3;
  ISL       : byte absolute $E4;
  ISH       : byte absolute $E5;
  T12DTCL   : byte absolute $E6;
  T12DTCH   : byte absolute $E7;
  PMCON1    : byte absolute $E8;
  CMPMODIFL : byte absolute $EA;
  CMPMODIFH : byte absolute $EB;
  T12L      : byte absolute $EC;
  T12H      : byte absolute $ED;
  T13L      : byte absolute $EE;
  T13H      : byte absolute $EF;
  TCTR4L    : byte absolute $F2;
  TCTR2L    : byte absolute $F2;
  TCTR4H    : byte absolute $F3;
  CMPSTATL  : byte absolute $F4;
  CMPSTATH  : byte absolute $F5;
  T12MSELL  : byte absolute $F6;
  T12MSELH  : byte absolute $F7;
  PMCON2    : byte absolute $F8;
  VERSION   : byte absolute $F9;
  CC60SRL   : byte absolute $FA;
  CC60SRH   : byte absolute $FB;
  CC61SRL   : byte absolute $FC;
  CC61SRH   : byte absolute $FD;
  CC62SRL   : byte absolute $FE;
  CC62SRH   : byte absolute $FF;


  T2EX      : boolean absolute $91;  // Infineon name EXF2 conflicts with EXF2 bit in T2CON!
  INT3      : boolean absolute $93;  // I used the well-known 8052 symbol T2EX instead.


  ET2       : boolean absolute $AD;

  COUT63    : boolean absolute $B0;  // P3
  CTRAP     : boolean absolute $B1;
  COUT62    : boolean absolute $B2;
  CC62      : boolean absolute $B3;
  COUT61    : boolean absolute $B4;
  CC61      : boolean absolute $B5;
  COUT60    : boolean absolute $B6;
  CC60      : boolean absolute $B7;

  PT2       : boolean absolute $BD;

  WDTRE     : boolean absolute $C0;  // SCUWDT
  WDTRS     : boolean absolute $C1;
  WDTDIS    : boolean absolute $C2;
  WDTEOI    : boolean absolute $C3;
  WDTR      : boolean absolute $C4;
  PLLR      : boolean absolute $C6;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  ADCH0     : boolean absolute $D8;  // ADCON0
  ADCH1     : boolean absolute $D9;
  ADCH2     : boolean absolute $DA;
  ADM0      : boolean absolute $DC;
  ADM1      : boolean absolute $DD;
  ADBSY     : boolean absolute $DE;
  ADST      : boolean absolute $DF;

  ADCDIS    : boolean absolute $E8;  // PMCON1
  T2DIS     : boolean absolute $E9;
  CCUDIS    : boolean absolute $EA;

  ADCST     : boolean absolute $F8;  // PMCON2
  T2ST      : boolean absolute $F9;
  CCUST     : boolean absolute $FA;


const
  TIMER2    = $2B;
  ADCONV    = $33;
  EXTI2     = $3B;
  EXTI3     = $43;
  CCU60     = $83;
  CCU61     = $8B;
  CCU62     = $93;
  CCU63     = $9B;

implementation

end.
