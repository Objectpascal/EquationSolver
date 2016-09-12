unit Main_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Vcl.StdCtrls, ColorButton_u, Vcl.Imaging.jpeg, Vcl.Menus;
const
  ValueOfChecking=50;//50 px
type
  TForm_Main = class(TForm)
    main_panel: TPanel;
    img_close2: TImage;
    img_info2: TImage;
    img_close1: TImage;
    img_info1: TImage;
    btnSolve_Eq: TColorButton;
    Image_background: TImage;
    MainMenu1: TMainMenu;
    dd1: TMenuItem;
    DrawFunction1: TMenuItem;
    SolveEquation1: TMenuItem;
    procedure img_close2Click(Sender: TObject);
    procedure img_close1MouseEnter(Sender: TObject);
    procedure img_info1MouseEnter(Sender: TObject);
    procedure Image_backgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image_backgroundMouseEnter(Sender: TObject);
    procedure Image_backgroundMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image_backgroundMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnSolve_EqClick(Sender: TObject);
    procedure SolveEquation1Click(Sender: TObject);
    procedure DrawFunction1Click(Sender: TObject);
  public
    FisDown:boolean;
    FoldPos:TPoint;
  protected

    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;


    { Public declarations }
  end;

var
  Form_Main: TForm_Main;

implementation

{$R *.dfm}

uses problems_u;

procedure HideAndShowImage(img1,img2:TImage);
begin
    img1.Hide;
    img2.Show;
end;

procedure TForm_Main.btnSolve_EqClick(Sender: TObject);
var
  FormProblem:Tform_Problems;
begin
  FormProblem := Tform_Problems.Create(self);
  try
    FormProblem.ShowModal;

  finally
    FreeAndNil(FormProblem);
  end;

end;

constructor TForm_Main.Create(AOwner: TComponent);
begin
  inherited;
  FisDown := false;
end;

procedure TForm_Main.DrawFunction1Click(Sender: TObject);
begin
Application.MessageBox('Coming Soon','Draw Function',MB_OK+MB_ICONINFORMATION);
end;

procedure TForm_Main.Image_backgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
    begin
      FisDown:=true;
      FoldPos.X:=x;
      FoldPos.Y:=y;
    //  ShowMessage('down');
    end;
end;

procedure TForm_Main.Image_backgroundMouseEnter(Sender: TObject);
begin
HideAndShowImage(img_close2,img_close1);
HideAndShowImage(img_info2,img_info1);
end;

procedure TForm_Main.Image_backgroundMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
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


procedure TForm_Main.Image_backgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button=mbLeft then
    begin
      FisDown:=false;
      FoldPos.X:=0;
      FoldPos.Y:=0;
     // ShowMessage('up');
    end;
end;

procedure TForm_Main.img_close1MouseEnter(Sender: TObject);
begin
HideAndShowImage(img_close1,img_close2);
end;

procedure TForm_Main.img_close2Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm_Main.img_info1MouseEnter(Sender: TObject);
begin
HideAndShowImage(img_info1,img_info2);
end;

procedure TForm_Main.SolveEquation1Click(Sender: TObject);
begin
btnSolve_Eq.Click;
end;

end.
