unit solve_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.StdCtrls, Vcl.Imaging.pngimage,Z_class_u,Equation_Solver;

type
  TFormSolve = class(TForm)
    main_panel: TPanel;
    grp_SolveEq: TGroupBox;
    grp_x2: TGroupBox;
    lb_x2: TLabel;
    edt_x2_rel: TEdit;
    edt_x2_img: TEdit;
    grp_x1: TGroupBox;
    lb_x1: TLabel;
    edt_x1_rel: TEdit;
    edt_x1_img: TEdit;
    grp_x3: TGroupBox;
    lb_x3: TLabel;
    edt_x3_rel: TEdit;
    edt_x3_img: TEdit;
    label_top: TLabel;
    grp_solveStap: TGroupBox;
    memo_solveSteps: TMemo;
    img_close1: TImage;
    img_close2: TImage;
    Label1: TLabel;
    equation_image: TImage;
    procedure img_close1MouseEnter(Sender: TObject);
    procedure main_panelMouseEnter(Sender: TObject);
    procedure main_panelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure main_panelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure main_panelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure img_close2Click(Sender: TObject);
 private
  FisDown:boolean;
  FoldPos:TPoint;
  public
    procedure setRoots(roots:TrootsEquation);
    procedure SetX1(rel,img:double);
    procedure SetX2(rel,img:double);
    procedure SetX3(rel,img:double);
    procedure setSolveStape(slits:TStringList);
    constructor Create(AOwner: TComponent); override;

    { Public declarations }
  end;

var
  FormSolve: TFormSolve;

implementation

{$R *.dfm}
  procedure HideAndShowImage(img1,img2:TImage);
  begin
      img1.Hide;
      img2.Show;
  end;
constructor TFormSolve.Create(AOwner: TComponent);
begin
  inherited;
  FisDown:=False;
end;

procedure TFormSolve.img_close1MouseEnter(Sender: TObject);
begin
HideAndShowImage(img_close1,img_close2);
end;

procedure TFormSolve.img_close2Click(Sender: TObject);
begin
self.Close;
end;

procedure TFormSolve.main_panelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbLeft then
    begin
      FisDown:=true;
      FoldPos.X:=x;
      FoldPos.Y:=y;
    //  ShowMessage('down');
    end;
end;

procedure TFormSolve.main_panelMouseEnter(Sender: TObject);
begin
HideAndShowImage(img_close2,img_close1);
end;

procedure TFormSolve.main_panelMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
    valueOfX,ValueOfY:integer;
    DeltaOfX,DeltaOfY:integer;
    NewLeft,NewTop:integer;
  //  CheckRangeOfx:integer;
   // CheckRangOfY:integer;

begin
  if FisDown then
  begin
    DeltaOfX:=(x-FoldPos.X);
    DeltaOfY:=(y-FoldPos.Y);
    valueOfX:=(main_panel.Left+DeltaOfx);
    ValueOfY:=(main_panel.Top+DeltaOfY);
    NewLeft:=(self.Left+ valueOfX);
    NewTop:=(self.top+ValueOfY);
  //---------------------------------
   // CheckRangeOfx:=ValueOfChecking;
  //  CheckRangOfY:=ValueOfChecking;




  //------------------------------------



    self.Left:=NewLeft;
    self.Top:=NewTop;
  end;
end;
procedure TFormSolve.main_panelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbLeft then
    begin
      FisDown:=false;
      FoldPos.X:=0;
      FoldPos.Y:=0;
     // ShowMessage('up');
    end;
end;

procedure TFormSolve.setRoots(roots: TrootsEquation);

begin
  if length(roots)>=3 then
    begin
      SetX1(roots[0].ValueRel,roots[0].ValueImg);
      SetX2(roots[1].ValueRel,roots[1].ValueImg);
      SetX3(roots[2].ValueRel,roots[2].ValueImg);
    end
  else
    if Length(roots)>=2 then
    begin
      SetX1(roots[0].ValueRel,roots[0].ValueImg);
      SetX2(roots[1].ValueRel,roots[1].ValueImg);
      SetX3(0,0);
      grp_x3.Visible:=false;
    end
  else
    if Length(roots)>=1 then
    begin
    SetX1(roots[0].ValueRel,roots[0].ValueImg);
    SetX2(0,0);
    grp_x2.Visible:=false;
    SetX3(0,0);
    grp_x3.Visible:=false;
    end
    else
    begin
    SetX1(0,0);
    grp_x1.Visible:=false;
    SetX2(0,0);
    grp_x2.Visible:=false;
    SetX3(0,0);
    grp_x3.Visible:=false;
    end;
end;

procedure TFormSolve.setSolveStape(slits: TStringList);
begin
  memo_solveSteps.Lines.Clear;
  memo_solveSteps.Lines.AddStrings(slits);
end;

procedure TFormSolve.SetX1(rel, img: double);
begin
  edt_x1_rel.Text:='('+FloatToStr(rel)+')';
  edt_x1_img.Text:='+i('+FloatToStr(img)+')';
end;

procedure TFormSolve.SetX2(rel, img: double);
begin
 edt_x2_rel.Text:='('+FloatToStr(rel)+')';
 edt_x2_img.Text:='+i('+FloatToStr(img)+')';
end;

procedure TFormSolve.SetX3(rel, img: double);
begin
 edt_x3_rel.Text:='('+FloatToStr(rel)+')';
 edt_x3_img.Text:='+i('+FloatToStr(img)+')';
end;

end.
