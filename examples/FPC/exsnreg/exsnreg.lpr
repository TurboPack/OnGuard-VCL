program ExSNReg;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  ExSNRegU in 'ExSNRegU.pas' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
