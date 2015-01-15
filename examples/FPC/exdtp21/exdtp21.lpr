program Exdtp21;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Exdtp21u in 'exdtp21u.pas' {Form1}, tponguard;

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
