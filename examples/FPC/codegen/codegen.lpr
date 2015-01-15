program CodeGen;

{$mode objfpc}{$H+}

{.$MODE Delphi}

uses
  Interfaces,
  Forms,
  CODEGENU in 'CODEGENU.pas' {CodeGenFrm}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TCodeGenFrm, CodeGenFrm);
  Application.Run;
end.


