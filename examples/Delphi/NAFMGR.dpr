program NAFMgr;

uses
  Forms,
  OgFirst,
  NAFMgr1 in 'NAFMGR1.PAS' {NafFrm};


begin
  Application.Title := 'Network File Access Manager';
  if IsFirstInstance then begin
    Application.CreateForm(TNafFrm, NafFrm);
    Application.Run;
  end else
    ActivateFirstInstance;
end.
