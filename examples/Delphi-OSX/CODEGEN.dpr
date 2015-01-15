program CodeGen;

uses
 FMX.Forms,
  CodeGenU in 'CodeGenU.pas' {CodeGenFrm};

begin
  Application.Initialize;
  Application.CreateForm(TCodeGenFrm, CodeGenFrm);
  Application.Run;
end.
