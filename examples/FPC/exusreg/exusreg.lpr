program ExUSReg;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  ExUSRegU in 'ExUSRegU.pas' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
