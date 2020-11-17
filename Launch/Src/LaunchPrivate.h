/*=============================================================================
	LaunchPrivate.h: Unreal launcher.
	Copyright 1997-1999 Epic Games, Inc. All Rights Reserved.

Revision history:
	* Created by Tim Sweeney.
=============================================================================*/

#pragma warning( disable : 4201 )
#define STRICT
#include <windows.h>
#include <commctrl.h>
#include <shlobj.h>
#include <malloc.h>
#include <io.h>
#include <direct.h>
#include <errno.h>
#include <stdio.h>
#include <sys/stat.h>
#include "Engine.h"
#include "UnRender.h"
#include "Window.h"
#include "Res\LaunchRes.h"

// Instant Configuration properties.
class WInstantConfigProperties : public WConfigProperties
{
	W_DECLARE_CLASS(WInstantConfigProperties,WConfigProperties,CLASS_Transient);
	//DECLARE_WINDOWCLASS(WInstantConfigProperties,WConfigProperties,Window)

	// Structors.
	WInstantConfigProperties()
	{}
	WInstantConfigProperties( FName InPersistentName, const TCHAR* InTitle )
	: WConfigProperties( InPersistentName, InTitle )
	{}

	// WWindow interface.
	void OnClose()
	{
		guard(WInstantConfigProperties::OnClose);
		WConfigProperties::OnClose();

		// Request exit on close.
		GIsRequestingExit = 1;
		unguard;
	}
};

/*-----------------------------------------------------------------------------
	The End.
-----------------------------------------------------------------------------*/
