unit __Apple;

interface

uses
    Commons, VCL.forms, VCL.Graphics;

type
    _Apple = class
        private
            Position : Body_Part;
            Form : TForm;
        published
            property Get_Pos : Body_Part read Position;
            constructor Create(X,Y : Integer; WParent : TForm); Overload; //Tamanho da tela em X,Y, posicao random
            procedure Draw;
    end;

implementation

constructor _Apple.Create(X: Integer; Y: Integer; WParent : TForm);
begin
    Self.Position.X := Random(x) * 10;
    Self.Position.Y := Random(y) * 10;
    Form := WParent;
end;

procedure _Apple.Draw;
begin
    Form.Canvas.Brush.Color := clRed;
    Form.Canvas.Rectangle( Position.X, Position.Y, Position.X + 10, Position.Y + 10 );
end;

end.
