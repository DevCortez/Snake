program Snake;

uses
  System.SysUtils,
  __Apple in '__Apple.pas',
  Commons in 'Commons.pas',
  __Snake in '__Snake.pas',
  __Game_Win in '__Game_Win.pas';

var
    GameWindow : Game_Win;

begin
    GameWindow := Game_Win.Createnew(nil);
    GameWindow.Visible := true;
    GameWindow.Execute;
end.
