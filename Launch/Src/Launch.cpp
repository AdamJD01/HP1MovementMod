/*=============================================================================
	Launch.cpp: Game launcher.
	Copyright 1997-1999 Epic Games, Inc. All Rights Reserved.

Revision history:
	* Created by Tim Sweeney.
=============================================================================*/

#include "LaunchPrivate.h"
#include "UnEngineWin.h"

/*-----------------------------------------------------------------------------
	Global variables.
-----------------------------------------------------------------------------*/

// General.
extern "C" {HINSTANCE hInstance;}
extern "C" {TCHAR GPackage[64]=TEXT("Launch");}

// Memory allocator.
#ifdef _DEBUG
#include "FMallocDebug.h"
FMallocDebug Malloc;
#else
#include "FMallocWindows.h"
FMallocWindows Malloc;
#endif

// Log file.
#include "FOutputDeviceFile.h"
FOutputDeviceFile Log;

// Error handler.
#include "FOutputDeviceWindowsError.h"
FOutputDeviceWindowsError Error;

// Feedback.
#include "FFeedbackContextWindows.h"
FFeedbackContextWindows Warn;

// File manager.
#include "FFileManagerWindows.h"
FFileManagerWindows FileManager;

// Config.
#include "FConfigCacheIni.h"

/*-----------------------------------------------------------------------------
	WinMain.
-----------------------------------------------------------------------------*/

//
// Main entry point.
// This is an example of how to initialize and launch the engine.
//
INT WINAPI WinMain( HINSTANCE hInInstance, HINSTANCE hPrevInstance, char*, INT nCmdShow )
{
	// Remember instance.
	INT ErrorLevel = 0;
	GIsStarted     = 1;
	hInstance      = hInInstance;
	const TCHAR* CmdLine = GetCommandLine();
	appStrcpy( GPackage, appPackage() );

	// See if this should be passed to another instances.
	if( !appStrfind(CmdLine,TEXT("Server")) && !appStrfind(CmdLine,TEXT("NewWindow")) && !appStrfind(CmdLine,TEXT("changevideo")) && !appStrfind(CmdLine,TEXT("TestRenDev")) && !appStrfind(CmdLine,TEXT("Preferences")) )
	{
		TCHAR ClassName[256];
		MakeWindowClassName(ClassName,TEXT("WLog"));
		for( HWND hWnd=NULL; ; )
		{
			hWnd = TCHAR_CALL_OS(FindWindowExW(hWnd,NULL,ClassName,NULL),FindWindowExA(hWnd,NULL,TCHAR_TO_ANSI(ClassName),NULL));
			if( !hWnd )
				break;
			if( GetPropX(hWnd,TEXT("IsBrowser")) )
			{
				while( *CmdLine && *CmdLine!=' ' )
					CmdLine++;
				if( *CmdLine==' ' )
					CmdLine++;
				COPYDATASTRUCT CD;
				DWORD Result;
				CD.dwData = WindowMessageOpen;
				CD.cbData = (appStrlen(CmdLine)+1)*sizeof(TCHAR*);
				CD.lpData = const_cast<TCHAR*>( CmdLine );
				SendMessageTimeout( hWnd, WM_COPYDATA, (WPARAM)NULL, (LPARAM)&CD, SMTO_ABORTIFHUNG|SMTO_BLOCK, 30000, &Result );
				GIsStarted = 0;
				return 0;
			}
		}
	}

	// Begin guarded code.
#ifndef _DEBUG
	try
	{
#endif
		// Init core.
		GIsClient = GIsGuarded = 1;
		appInit( GPackage, CmdLine, &Malloc, &Log, &Error, &Warn, &FileManager, FConfigCacheIni::Factory, 1 );
		if( ParseParam(appCmdLine(),TEXT("MAKE")) )//oldver
			appErrorf( TEXT("'Unreal -make' is obsolete, use 'ucc make' now") );

		// Init mode.
		GIsServer     = 1;
		GIsClient     = !ParseParam(appCmdLine(),TEXT("SERVER"));
		GIsEditor     = 0;
		GIsScriptable = 1;
		GLazyLoad     = !GIsClient || ParseParam(appCmdLine(),TEXT("LAZY"));

		// Figure out whether to show log or splash screen.
		UBOOL ShowLog = ParseParam(CmdLine,TEXT("LOG"));
		INT RunCount = appAtoi(GConfig->GetStr(TEXT("Engine.Engine"),TEXT("RunCount")));
		FString Filename = FString::Printf(TEXT("..\\Help\\Splash%i.bmp"),RunCount%5);
		GConfig->SetString(TEXT("Engine.Engine"),TEXT("RunCount"),*FString::Printf(TEXT("%i"),RunCount+1));
		if( GFileManager->FileSize(*Filename)<0 )
			Filename = FString(TEXT("..\\Help")) * TEXT("Logo.bmp");
		if( GFileManager->FileSize(*Filename)<0 )
			Filename = TEXT("..\\Help\\Logo.bmp");
		appStrcpy( GPackage, appPackage() );
		if( !ShowLog && !ParseParam(CmdLine,TEXT("server")) && !ParseParam(appCmdLine(),TEXT("Preferences")) && !appStrfind(CmdLine,TEXT("TestRenDev")) )
			InitSplash( *Filename );

		// Init windowing.
		InitWindowing();

		// Create log window, but only show it if ShowLog.
		GLogWindow = new WLog( Log.Filename, Log.LogAr, TEXT("GameLog") );
		GLogWindow->OpenWindow( ShowLog, 0 );
		GLogWindow->Log( NAME_Title, LocalizeGeneral("Start") );
		if( GIsClient )
			SetPropX( *GLogWindow, TEXT("IsBrowser"), (HANDLE)1 );

		// Special preferences switch to just open the preferences window.
		if ( ParseParam(appCmdLine(),TEXT("Preferences")) )
		{
			WInstantConfigProperties* Preferences = new WInstantConfigProperties( TEXT("Preferences"), LocalizeGeneral("AdvancedOptionsTitle",TEXT("Window")) );
			Preferences->SetNotifyHook( NULL );
			Preferences->OpenWindow( GLogWindow ? GLogWindow->hWnd : NULL );
			Preferences->ForceRefresh();
			Preferences->Show(1);
			SetFocus( *Preferences );

			FTime OldTime = appSeconds();
			FTime SecondStartTime = OldTime;

			check(!GIsRequestingExit);
			while ( !GIsRequestingExit )
			{
				// Update.
				FTime NewTime   = appSeconds();
				FLOAT DeltaTime = NewTime - OldTime;
				if( GWindowManager )
					GWindowManager->Tick( DeltaTime );
				appSleep( 0.005f );

				// Handle all incoming messages.
				guard(MessagePump);
				MSG Msg;
				while( PeekMessageX(&Msg,NULL,0,0,PM_REMOVE) )
				{
					if( Msg.message == WM_QUIT )
						GIsRequestingExit = 1;

					guard(TranslateMessage);
					TranslateMessage( &Msg );
					unguardf(( TEXT("%08X %i"), (INT)Msg.hwnd, Msg.message ));

					guard(DispatchMessage);
					DispatchMessageX( &Msg );
					unguardf(( TEXT("%08X %i"), (INT)Msg.hwnd, Msg.message ));
				}
				unguard;
			}
		}
		// Normal startup.
		else
		{
			// Init engine.
			UEngine* Engine = InitEngine();

			if ( Engine )
			{
				GLogWindow->Log( NAME_Title, LocalizeGeneral("Run") );

				// Hide splash screen.
				ExitSplash();

				// Optionally Exec an exec file
				FString Temp;
				if( Parse(CmdLine, TEXT("EXEC="), Temp) )
				{
					Temp = FString(TEXT("exec ")) + Temp;
					if( Engine->Client && Engine->Client->Viewports.Num() && Engine->Client->Viewports(0) )
						Engine->Client->Viewports(0)->Exec( *Temp, *GLogWindow );
				}

				// Start main engine loop, including the Windows message pump.
				if( !GIsRequestingExit )
					MainLoop( Engine );
			}
		}

		// Delete is-running semaphore file.
		GFileManager->Delete(TEXT("Running.ini"),0,0);

		// Clean shutdown.
		RemovePropX( *GLogWindow, TEXT("IsBrowser") );
		GLogWindow->Log( NAME_Title, LocalizeGeneral("Exit") );
		delete GLogWindow;
		appPreExit();
		GIsGuarded = 0;
#ifndef _DEBUG
	}
	catch( ... )
	{
		// Crashed.
		ErrorLevel = 1;
		Error.HandleError();
	}
#endif

	// Final shut down.
	appExit();
	GIsStarted = 0;
	return ErrorLevel;
}

/*-----------------------------------------------------------------------------
	The End.
-----------------------------------------------------------------------------*/