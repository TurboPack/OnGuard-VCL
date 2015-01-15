program ExDTReg;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  exdtregu in 'exdtregu.pas' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
