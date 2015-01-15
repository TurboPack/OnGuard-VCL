program codegen;

{$mode objfpc}{$H+}
{$ifdef mswindows}{$apptype gui}{$endif}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  ,fpg_main
  ,frm_codegen
  {$IFDEF GDEBUG}
  ,tiConstants
  ,tiCommandLineParams
  ,tiLog
  ,tiLogToGUI
  ,tiLogToConsole
  ,tiLogToDebugSvr
  ,tiLogToFile
  {$ENDIF}
  ;


procedure MainProc;
var
  frm: TCodeGenerationForm;
begin
  fpgApplication.Initialize;

  {$IFDEF GDEBUG}
  gLog.SevToLog :=  [
                    lsNormal
                    ,lsDebug
                    ,lsWarning
                    ,lsError
                    ,lsSQL
              ];

  // Logging
  if gCommandLineParams.IsParam(csLogConsole) then
    gLog.RegisterLog(TtiLogToConsole);
  if gCommandLineParams.IsParam(csLog) then
    gLog.RegisterLog(TtiLogToFile.CreateWithFileName('.','project1.log', True));
  if gCommandLineParams.IsParam(csLogVisual) then
    gLog.RegisterLog(TtiLogToGUI);
  if gCommandLineParams.IsParam(csLogDebugSvr) then
    gLog.RegisterLog(TtiLogToDebugSvr);
  {$ENDIF}


  frm := TCodeGenerationForm.Create(nil);
  try
    fpgApplication.MainForm := frm; { only because log to gui is shown first }
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end;

begin
  MainProc;
end.


