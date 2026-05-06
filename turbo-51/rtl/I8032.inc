{$IDATA }

Var
  T2CON:    Byte absolute $C8;
  T2MOD:    Byte absolute $C9;
  RCAP2L:   Byte absolute $CA;
  RCAP2H:   Byte absolute $CB;
  TL2:      Byte absolute $CC;
  TH2:      Byte absolute $CD;

{ T2CON }
  TF2:      Boolean absolute T2CON.7;
  EXF2:     Boolean absolute T2CON.6;
  RCLK:     Boolean absolute T2CON.5;
  TCLK:     Boolean absolute T2CON.4;
  EXEN2:    Boolean absolute T2CON.3;
  TR2:      Boolean absolute T2CON.2;
  C_T2:     Boolean absolute T2CON.1;
  CP_RL2:   Boolean absolute T2CON.0;

{ IE}
  ET2:      Boolean absolute IE.5;

{ IP }
  PT2:      Boolean absolute IP.5;

{ P1 }
  T2EX:     Boolean absolute P1.1;
  T2:       Boolean absolute P1.0;

