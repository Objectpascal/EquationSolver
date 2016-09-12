unit problems_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  ColorButton_u, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  Tform_Problems = class(TForm)
    main_panel: TPanel;
    lb_EquationSimple: TLabel;
    lb_sup3: TLabel;
    grp_genEq: TGroupBox;
    btn_Solve: TColorButton;
    img_close1: TImage;
    img_close2: TImage;
    main_image: TImage;
    grp_a: TGroupBox;
    lb_a: TLabel;
    edt_a_rel: TEdit;
    edt_a_img: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    grp_b: TGroupBox;
    lb_b: TLabel;
    edt_b_rel: TEdit;
    edt_b_img: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    grp_c: TGroupBox;
    lb_c: TLabel;
    edt_c_rel: TEdit;
    edt_c_img: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    grp_d: TGroupBox;
    lb_d: TLabel;
    edt_d_rel: TEdit;
    edt_d_img: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    image_icoMath: TImage;
    procedure img_close2Click(Sender: TObject);
    procedure img_close1MouseEnter(Sender: TObject);
    procedure main_imageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure main_imageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure main_imageMouseEnter(Sender: TObject);
    procedure main_imageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn_SolveClick(Sender: TObject);
    procedure edt_b_relChange(Sender: TObject);
    procedure edt_a_relExit(Sender: TObject);
  private
  FisDown:boolean;
  FoldPos:TPoint;

  procedure OnlyFloatNumber(edit:TEdit);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;


  end;

var
  form_Problems: Tform_Problems;

implementation

{$R *.dfm}

uses solve_u,Equation_Solver,Z_class_u;
 procedure HideAndShowImage(img1,img2:TImage);
begin
    img1.Hide;
    img2.Show;
end;
procedure Tform_Problems.btn_SolveClick(Sender: TObject);
var
  formsolve:TFormSolve;
  Eq3:TEquation3;
  fa,fb,fc,fd:TzNumber;
begin
  formsolve:=TFormSolve.Create(self);
  try
  try
  fa:=TzNumber.create(StrToFloat(edt_a_rel.Text),StrToFloat(edt_a_img.Text));
  fb:=TzNumber.create(StrToFloat(edt_b_rel.Text),StrToFloat(edt_b_img.Text));
  fc:=TzNumber.create(StrToFloat(edt_c_rel.Text),StrToFloat(edt_c_img.Text));
  fd:=TzNumber.create(StrToFloat(edt_d_rel.Text),StrToFloat(edt_d_img.Text));

  Eq3:=TEquation3.create(fa,fb,fc,fd);
  formsolve.setRoots(eq3.getRoots);
  formsolve.setSolveStape(Eq3.getStaps);
  formSolve.ShowModal;
  except
    on e:exception do
    begin
      ShowMessage(e.Message);
    end;

  end;
  finally
    FreeAndNil(formsolve);
    FreeAndNil(Eq3);
  end;
end;

constructor Tform_Problems.Create(AOwner: TComponent);
begin
  inherited;
  FisDown:=false;
end;

procedure Tform_Problems.edt_a_relExit(Sender: TObject);
begin
if trim((Sender as Tedit).Text)='' then
  (Sender as Tedit).Text:='0';
end;

procedure Tform_Problems.edt_b_relChange(Sender: TObject);
begin
OnlyFloatNumber((Sender as Tedit));

end;

procedure Tform_Problems.img_close1MouseEnter(Sender: TObject);
begin
HideAndShowImage(img_close1,img_close2);
end;

procedure Tform_Problems.img_close2Click(Sender: TObject);
begin
self.Close;
end;

procedure Tform_Problems.main_imageMouseDown(Sender: TObject;
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

procedure Tform_Problems.main_imageMouseEnter(Sender: TObject);
begin
HideAndShowImage(img_close2,img_close1);
end;

procedure Tform_Problems.main_imageMouseMove(Sender: TObject;
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
procedure Tform_Problems.main_imageMouseUp(Sender: TObject;
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

procedure Tform_Problems.OnlyFloatNumber(edit: TEdit);
var
  str:string;
  numberstr:string;
  count:integer;
  count_fsila:integer;
begin
  count_fsila:=0;
  str:=edit.Text;
    for count := 1 to length(str) do
      begin
        if str[count] in ['0'..'9'] then
          begin
            numberstr:=numberstr+str[count];
          end;
        if count_fsila<1 then
        begin
            if str[count] in[',','.'] then
              begin
                inc(count_fsila,1);
                numberstr:=numberstr+'.';
              end;
        end;
      end;

 edit.Text:=numberstr;
 //edit.SelLength:=length(numberstr);
 edit.SelStart:=length(numberstr);
 edit.SetFocus;



end;

end.
