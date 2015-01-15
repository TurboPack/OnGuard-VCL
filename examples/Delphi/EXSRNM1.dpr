program Exsrnm1;

uses
  Forms,
  Exsrnmu1 in 'EXSRNMU1.PAS' {Form1},
  Exsrnmu2 in 'EXSRNMU2.PAS' {SNEntryDlg};


begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
