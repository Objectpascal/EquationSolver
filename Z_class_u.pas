unit Z_class_u;

interface

uses sysutils, classes;

const
  ZeroComplixNumber: string = 'Divid by zero Exception';
  NULLComplixNumber: string = ' NUll Compliex number';

type

  TComplixNumberZeroExcepion = class(Exception); // my exceptin
  TNULLComplixNumberExcepion = class(Exception);

  TZNumber = record // z number new Type
  type
    TZArray = array of TZNumber;
  private
    Freal: double; // real value
    Fimg: double; // img value
    procedure setImg(const Value: double); // Ê÷⁄ ﬁÌ„… «·⁄œœ «· ŒÌ·Ì
    procedure setReal(const Value: double); // Ê÷⁄ ﬁÌ„… «·⁄œœ «·ÕÌﬁÌÌ
    function CheckIsZero(v: double): double;
    function getLength: double;
    function getcosA: double;
    function getSinA: double;
    function getAngle_cosA: double;
    function getAngle_SinA: double;
    function getAngle_rad: double;
    function getAngle_deg: double;
    function getConjugate: TZNumber;

  public
    constructor create(vRel, vImg: double); // constructor
    function ToString: string; // to string
    function PowerTo(E: word): TZNumber; // self^E
    function getRoots(numberRoots: word): TZArray;///power(self,1/E);
    /// property
    property ValueRel: double read Freal write setReal;
    // value of real //property
    property ValueImg: double read Fimg write setImg; // value of img //property
    property Length: double read getLength;
    property Cos_a: double read getcosA;
    property Sin_a: double read getSinA;
    property Angle_Cos_a_rad: double read getAngle_cosA;
    property Angle_Sin_a_rad: double read getAngle_SinA;
    property Angle_rad: double read getAngle_rad;
    property Angle_deg: double read getAngle_deg;
    property conjugate: TZNumber read getConjugate;

    /// //operation
    // -----------------------ADD---------------------------------------
    // z+z
    // z+3
    // 3+z
    class operator Implicit(a: double): TZNumber;
    class operator Add(a: TZNumber; b: TZNumber): TZNumber;

    // ----------------------------------------------------------------
    // -----------------------Subtract---------------------------------------
    // z-z
    // z-3
    // 3-z
    class operator Subtract(a: TZNumber; b: TZNumber): TZNumber;

    // ----------------------------------------------------------------

    // -----------------------Multiply---------------------------------------
    // z*z
    // z*3
    // 3*z
    class operator Multiply(a: TZNumber; b: TZNumber): TZNumber;

    // ----------------------------------------------------------------
    // -----------------------Divide---------------------------------------
    // //z/z
    // z/3
    // 3/z
    class operator Divide(a: TZNumber; b: TZNumber): TZNumber;
    // ----------------------------------------------------------------
    /// -
    /// +
    class operator Negative(a: TZNumber): TZNumber; // -
    class operator Positive(a: TZNumber): TZNumber; // +

    /// boolean operations

    // =
    // <>
    class operator Equal(a: TZNumber; b: TZNumber): boolean;//=


    class operator NotEqual(a: TZNumber; b: TZNumber): boolean;//<>


    ///
    /// >
    /// >=
    class operator GreaterThan(a: TZNumber; b: TZNumber): boolean;
    class operator GreaterThanOrEqual(a: TZNumber; b: TZNumber): boolean;
    /// ///
    /// <
    /// <=
    class operator LessThan(a: TZNumber; b: TZNumber): boolean;

    class operator LessThanOrEqual(a: TZNumber; b: TZNumber): boolean;

  end;

implementation

uses Math;

{ TZNumber }

class operator TZNumber.Add(a, b: TZNumber): TZNumber;
begin
  result := TZNumber.create(a.Freal + b.Freal, a.Fimg + b.Fimg);
end;

function TZNumber.CheckIsZero(v: double): double;
var
  isZero: boolean;
  frc: double;
begin
  isZero := (RoundTo(v, -8) = 0);
  if (isZero) then
    result := 0
  else
  begin
    frc := Frac(v);
    if (RoundTo(frc, -13) = 0) then
      frc := 0;

    result := (v) - Frac(v) + frc;
  end;
end;

constructor TZNumber.create(vRel, vImg: double);
begin
  ValueRel := vRel;
  ValueImg := vImg;

end;

class operator TZNumber.Divide(a, b: TZNumber): TZNumber;
var
  divider: TZNumber;
  vRel, vImg: double;
begin
  if (b = 0) then
    raise TComplixNumberZeroExcepion.create(ZeroComplixNumber);
  divider := b * (b.conjugate);
  result := (a * (b.conjugate)) *( 1/ divider.Length);
end;

class operator TZNumber.Equal(a: TZNumber; b: TZNumber): boolean;
begin
  result := (a.Freal = b.Freal) and (a.Fimg = b.Fimg);
end;

function TZNumber.getAngle_cosA: double;
begin
  result := ArcCos(Cos_a);
end;

function TZNumber.getAngle_deg: double;
begin
  result := (Angle_rad * 180) / pi;
end;

function TZNumber.getAngle_rad: double;
var
  cosA, sinA: double;
  rad_CosA, rad_Sina: double;

begin
  cosA := Cos_a;
  sinA := Sin_a;
  rad_CosA := Angle_Cos_a_rad;
  rad_Sina := Angle_Sin_a_rad;
  // ----check first zerro---------------------------
  if (cosA = 0) then
  begin
    result := rad_Sina;
    exit;
  end
  else if (sinA = 0) then
  begin
    result := rad_CosA;
    exit;
  end;

  // -------------------------------

  if (cosA > 0) and (sinA > 0) then
  begin
    result := rad_CosA;
  end
  else if (cosA > 0) and (sinA < 0) then
  begin
    result := rad_Sina;
  end
  else if (cosA < 0) and (sinA > 0) then
  begin
    result := rad_CosA;
  end
  else if (cosA < 0) and (sinA < 0) then
  begin
    result := (rad_Sina - pi / 2);
  end;
end;

function TZNumber.getAngle_SinA: double;
begin
  result := ArcSin(Sin_a);
end;

function TZNumber.getConjugate: TZNumber;
begin
  result := TZNumber.create(Freal, -Fimg);
end;

function TZNumber.getcosA: double;
var
  len: double;
begin
  result := 0;
  len := Length;
  if (len <> 0) then
  begin
    result := Freal / len;
  end
  else
    raise TComplixNumberZeroExcepion.create(ZeroComplixNumber);

end;

function TZNumber.getLength: double;
begin
  /// /sqrt(rel≤ +img≤);
  result := sqrt((Power(Freal, 2) + Power(Fimg, 2)));
end;

function TZNumber.getRoots(numberRoots: word): TZArray;
var
  rad_angle: double;
  rel, img: double;
  newAngle, newLength: double;
  k: integer;
begin

  if numberRoots = 0 then
    raise TNULLComplixNumberExcepion.create(NULLComplixNumber);

  SetLength(result, numberRoots);
  rad_angle := Angle_rad;
  newLength := Power(Length, 1 / numberRoots);
  newAngle := 0;
  rel := 0;
  img := 0;
  for k := 0 to (numberRoots - 1) do
  begin
    newAngle := ((rad_angle / numberRoots) + (2 * pi * k / numberRoots));
    rel := newLength * (Cos(newAngle));
    img := newLength * (Sin(newAngle));
    result[k] := TZNumber.create(rel, img);
  end;

end;

function TZNumber.getSinA: double;
var
  len: double;
begin
  result := 0;
  len := Length;
  if (len <> 0) then
  begin
    result := Fimg / len;
  end
  else
    raise TComplixNumberZeroExcepion.create(ZeroComplixNumber);

end;

class operator TZNumber.GreaterThan(a, b: TZNumber): boolean;
begin
   result:=(a.Fimg=b.Fimg) and (a.Freal>b.Freal);
end;

class operator TZNumber.Implicit(a: double): TZNumber;
begin
  result:=TZNumber.create(a,0);
end;

class operator TZNumber.GreaterThanOrEqual(a, b: TZNumber): boolean;
begin
  result:=(a>b) or (a=b);
end;

class operator TZNumber.LessThanOrEqual(a, b: TZNumber): boolean;
begin
 result:=(b>=a);
end;

class operator TZNumber.LessThan(a, b: TZNumber): boolean;
begin
  result:=(b>a);
end;

class operator TZNumber.Multiply(a, b: TZNumber): TZNumber;
var
  vRel, vImg: double;
begin
  vRel := (a.Freal * b.Freal) - (a.Fimg * b.Fimg);
  vImg := (a.Fimg * b.Freal) + (a.Freal * b.Fimg);
  result := TZNumber.create(vRel, vImg);
end;

class operator TZNumber.Negative(a: TZNumber): TZNumber;
begin
  result := -1 * a;
end;

class operator TZNumber.NotEqual(a, b: TZNumber): boolean;
begin
  result := not(a = b);
end;

class operator TZNumber.Positive(a: TZNumber): TZNumber;
begin
  result := +1 * a;
end;

function TZNumber.PowerTo(E: word): TZNumber;
var
  newAngle: double;
  newLength: double;
  rel, img: double;
  n: integer;
begin
  result := TZNumber.create(1, 0);
  for n := 1 to E do
    result := result * self;
end;

procedure TZNumber.setImg(const Value: double);
begin
  Fimg :=CheckIsZero(value);// RoundTo(value,-13);//RoundTo(CheckIsZero(Value), -14);
end;

procedure TZNumber.setReal(const Value: double);
begin
  Freal :=CheckIsZero(value);// RoundTo(value,-14);//CheckIsZero(Value), -14);
end;

class operator TZNumber.Subtract(a, b: TZNumber): TZNumber;
begin
  result := a + (-b);
end;

function TZNumber.ToString: string;
begin
  result := FloatToStr(Freal) + ' + i(' + FloatToStr(Fimg) + ')';
end;

end.
