
{***********************************************

  from wikipedia
  https://en.wikipedia.org/wiki/Cubic_function

//**************************************************
}

unit Equation_Solver;

interface

uses Z_class_u,sysutils,classes;
  type
    TrootsEquation=array of TZNumber;
//------------------abstarct type------------------------
    TEquationAbstarct=class
      private
        FEquationFormla:String;
        FEquaionStaps:TStringList;
        FEquationDegree:word;
        FEquationName:string;
    procedure setEqDegree(const Value: word);
    procedure setEqName(const Value: string);
    procedure setFormla(const Value: string);
    public

        constructor create();virtual;
        destructor Destroy; override;
        function getRoots():TrootsEquation;virtual;abstract;
        procedure Display();
        function ToString: string; override;
        procedure AddStap(strLits:TStrings);overload;
        procedure AddStap(const str:string);overload;
        function getStaps:TStringList;
        procedure ClearStaps();
        property EquationDegree:word read FEquationDegree write setEqDegree;
        property EquationName:string read FEquationName write setEqName;
        property EquationFormla:string read FEquationFormla write setFormla;

    end;
//-------------------------------------------------------
    //Equation 1
     TEquation1=class(TEquationAbstarct)
     private
      Fa,Fb:TZNumber;
     public
       constructor create(a,b:TZNumber);
       function getRoots: TrootsEquation; override;
     end;

     ///Equation2
    TEquation2=class(TEquationAbstarct)
     private
      Fa,Fb,Fc:TZNumber;
     public
       constructor create(a,b,c:TZNumber);
       function getRoots: TrootsEquation; override;
     end;
     ///Equation3
     TEquation3=class(TEquationAbstarct)
     private
      Fa,Fb,Fc,Fd:TZNumber;
     public
       constructor create(a,b,c,d:TZNumber);
       function getDelta_0():TZNumber;
       function getDelta_1():TZNumber;
       function getDelta():TZNumber;
       function getC():TZNumber;
       function getAllRoots():TrootsEquation;

       function getRoots: TrootsEquation; override;
     end;


implementation

{ TEquationAbstarct }

procedure TEquationAbstarct.AddStap(const str: string);
begin
  FEquaionStaps.Add(str);
end;

procedure TEquationAbstarct.ClearStaps;
begin
if Assigned(FEquaionStaps) then
  FEquaionStaps.Clear;
end;

constructor TEquationAbstarct.create;
begin
  FEquaionStaps:=TStringList.Create;
end;

destructor TEquationAbstarct.Destroy;
begin
  if Assigned(FEquaionStaps) then
    begin
      FreeAndNil(FEquaionStaps);
    end;
  inherited;
end;

procedure TEquationAbstarct.Display;
var
  root:TrootsEquation;
  count:integer;
begin
  root:=getRoots;
     for count := Low(root) to High(root) do
        begin
          writeln('root[',count,'] --> ',root[count].ToString);
        end;
end;

function TEquationAbstarct.getStaps: TStringList;

begin
  ClearStaps;
  getRoots();
  result:=TStringList.Create;
  if Assigned(FEquaionStaps) then
    result.AddStrings(FEquaionStaps);
end;

procedure TEquationAbstarct.setEqDegree(const Value: word);
begin
  FEquationDegree := Value;
end;

procedure TEquationAbstarct.setEqName(const Value: string);
begin
  FEquationName := Value;
end;

procedure TEquationAbstarct.setFormla(const Value: string);
begin
  FEquationFormla := Value;
end;

procedure TEquationAbstarct.AddStap(strLits: TStrings);
begin
  FEquaionStaps.AddStrings(strLits);
end;

function TEquationAbstarct.ToString: string;
begin
  result:=(FEquationName);
end;

{ TEquation1 }

constructor TEquation1.create(a, b: TZNumber);
begin
  inherited create;
  EquationFormla:=' aX + b = 0 ';
  EquationDegree:=1;
  EquationName:='Equation Degree 1';

  Fa:=a;
  Fb:=b;
end;

function TEquation1.getRoots: TrootsEquation;
begin
AddStap(EquationFormla);
AddStap('----------------------');
AddStap('');
AddStap('a = '+Fa.ToString);
AddStap('b = '+fb.ToString);
AddStap('');
AddStap('----------------------');
AddStap('-----------Solve------------');
AddStap('X = -b/a ');
AddStap('');


   if (fa=0) then
   begin
     AddStap('<error>');
     AddStap('a = '+Fa.ToString);
     AddStap(ZeroComplixNumber);
     raise TComplixNumberZeroExcepion.Create(ZeroComplixNumber);
   end;
  SetLength(result,1);
  result[0]:=(-fb)/(fa);
  AddStap('X = '+result[0].ToString);
end;

{ TEquation2 }

constructor TEquation2.create(a, b, c: TZNumber);
begin
inherited create;
EquationFormla:=' aX² + bX + c = 0 ';
EquationDegree:=2;
EquationName:='Equation Degree 2';
Fa:=a;
fb:=b;
fc:=c;
end;

function TEquation2.getRoots: TrootsEquation;
var
  eq1:TEquation1;
  delta:TZNumber;
  delta_root:TZNumber;
begin
ClearStaps;
AddStap(EquationFormla);
AddStap('----------------------');
AddStap('');
AddStap('a = '+Fa.ToString);
AddStap('b = '+fb.ToString);
AddStap('c = '+fc.ToString);
AddStap('');
AddStap('----------------------');

   if(fa=0) then
    begin
      AddStap('a = '+Fa.ToString);
      AddStap('a is Zero then the Equation is :');
      AddStap('----------------------');
      eq1:=TEquation1.create(fb,fc);
     try
      result:=eq1.getRoots;
      AddStap(eq1.getStaps);
     finally
      FreeAndNil(eq1);
     end;

    end
   else
   begin
     AddStap('-----------Solve------------');
     AddStap('');
     AddStap(' delta = b² -4*a*c ');
     delta:=(fb*fb)-4*(fa*fc); //delta=b²-4*a*c
     AddStap(' delta = '+delta.ToString);
     AddStap('');
     delta_root:=delta.getRoots(2)[0];//get first root
     AddStap('root_delta = sqrt(Delta) ');
     AddStap('root_delta = '+delta_root.ToString);
     AddStap('');
     SetLength(result,2);
     AddStap('X1 = (-b +root_delta)/ (2*a)');
     result[0]:=((-fb+delta_root))/(2*fa);//x1=(-b+sqrt(delta))/2a
     AddStap('X1 = '+result[0].ToString);
     AddStap('');
     AddStap('X2 = (-b -root_delta)/ (2*a)');
     result[1]:=((-fb-delta_root))/(2*fa);//x2=(-b-sqrt(delta))/2a
     AddStap('X2 = '+result[1].ToString);
     AddStap('');
   end;
end;

{ TEquation3 }

constructor TEquation3.create(a, b, c, d: TZNumber);
begin
inherited create;
EquationFormla:=' aX^3 + bX² + cX + d = 0 ';
EquationDegree:=3;
EquationName:='Equation Degree 3';
fa:=a;
fb:=b;
fc:=c;
fd:=d;
end;




function TEquation3.getAllRoots: TrootsEquation;
var
  c:TZNumber;
  x:TZNumber;
  k:integer;
  mult:TZNumber;
  d_0,delta:TZNumber;
begin
  AddStap('-----------Solve------------');
  AddStap('');

  SetLength(result,3);

  AddStap(' Delta = 18abcd -(4b^3)(d) +b²c² -4a(c^3) -27a²d²');
  delta:=getDelta;
  AddStap(' Delta = '+delta.ToString);
  AddStap('');
  AddStap(' d_0 = b² -3ac ');
  d_0:=getDelta_0;
  AddStap(' d_0 = '+d_0.ToString);
  AddStap('');
  //AddStap();
  if(d_0=0) and (delta=0) then //triple root equal
    begin
    AddStap(' if d_0 =0 and delta =0 ');
    AddStap(' then the equation has a single root ');
    AddStap('');
    AddStap(' single root = -b/(3a)');
     x:=(-fb/(3*fa));
    AddStap(' single root = '+x.ToString);
    AddStap('');
    AddStap('');
       for k := low(result) to High(result) do
        begin
             AddStap(Format(' X%d = single root',[k]));
             result[k]:=x;
             AddStap(Format(' X%d = %s',[k,x.ToString]));
             AddStap('');
        end;
     exit;
    end
  else
    if (d_0<>0) and (delta=0) then
     begin
     AddStap(' if d_0 !=0 and delta =0 ');
     AddStap(' then there are both a double root :');
     AddStap('');
     AddStap('double root = (9ad)-(bc)/(2*d_0)');
     AddStap('');
     x:=((9*fa*fd)-(fb*fc))/(2*d_0);
     AddStap('double root = '+x.ToString);
     AddStap('');

     AddStap('');
     AddStap(Format(' X%d = double root',[1]));
     result[0]:=x;
     AddStap(Format(' X%d = %s',[1,x.ToString]));
     AddStap('');

     AddStap('');
     AddStap(Format(' X%d = double root',[2]));
     result[1]:=x;
     AddStap(Format(' X%d = %s',[2,x.ToString]));
     AddStap('');
     AddStap(' and and a simple root :');
     AddStap(' simple root =( (4abc)-(9a²d)-b^3 )/(a*d_0) ');
     x:=((4*fa*fb*fc)-(9*fa.PowerTo(2)*fd)-(fb.PowerTo(3)))/(fa*d_0);
     AddStap(' simple root =  '+x.ToString);
     AddStap('');
     AddStap(Format(' X%d = double root',[3]));
     result[2]:=x;
     AddStap(Format(' X%d = %s',[3,x.ToString]));
     AddStap('');

     exit;
     end;

  AddStap('');
  AddStap(' d_1 = (2b^3) -(9abc) +(27a²d) ');
  AddStap(' d_1 = '+getDelta_1.ToString);
  AddStap('');



  AddStap('');
  AddStap(' C = { ( d_1 +sqrt( d_1² -4d_0^3 ) )/2 }^(1/3) ');
  c:=getC();
  AddStap(' C = '+c.ToString);
  AddStap('');

  AddStap('');
  AddStap(' mult = ( -1/2 +i( sqrt(3)/2 ) ');
  mult:=TZNumber.create(-0.5,+0.5*sqrt(3));
  AddStap('');

  AddStap('');
  AddStap(' X_k =(-1/(3a)) *{ b+(mult^k)(C) +(d_0/((mult^k)(C)) ) }');
  AddStap(' k={0,1,2}');
  AddStap('');


  for k := low(result) to High(result) do
  begin
      AddStap('');
      AddStap(Format(' k= %d',[k]));
      AddStap('');
      x:=(-1/(3*fa)) *(Fb +(c*mult.PowerTo(k))+  (d_0/(c*mult.PowerTo(k)))  );
      AddStap(Format(' x_%d= %s',[k+1,x.ToString]));
      result[k]:=x;
  end;
end;

function TEquation3.getC: TZNumber;
var
  alpha:TZNumber;
  d_0,d_1:TZNumber;
  C:TZNumber;
begin
  d_0:=getDelta_0;
  d_1:=getDelta_1;
  alpha:=d_1.PowerTo(2) +(-4*d_0.PowerTo(3));
  alpha:=(d_1+alpha.getRoots(2)[0])/2;//+-
  C:=alpha.getRoots(3)[0];
  result:=C;
end;

function TEquation3.getDelta: TZNumber;
begin
result:=(18*fa*fb*fc*fd) -(4*fb.PowerTo(3)*fd)+(fb.PowerTo(2) *fc.PowerTo(2))-(4*fa*fc.PowerTo(3))-(27* fa.PowerTo(2) *fd.PowerTo(2));
end;

function TEquation3.getDelta_0: TZNumber;
begin
  result:=(Fb.PowerTo(2))-(3*fa*fc);
end;

function TEquation3.getDelta_1: TZNumber;
begin
  result:=(2*Fb.PowerTo(3)) -(9*fa*fb*fc) +(27*Fa.PowerTo(2)*Fd);
end;

function TEquation3.getRoots: TrootsEquation;
var
  Eq2:TEquation2;
begin
AddStap(EquationFormla);
AddStap('----------------------');
AddStap('');
AddStap('a = '+Fa.ToString);
AddStap('b = '+fb.ToString);
AddStap('c = '+fc.ToString);
AddStap('d = '+fd.ToString);
AddStap('');
AddStap('----------------------');

  if(fa=0) then
    begin
        AddStap('a = '+Fa.ToString);
        AddStap('a is Zero then the Equation is :');
        AddStap('----------------------');
        Eq2:=TEquation2.create(fb,fc,fd);
        try
        result:=Eq2.getRoots();
        AddStap(Eq2.getStaps);
        finally
          FreeAndNil(Eq2);
        end;
    end
  else
  begin
    result:=getAllRoots();
  end;

end;




end.
