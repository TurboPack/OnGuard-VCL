program Exsrnm1;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Exsrnmu1 in 'EXSRNMU1.PAS' {Form1},
  Exsrnmu2 in 'EXSRNMU2.PAS' {SNEntryDlg}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
