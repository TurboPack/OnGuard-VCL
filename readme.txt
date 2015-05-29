TurboPack OnGuard


Table of contents

1.  Introduction
2.  Package names
3.  Installation

==============================================


1. Introduction


OnGuard is a library to create demo versions of your Embarcadero Delphi and
C++Builder applications. Create demo versions that are time-limited,
feature-limited, limited to a certain number of uses, or limited to a
certain number of concurrent network users.

This is a source-only release of TurboPack OnGuard. It includes
designtime and runtime packages for Delphi and C++Builder.
It supports Win32 and Win64.

==============================================

2. Package names

TurboPack OnGuard package names have the following form:
OnGuardDR.bpl (Delphi, VCL, Runtime)
OnGuardDD.bpl (Delphi, VCL, Designtime)

OnGuardCR.bpl (CBuilder, VCL, Runtime)
OnGuardCD.bpl (CBuilder, VCL, Designtime)

==============================================

3. Installation


To install TurboPack OnGuard into your IDE, take the following steps:

  1. Checkout the latest version.

  2. Start RAD Studio.

  3. Add the source subdirectory (e.g. c:\onguard\source) to the
     IDE's library path.
     
  4. For C++Builder add the hpp subdirectory 
     (e.g. c:\onguard\source\hpp\$(platform)\$(configuration))  

  4. Open and install the designtime package specific to the IDE being
     used. The IDE should notify you the components have been
     installed.
 
==============================================
     
4. Issue with C++Builder under Win64

If you compile with C++Builder under Win64 and receive an error like:

[ilink64 Error] Error: Unresolved external 'vtable for...

you should add the following lines to your cpp file:

#ifdef _WIN64
#pragma comment(lib, "%packagename%")
#endif      