unit __Game_Win;

interface

uses
    Commons, __Snake, __Apple, VCL.Forms, VCL.Graphics, WinApi.Windows, VCL.Controls, system.Classes;

type
    Game_Win = class(TForm)
        private
            Player : _Snake;
            Apple  : _Apple;
            Score  : Integer;
            Done   : Boolean;
            procedure Processar;
            procedure Teclas;
        published
            procedure Execute;
    end;

implementation

procedure Game_Win.Execute;
var
    Msg : TagMsg;
begin
    //Inicializar a janela do jogo
    Self.Width  := 800;
    Self.Height := 600;
    Self.BorderStyle := bsNone;
    Self.Color  := clGreen;
    Self.Left   := 0;
    Self.Top    := 0;
    Self.Cursor := crNone;

    //Inicializa a variavel de finalizacao do jogo
    Done        := False;

    //Cria os objetos do jogo
    Player := _Snake.Create(40,1,4,1,Self);
    Apple  := _Apple.Create(80,60,Self);

    while(not done) do
    begin
        Sleep( trunc(1000/20) ); //FPS
        //Processa mensagens
        Self.Repaint;
        PeekMessage(Msg,Self.Handle,0,0,PM_REMOVE);
        Self.Dispatch(Msg);
        if not Self.Active then
            Continue;
        //Fazer o jogo
        Self.Teclas;
        Player.Walk;
        Self.Processar;
        //Desenhar a cena
        Apple.Draw;
        Player.Draw;
    end;
end;

procedure Game_Win.Processar;
begin

end;

procedure Game_Win.Teclas;
begin
    if ((GetAsyncKeyState(VK_LEFT)<>0) and (Player.Get_Direction<>Commons.RIGHT)) then
        Player.Set_Direction(Commons.LEFT);
    if ((GetAsyncKeyState(VK_RIGHT)<>0) and (Player.Get_Direction<>Commons.LEFT)) then
        Player.Set_Direction(Commons.RIGHT);
    if ((GetAsyncKeyState(VK_UP)<>0) and (Player.Get_Direction<>Commons.BOTTOM)) then
        Player.Set_Direction(Commons.TOP);
    if ((GetAsyncKeyState(VK_DOWN)<>0) and (Player.Get_Direction<>Commons.TOP)) then
        Player.Set_Direction(Commons.BOTTOM);

    if GetAsyncKeyState(VK_ESCAPE)<>0 then
        Self.done := true;
end;

end.
