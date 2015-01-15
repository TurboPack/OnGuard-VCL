program CodeGen;

uses
  QForms,
  CODEGENU in 'CODEGENU.pas' {CodeGenFrm};

{$E exe}

begin
  Application.CreateForm(TCodeGenFrm, CodeGenFrm);
  Application.Run;
end.
