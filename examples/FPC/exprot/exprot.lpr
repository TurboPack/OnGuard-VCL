program ExProt;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  EXPROTU in 'EXPROTU.pas' {Form1}, tponguard;




begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
