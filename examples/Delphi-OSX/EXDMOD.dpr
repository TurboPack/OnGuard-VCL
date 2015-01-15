program Exdmod;

uses
 FMX.Forms,
  Exdmodu1 in 'EXDMODU1.PAS' {Form1},
  Exdmodu2 in 'EXDMODU2.PAS' {SNEntryDlg};

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
