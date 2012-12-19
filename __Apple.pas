unit __Apple;

interface

uses
    Commons, VCL.forms, VCL.Graphics, Winapi.Windows;

type
    _Apple = class
        private
            Position : Body_Part;
            Form : TForm;
            Created : Integer; //Determina o valor do item, reduz com o tempo
        published
            property Get_Pos : Body_Part read Position;
            constructor Create(X,Y : Integer; WParent : TForm); Overload; //Tamanho da tela em X,Y, posicao random
            procedure Draw;
            function Pegar() : Integer;
    end;

implementation

constructor _Apple.Create(X: Integer; Y: Integer; WParent : TForm);
begin
    Self.Position.X := Random(x) * 10;
    Self.Position.Y := Random(y) * 10;
    Form := WParent;
    Self.Created := GetTickCount();
end;

procedure _Apple.Draw;
begin
    if Self.Pegar>17000 then
        Form.Canvas.Brush.Color := clYellow
    else if Self.Pegar>10000 then
        Form.Canvas.Brush.Color := rgb(255,128,0)
    else
        Form.Canvas.Brush.Color := clRed;
    Form.Canvas.Rectangle( Position.X, Position.Y, Position.X + 10, Position.Y + 10 );
end;

function _Apple.Pegar;
begin
    Result := GetTickCount() - Self.Created;
    if Result > 10000 then
        Result := 10000;
    Result := 20000 - Result;
end;

end.
