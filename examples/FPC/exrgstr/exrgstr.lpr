program Exrgstr;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Exrgstru in 'EXRGSTRU.PAS' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
