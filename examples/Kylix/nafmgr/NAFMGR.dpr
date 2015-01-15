program NAFMgr;

uses
  QForms,
  //ogfirst,
  NAFMGR1 in 'NAFMGR1.pas' {NafFrm};


{$E exe}

begin
  Application.Title := 'Network File Access Manager';
  //if IsFirstInstance then begin
    Application.CreateForm(TNafFrm, NafFrm);
    Application.Run;
  //end else
  //  ActivateFirstInstance;
end.
