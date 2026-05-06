(* Delphi components
   Display components for progress indication
   ==========================================
   
   Base on Progress Meter 1.0 copyright 1996
   by Mark Harwood - mark@temati.demon.co.uk

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   clock style progress meter added: Jan. 1999
   bar style progress meter added: Okt. 2002
   animated image progress meter added: Feb. 2004
   Windows style progress bar added: Apr. 2021
   last modified: July 2024
   *)  

unit Prgrss;

interface

uses
  System.SysUtils, Winapi.Messages, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

// Definiere CompPalPage (siehe Register)
{$Include UserComps.pas }

type
  TProgressStatus = (psOn, psOff, psNudge);
  TNewProgressBarStyle = (npsNormal,npsReverse,npsContinuous);

const
  clCobaltBlue = TColor($00A07000);

type
  TCustomProgress = class(TCustomControl)
  private
    { Private declarations }
    FProgressStatus    : TProgressStatus;
    FProgressTimer     : TTimer;
    FProgressForeColor : TColor;
    FProgressBackColor : TColor;
    FOnIncrement       : TNotifyEvent;
    FProgressInterval,
    FProgressCurrent,
    FIncr              : integer;
    procedure SetProgressStatus(value: TProgressStatus);
    procedure SetProgressInterval(value: integer);
    procedure SetProgressBackColor(value: TColor);
    procedure DrawStripe(i: integer);
    procedure SetOnIncrement(Value: TNotifyEvent);
  protected
    NudgeCounter : integer;
    procedure SetProgressForeColor(value: TColor);
    procedure Paint; override;
    procedure TimerComplete(sender: TObject);
    property BackColor: TColor read FProgressBackColor write SetProgressBackColor default clRed;
    property ForeColor: TColor read FProgressForeColor write SetProgressForeColor default clBlue;
    property Increment : integer read FIncr write FIncr default 2;
    property Interval: integer read FProgressInterval write SetProgressInterval default 100;
    property Status: TProgressStatus read FProgressStatus write SetProgressStatus default psOff;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Nudge;
    procedure Start;
    procedure Stop;
    procedure Pause (Paused : boolean);
  published
    property Anchors;
    property ShowHint;
    property Visible;
    property OnIncrement: TNotifyEvent read FOnIncrement write SetOnIncrement;
  end;

  TMDHProgress = class(TCustomProgress)
  published
    property ForeColor default clBlue;
    property BackColor default clRed;
    property Status;
    property Interval;
    end;

  TClkProgress = class(TCustomProgress)
  private
    Toggle,FFlat : boolean;
    function GetPos : integer;
    procedure SetPos (Value : integer);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Reset;
  published
    property BackColor default clWhite;
    property Flat : boolean read FFlat write FFlat;
    property ForeColor default clBlack;
    property Interval;
    property Position : integer read GetPos write SetPos;
    property Status;
  end;

  TBarProgress = class(TCustomProgress)
  private
    FBarWidth : integer;
    FBarFwd,FFlat : boolean;
    FTrans    : boolean;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Reset;
  published
    property BackColor default clBtnFace;
    property BarColor : TColor read FProgressForeColor write SetProgressForeColor default clCobaltBlue;
    property BarWidth : integer read FBarWidth write FBarWidth default 10;
    property Flat : boolean read FFlat write FFlat;
    property Increment;
    property Interval;
    property Status;
    property Transparent : boolean read FTrans write FTrans default true;
  end;

  TImageProgress = class(TCustomProgress)
  private
    FImgList   : TImageList;
    FOffImg    : boolean;
    procedure SetImgList (AImgList : TImageList);
    procedure SetOffImg (value : boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Reset;
  published
    property ShowOffImage : boolean read FOffImg write SetOffImg default false;
    property ImageList : TImageList read FimgList write SetImgList;
    property Status;
    property Interval;
  end;

// Replacement for TProgressBar with user defined colors
  TNewProgressBar = class(TCustomProgress)
  private
    FBarWidth,FBorder,
    FPos,FMin,FMax : integer;
    FBarFwd,
    FFlat,FTrans : boolean;
    FStyle       : TNewProgressBarStyle;
    procedure SetBarWidth(Value : integer);
    procedure SetBorder(Value : integer);
    procedure SetMin(Value : integer);
    procedure SetMax(Value : integer);
    procedure SetPos(Value : integer);
    procedure SetStyle(Value : TNewProgressBarStyle);
    procedure SetFlat(Value : boolean);
    procedure SetTrans(Value : boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Reset;
  published
    property BackColor default clBtnFace;
    property BarColor : TColor read FProgressForeColor write SetProgressForeColor default clCobaltBlue;
    property BarWidth : integer read FBarWidth write SetBarWidth default 10;
    property Border : integer read FBorder write SetBorder default 1;
    property Flat : boolean read FFlat write SetFlat default true;
    property Increment;
    property Interval;
    property Max : integer read FMax write SetMax default 100;
    property Min : integer read FMin write SetMin default 0;
    property Position : integer read FPos write SetPos;
    property Style : TNewProgressBarStyle read FStyle write SetStyle;
    property Transparent : boolean read FTrans write SetTrans default true;
  end;

procedure Register;

implementation

uses Winapi.Windows, Vcl.ImgList, Vcl.Styles, Vcl.Themes, StyleUtils;

const
  Pi180 = Pi/180.0;

constructor TCustomProgress.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  { set defaults }
  Width:=150;
  Height:=14;
  FProgressForeColor:=clBlue;
  FProgressBackColor:=clRed;
  FProgressInterval:=10;  // in ms
  FProgressStatus:=psOff;
  FProgressCurrent:=0;
  FIncr:=2; NudgeCounter:=0;
  FProgressTimer:=TTimer.Create(Self);
  with FProgressTimer do begin
    Enabled:=false;
    Interval:=FProgressInterval;
    OnTimer:=TimerComplete;
    end;
  end;

destructor TCustomProgress.Destroy;
begin
  FProgressTimer.Free;
  inherited Destroy;
end;

procedure TCustomProgress.DrawStripe(i: integer);
begin
  Canvas.Polygon([Point (i - Height, 1), Point(i, 1),
                  Point (i - Height, Height - 1), Point(i - (Height * 2), Height - 1)]);
end;

procedure TCustomProgress.Paint;
var
  x : integer;
begin
  if FProgressCurrent >= (Height * 2) then FProgressCurrent:=0;
  with Canvas do begin
    Brush.Color:=FProgressBackColor;
    Rectangle (0, 0, Width, Height);
    Brush.Color:=FProgressForeColor;
    Pen.Color:=FProgressForeColor;
    for x:=0 to (Width + Height) do
    begin
      if x mod (Height * 2)  = 0 then DrawStripe(x + FProgressCurrent);
    end; { for }
  end; { with }
end;

procedure TCustomProgress.SetProgressForeColor(value: TColor);
begin
  FProgressForeColor:=value;
  invalidate;
end;

procedure TCustomProgress.SetProgressBackColor(value: TColor);
begin
  FProgressBackColor:=value;
  invalidate
  end;

procedure TCustomProgress.SetProgressStatus(value: TProgressStatus);
begin
  if value <> FProgressStatus then begin
    FProgressStatus:=value;
    FProgressTimer.Enabled:=FProgressStatus=psOn;
    if FProgressStatus=psNudge then NudgeCounter:=0;
    Invalidate;
    end;
  end;

procedure TCustomProgress.SetProgressInterval(value: integer);
begin
  if value<>FProgressInterval then begin
    FProgressInterval:=value;
    FProgressTimer.Interval:=FProgressInterval;
    end;
  end;

procedure TCustomProgress.TimerComplete(sender: TObject);
begin
  FProgressCurrent:=FProgressCurrent+FIncr;
  if Assigned(FOnIncrement) then FOnIncrement(Self);
  Invalidate;
  end;

procedure TCustomProgress.SetOnIncrement(Value: TNotifyEvent);
begin
  FOnIncrement:=Value;
  end;

procedure TCustomProgress.Nudge;
begin
  if FProgressStatus<>psNudge then exit;
  inc (NudgeCounter);
  if NudgeCounter>FProgressInterval then begin
    TimerComplete (Self);
    NudgeCounter:=0;
  end;
end;

procedure TCustomProgress.Start;
begin
  Status:=psOn;
  end;

procedure TCustomProgress.Stop;
begin
  Status:=psOff;
  end;

procedure TCustomProgress.Pause (Paused : boolean);
begin
  if assigned(FProgressTimer) then FProgressTimer.Enabled:=not Paused;
  end;

{ ------------------------------------------------------------------- }
(* runde uhrenartige Fortschrittsanzeige *)
constructor TClkProgress.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  Toggle:=true; FFLat:=true;
  Width:=26; Height:=26;
  FProgressForeColor:=clBlack;
  FProgressBackColor:=clWhite;
  end;

procedure TClkProgress.Reset;
begin
  FProgressCurrent:=0;
  Toggle:=true;
  Invalidate;
  end;

procedure TClkProgress.Paint;
var
  x,y,r,h1,h2 : integer;
begin
  if FProgressCurrent>=360 then begin
    FProgressCurrent:=0;
    Toggle:=not Toggle;
    end;
  with Canvas do begin
    if FFlat then begin
      Pen.Color:=clBtnShadow; Brush.Color:=clBtnFace;
      Ellipse (0,0,Height,Height);
      end
    else begin
      Pen.Color:=clBtnShadow; Brush.Color:=clBtnShadow;
      Ellipse (0,0,Height-1,Height-1);
      Brush.Color:=clBtnHighlight; Pen.Color:=clBtnHighlight;
      Ellipse (1,1,Height,Height);
      end;
    Pen.Color:=clBtnFace;
    h1:=1; h2:=Height-1;
    if h2 mod 2 =0 then dec(h2);
    if FProgressCurrent>0 then begin
      if Toggle then Brush.Color:=FProgressForeColor
      else Brush.Color:=FProgressBackColor;
      Ellipse (h1,h1,h2,h2);
      end;
    r:=(h2-h1) div 2;
    x:=r+round(r*sin(Pi180*FProgressCurrent));
    if x<h1 then x:=h1; if x>h2 then x:=h2;
    y:=r-round(r*cos(Pi180*FProgressCurrent));
    if y<h1 then y:=h1; if y>h2 then y:=h2;
    if Toggle then Brush.Color:=FProgressBackColor
    else Brush.Color:=FProgressForeColor;
    Pie (h1,h1,h2,h2,r,1,x,y);
    end;
  end;

function TClkProgress.GetPos : integer;
begin
 Result:=MulDiv(FProgressCurrent,FProgressInterval,360);
 end;

procedure TClkProgress.SetPos (Value : integer);
begin
  Value:=MulDiv(Value,360,FProgressInterval);
  if Value<>FProgressCurrent then begin
    FProgressCurrent:=Value;
    Invalidate;
    end;
  end;

{ ------------------------------------------------------------------- }
(* balkenartige Fortschrittsanzeige *)
constructor TBarProgress.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width:=151; Height:=11; FTrans:=true; FFLat:=true;
  FProgressForeColor:=clCobaltBlue;
  FProgressBackColor:=clBtnFace;
  ParentColor:=FTrans;
  FBarWidth:=10;
  FBarFwd:=true;
  end;

procedure TBarProgress.Reset;
begin
  FProgressCurrent:=0;
  FBarFwd:=true;
  Invalidate;
  end;

procedure TBarProgress.Paint;
var
  x : integer;
begin
  if FProgressCurrent>=Width-FBarWidth-2 then begin
    FProgressCurrent:=0;
    FBarFwd:=not FBarFwd;    // toggle between forward and reverse movement
    end;
  with Canvas do begin
    if FTrans then Brush.Color:=Color
    else Brush.Color:=FProgressBackColor;
    with Pen do begin
      Color:=clBtnShadow;
      Width:=1;
      end;
    if FFLat then begin
      Rectangle(0,0,Width,Height);
      end
    else begin
      Rectangle(0,0,Width,Height);
      Pen.Color:=clBtnHighlight;
      MoveTo (Width-1,0); LineTo (Width-1,Height-1); LineTo (0,Height-1);
      end;
    Brush.Color:=FProgressForeColor;
    if FBarFwd then x:=FProgressCurrent+2 else x:=Width-FBarWidth-2-FProgressCurrent;
    FillRect (Rect(x,2,x+FBarWidth,Height-2));
    end;
  end;

{ ------------------------------------------------------------------- }
(* Fortschrittsanzeige mit animierten Bildern*)
constructor TImageProgress.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImgList:=nil;
  Width:=128;
  Height:=32;
  FIncr:=1;
  end;

procedure TImageProgress.SetImgList (AImgList : TImageList);
begin
  Width:=Width+1; Paint;
  FImgList:=AImgList;
  if assigned(FImgList) then begin
    Width:=FImgList.Width;
    Height:=FImgList.Height;
    end;
  Reset;
  end;

procedure TImageProgress.SetOffImg (value : boolean);
begin
  FOffImg:=Value;
  Invalidate;
  end;

procedure TImageProgress.Reset;
begin
  FProgressCurrent:=0;
  Invalidate;
  end;

procedure TImageProgress.Paint;
var
  n : integer;
begin
  if assigned(FImgList) then begin
    if FOffImg then begin
      if Status=psOff then n:=0
      else n:=FProgressCurrent mod (FImgList.Count-1) +1;
      end
    else n:=FProgressCurrent mod FImgList.Count;
    Width:=FImgList.Width; Height:=FImgList.Height;
    FImgList.Draw(Canvas,0,0,n,dsTransparent,itImage);
    end
  else with Canvas do begin
    Brush.Color:=clWhite;
    FillRect(Rect(0,0,Width,Height));
    Brush.Color:=clRed;
    FillRect(Rect(0,0,FProgressCurrent mod Width,Height));
    end;
  end;

{ ------------------------------------------------------------------- }
(* balkenartige Fortschrittsanzeige *)
constructor TNewProgressBar.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width:=151; Height:=11; FTrans:=true; FFLat:=true;
  FProgressForeColor:=clCobaltBlue;
  FProgressBackColor:=clBtnFace;
  ParentColor:=FTrans;
  FPos:=0; FMin:=0; FMax:=100;
  FBarWidth:=50; FBorder:=1;
  FStyle:=npsNormal;
  Reset;
  end;

procedure TNewProgressBar.Reset;
begin
  if FStyle=npsNormal then begin
    FPos:=0;
    Status:=psOff;
    end
  else begin
    Status:=psOn;
    if FStyle=npsReverse then begin
      FProgressCurrent:=0;
      FBarFwd:=true;
      end
    else FProgressCurrent:=FBarWidth div 10;
    end;
  Invalidate;
  end;

procedure TNewProgressBar.SetBarWidth(Value : integer);
begin
  if FBarWidth<>Value then begin
    FBarWidth:=Value;
    Invalidate;
    end;
  end;

procedure TNewProgressBar.SetBorder(Value : integer);
begin
  if FBorder<>Value then begin
    FBorder:=Value;
    Invalidate;
    end;
  end;

procedure TNewProgressBar.SetMin(Value : integer);
begin
  if FMin<>Value then begin
    FMin:=Value;
    Invalidate;
    end;
  end;

procedure TNewProgressBar.SetMax(Value : integer);
begin
  if FMax<>Value then begin
    FMax:=Value;
    Invalidate;
    end;
  end;

procedure TNewProgressBar.SetPos(Value : integer);
begin
  if FPos<>Value then begin
    FPos:=Value;
    Invalidate;
    end;
  end;

procedure TNewProgressBar.SetStyle(Value : TNewProgressBarStyle);
begin
  if FStyle<>Value then begin
    FStyle:=Value;
    Reset;
    end;
  end;

procedure TNewProgressBar.SetFlat(Value : boolean);
begin
  if FFlat<>Value then begin
    FFlat:=Value;
    Invalidate;
    end;
  end;

procedure TNewProgressBar.SetTrans(Value : boolean);
begin
  if FTrans<>Value then begin
    FTrans:=Value;
    Invalidate;
    end;
  end;

procedure TNewProgressBar.Paint;
var
  x1,x2,b : integer;
  bcol,fcol : TColor;
  ed : TThemedElementDetails;
begin
  if (StyleServices is TUxThemeStyle) then begin // default style 'Windows'
    bcol:=FProgressBackColor; fcol:=FProgressForeColor;
    end
  else with StyleServices do begin
    bcol:=GetStyleColor(scPanel);
//    ed:=GetElementDetails(tpBar);
//    if not GetElementColor(ed,ecFillColor,fcol) then
    fcol:=GetStyleColor(scComboBox);
    if ColorDistanceRGBLinear(bcol,fcol)<50 then fcol:=GetSysColor(FProgressForeColor);
//    if not GetElementColor(GetElementDetails(tpBar),ecGradientColor1,fcol) then fcol:=FProgressForeColor;
    end;
  with Canvas do begin
    if FTrans then Brush.Color:=GetSysColor(Color)
    else Brush.Color:=bcol; //FProgressBackColor;
    with Pen do begin
      Color:=GetSysColor(clBtnShadow);   // border color
      Width:=1;
      end;
    if FFLat then begin
      Rectangle(0,0,Width,Height);
      end
    else begin
      Rectangle(0,0,Width,Height);
      Pen.Color:=GetSysColor(clBtnHighlight);
      MoveTo (Width-1,0); LineTo (Width-1,Height-1); LineTo (0,Height-1);
      end;
    b:=FBorder+Pen.Width;
    if b>Height div 2 then b:=Height div 2 -1;
    end;
  with Canvas do if FStyle=npsNormal then begin
    Brush.Color:=fcol; //FProgressForeColor;
    FillRect (Rect(b,b,MulDiv(FPos-FMin,Width-2*b,FMax-FMin)+b,Height-b));
    end
  else begin
    Brush.Color:=fcol; //FProgressForeColor;
    if FStyle=npsReverse then begin
      if FProgressCurrent>=Width-FBarWidth-2 then begin
        FProgressCurrent:=0;
        FBarFwd:=not FBarFwd;    // toggle between forward and reverse movement
        end;
      if FBarFwd then x1:=FProgressCurrent+b else x1:=Width-FBarWidth-b-FProgressCurrent;
      FillRect (Rect(x1,b,x1+FBarWidth,Height-b));
      end
    else begin // continous
      if FProgressCurrent>=Width+FBarWidth-(FBarWidth div 10) then FProgressCurrent:=FBarWidth div 10;
      x1:=FProgressCurrent-FBarWidth;
      if x1<2 then x1:=b;
      x2:=FProgressCurrent;
      if x2>Width-b then x2:=Width-b;
      FillRect (Rect(x1,b,x2,Height-b));
      end;
    end;
  end;

{ ---------------------------------------------------------------- }
procedure Register;
begin
  RegisterComponents(CompPalPage, [TMDHProgress]);
  RegisterComponents(CompPalPage, [TClkProgress]);
  RegisterComponents(CompPalPage, [TBarProgress]);
  RegisterComponents(CompPalPage, [TImageProgress]);
  RegisterComponents(CompPalPage, [TNewProgressBar]);
  end;

end.
