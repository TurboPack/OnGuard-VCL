program keymaint;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  ,fpg_main
  ,frm_keymaint
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
  frm: TKeyMaintForm;
begin
  fpgApplication.Initialize;

  {$IFDEF GDEBUG}
  gLog.SevToLog :=  [
                    lsNormal
                    ,lsUserInfo
                    ,lsDebug
                    ,lsWarning
                    ,lsError
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


  frm := TKeyMaintForm.Create(nil);
  try
    fpgApplication.MainForm := frm;  { because log to gui window opened first }
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end;

begin
  MainProc;
end.


