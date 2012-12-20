unit __Snake;

interface

uses
    Commons, VCL.Forms, VCL.Graphics, winapi.windows;

type
    _Snake = class
        private
            Body : array of Body_Part;
            Direction : Byte; //1 = LEFT; 10 = RIGHT; 100 = TOP; 1000 = BOTTOM
            Speed : Integer;
            Form : TForm;
            rv,gv,bv : integer;
            r,g,b : Boolean;
        published
            constructor Create(const Pos_x, Pos_y, Size, Speed : Integer; WParent : TForm); Overload;
            procedure Set_Direction(const Direction : Byte);
            procedure Increase();
            procedure Walk();
            property Get_Direction : byte read Direction;
            function Get_Size : Integer;
            function Get_Position : Body_Part;
            function Get_Dead     : Boolean;
            procedure Draw;
    end;

implementation

constructor _Snake.Create(const Pos_x, Pos_y, Size, Speed : Integer; WParent : TForm);
var
    x : integer;
begin
    SetLength(Self.Body,Size);
    Self.Speed := Speed;
    for x := 0 to Size-1 do
    begin
        Self.Body[x].x := Pos_x * Commons.Scale + x * Commons.Scale;
        Self.Body[x].y := Pos_y * Commons.Scale;
    end;
    Form := WParent;
    Self.Direction := LEFT;
    rv := 0;
    gv := 0;
    bv := 0;
    r := false;
    g := false;
    b := false;
end;

procedure _Snake.Set_Direction(const Direction: Byte);
begin
    Self.Direction := Direction;
end;

procedure _Snake.Increase;
begin
    SetLength(Self.Body,length(Self.Body)+1);
    Self.Body[Length(Self.Body)-1].X := Self.Body[Length(Self.Body)-2].X;
    Self.Body[Length(Self.Body)-1].Y := Self.Body[Length(Self.Body)-2].Y;
end;

procedure _Snake.Walk;
var
    x : integer;
begin
    for x := length(Self.Body)-1 downto 1 do
    begin
        Self.Body[x].x := Self.Body[x-1].x;
        Self.Body[x].y := Self.Body[x-1].y;
    end;

    case Self.Direction of
        RIGHT  : inc(Self.Body[0].X, Speed * Commons.Scale);
        LEFT   : dec(Self.Body[0].X, Speed * Commons.Scale);
        TOP    : dec(Self.Body[0].Y, Speed * Commons.Scale);
        BOTTOM : inc(Self.Body[0].Y, Speed * Commons.Scale);
    end;
end;


function _Snake.Get_Size;
begin
    result := length(Self.Body);
end;

function _Snake.Get_Position;
begin
    result := Self.Body[0];
end;

function _Snake.Get_Dead;
var
    x : integer;
begin
    for x := 1 to Self.Get_Size-1 do
        if ((Self.Get_Position.X = Self.Body[x].X) and (Self.Get_Position.Y = Self.Body[x].Y)) then
            begin
                result := true;
                exit;
            end;
    result := false;
end;

procedure _Snake.Draw;
var
    x : integer;
begin
    //Muda as cores da cobrinha
    if r then
        dec(rv,random(4))
    else
        inc(rv,random(4));
    if g then
        dec(gv,random(4))
    else
        inc(gv,random(4));
    if b then
        dec(bv,random(4))
    else
        inc(bv,random(4));

    if rv >= 255 then
    begin
        r := true;
        rv:= 255;
    end;
    if gv >= 255 then
    begin
        g := true;
        gv:= 255;
    end;
    if bv >= 255 then
    begin
        b := true;
        bv:= 255;
    end;

    if rv<=0 then
    begin
        r := false;
        rv:= 0;
    end;
    if gv<=0 then
    begin
        g := false;
        gv:= 0;
    end;
    if bv<=0 then
    begin
        b := false;
        bv:= 0;
    end;

    //Desenha a cobra de fato
    Form.Canvas.Brush.Color := rgb(rv, gv, bv);
    for x := 0 to Get_Size()-1 do
        Form.Canvas.Rectangle(Self.Body[x].X, Self.Body[x].Y, Self.Body[x].X + Commons.Scale, Self.Body[x].Y + Commons.Scale);
end;

end.
