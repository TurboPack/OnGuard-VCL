program ExRgReg;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  exrgregu in 'exrgregu.pas' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
