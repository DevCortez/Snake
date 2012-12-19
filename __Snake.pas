unit __Snake;

interface

uses
    Commons, VCL.Forms, VCL.Graphics;

type
    _Snake = class
        private
            Body : array of Body_Part;
            Direction : Byte; //1 = LEFT; 10 = RIGHT; 100 = TOP; 1000 = BOTTOM
            Speed : Integer;
            Form : TForm;
        published
            constructor Create(const Pos_x, Pos_y, Size, Speed : Integer; WParent : TForm); Overload;
            procedure Set_Direction(const Direction : Byte);
            procedure Increase();
            procedure Walk();
            property Get_Direction : byte read Direction;
            function Get_Size : Integer;
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
        Self.Body[x].x := Pos_x * 10 + x * 10;
        Self.Body[x].y := Pos_y * 10;
    end;
    Form := WParent;
    Self.Direction := LEFT;
end;

procedure _Snake.Set_Direction(const Direction: Byte);
begin
    Self.Direction := Direction;
end;

procedure _Snake.Increase;
begin
    SetLength(Self.Body,length(Self.Body)+1);
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
        RIGHT  : inc(Self.Body[0].X, Speed * 10);
        LEFT   : dec(Self.Body[0].X, Speed * 10);
        TOP    : dec(Self.Body[0].Y, Speed * 10);
        BOTTOM : inc(Self.Body[0].Y, Speed * 10);
    end;
end;


function _Snake.Get_Size;
begin
    result := length(Self.Body);
end;

procedure _Snake.Draw;
var
    x : integer;
begin
    Form.Canvas.Brush.Color := clBlack;
    for x := 0 to Get_Size()-1 do
        Form.Canvas.Rectangle(Self.Body[x].X, Self.Body[x].Y, Self.Body[x].X + 10, Self.Body[x].Y + 10);
end;

end.
