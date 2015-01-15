program CodeGen;

uses
  Forms,
  CodeGenU in 'CodeGenU.pas' {CodeGenFrm};

begin
  Application.CreateForm(TCodeGenFrm, CodeGenFrm);
  Application.Run;
end.
