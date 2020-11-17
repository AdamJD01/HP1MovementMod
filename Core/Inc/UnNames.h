/*=============================================================================
	UnNames.h: Header file registering global hardcoded Unreal names.
	Copyright 1997-1999 Epic Games, Inc. All Rights Reserved.

	Revision history:
		* Created by Tim Sweeney
=============================================================================*/

/*-----------------------------------------------------------------------------
	Macros.
-----------------------------------------------------------------------------*/

// Define a message as an enumeration.
#ifndef REGISTER_NAME
	#define REGISTER_NAME(num,name) NAME_##name = num,
	#define REG_NAME_HIGH(num,name) NAME_##name = num,
	#define REGISTERING_ENUM
	enum EName {
#endif

/*-----------------------------------------------------------------------------
	Hardcoded names which are not messages.
-----------------------------------------------------------------------------*/

// Special zero value, meaning no name.
REG_NAME_HIGH(   0, None             )

// Class property types; these map straight onto hardcoded property types.
REGISTER_NAME(   1, ByteProperty     )
REGISTER_NAME(   2, IntProperty      )
REGISTER_NAME(   3, BoolProperty     )
REGISTER_NAME(   4, FloatProperty    )
REGISTER_NAME(   5, ObjectProperty   )
REGISTER_NAME(   6, NameProperty     )
REGISTER_NAME(   7, StringProperty   )
REGISTER_NAME(   8, ClassProperty    )
REGISTER_NAME(   9, ArrayProperty    )
REGISTER_NAME(  10, StructProperty   )
REGISTER_NAME(  11, VectorProperty   )
REGISTER_NAME(  12, RotatorProperty  )
REGISTER_NAME(  13, StrProperty      )
REGISTER_NAME(  14, MapProperty      )
REGISTER_NAME(  15, FixedArrayProperty)

// Packages.
REGISTER_NAME(  16, Core             )
REGISTER_NAME(  17, Engine           )
REGISTER_NAME(  18, Editor           )
REGISTER_NAME(  19, UnrealI          )
REGISTER_NAME(  20, UnrealShare      )

// UnrealScript types.
REG_NAME_HIGH(  21, Byte             )
REG_NAME_HIGH(  22, Int              )
REG_NAME_HIGH(  23, Bool             )
REG_NAME_HIGH(  24, Float            )
REG_NAME_HIGH(  25, Name             )
REG_NAME_HIGH(  26, String           )
REG_NAME_HIGH(  27, Struct           )
REG_NAME_HIGH(  28, Vector           )
REG_NAME_HIGH(  29, Rotator          )
REG_NAME_HIGH(  30, Color            )
REG_NAME_HIGH(  31, Plane            )

// Keywords.
REGISTER_NAME(  32, Begin            )
REG_NAME_HIGH(  33, State            )
REG_NAME_HIGH(  34, Function         )
REG_NAME_HIGH(  35, Self             )
REG_NAME_HIGH(  36, True             )
REG_NAME_HIGH(  37, False            )
REG_NAME_HIGH(  38, Transient        )
REG_NAME_HIGH(  39, Enum             )
REG_NAME_HIGH(  40, Replication      )
REG_NAME_HIGH(  41, Reliable         )
REG_NAME_HIGH(  42, Unreliable       )
REG_NAME_HIGH(  43, Always           )

// Object class names.
REGISTER_NAME(  44, Field            )
REGISTER_NAME(  45, Object           )
REGISTER_NAME(  46, TextBuffer       )
REGISTER_NAME(  47, Linker           )
REGISTER_NAME(  48, LinkerLoad       )
REGISTER_NAME(  49, LinkerSave       )
REGISTER_NAME(  50, Subsystem        )
REGISTER_NAME(  51, Factory          )
REGISTER_NAME(  52, TextBufferFactory)
REGISTER_NAME(  53, Exporter         )
REGISTER_NAME(  54, StackNode        )
REGISTER_NAME(  55, Property         )
REGISTER_NAME(  56, Camera           )

// Constants.
REG_NAME_HIGH(  57, Vect             )
REG_NAME_HIGH(  58, Rot              )
REG_NAME_HIGH(  59, ArrayCount       )
REG_NAME_HIGH(  60, EnumCount        )

// Flow control.
REG_NAME_HIGH(  61, Else             )
REG_NAME_HIGH(  62, If               )
REG_NAME_HIGH(  63, Goto             )
REG_NAME_HIGH(  64, Stop             )
REG_NAME_HIGH(  65, Until            )
REG_NAME_HIGH(  66, While            )
REG_NAME_HIGH(  67, Do               )
REG_NAME_HIGH(  68, Break            )
REG_NAME_HIGH(  69, For              )
REG_NAME_HIGH(  70, ForEach          )
REG_NAME_HIGH(  71, Assert           )
REG_NAME_HIGH(  72, Switch           )
REG_NAME_HIGH(  73, Case             )
REG_NAME_HIGH(  74, Default          )
REG_NAME_HIGH(  75, Continue         )

// Variable overrides.
REG_NAME_HIGH(  76, Private          )
REG_NAME_HIGH(  77, Const            )
REG_NAME_HIGH(  78, Out              )
REG_NAME_HIGH(  79, Export           )
REG_NAME_HIGH(  80, Skip             )
REG_NAME_HIGH(  81, Coerce           )
REG_NAME_HIGH(  82, Optional         )
REG_NAME_HIGH(  83, Input            )
REG_NAME_HIGH(  84, Config           )
REG_NAME_HIGH(  85, Travel           )
REG_NAME_HIGH(  86, EditConst        )
REG_NAME_HIGH(  87, Localized        )
REG_NAME_HIGH(  88, GlobalConfig     )
REG_NAME_HIGH(  89, SafeReplace      )
REG_NAME_HIGH(  90, New              )

// Class overrides.
REG_NAME_HIGH(  91, Expands          )
REG_NAME_HIGH(  92, Intrinsic        )
REG_NAME_HIGH(  93, Within           )
REG_NAME_HIGH(  94, Abstract         )
REG_NAME_HIGH(  95, Package          )
REG_NAME_HIGH(  96, Guid             )
REG_NAME_HIGH(  97, Parent           )
REG_NAME_HIGH(  98, Class            )
REG_NAME_HIGH(  99, Extends          )
REG_NAME_HIGH( 100, NoExport         )
REG_NAME_HIGH( 101, NoUserCreate     )
REG_NAME_HIGH( 102, PerObjectConfig  )
REG_NAME_HIGH( 103, NativeReplication)

// State overrides.
REG_NAME_HIGH( 104, Auto             )
REG_NAME_HIGH( 105, Ignores          )

// Calling overrides.
REG_NAME_HIGH( 106, Global           )
REG_NAME_HIGH( 107, Super            )
REG_NAME_HIGH( 108, Outer            )

// Function overrides.
REG_NAME_HIGH( 109, Operator         )
REG_NAME_HIGH( 110, PreOperator      )
REG_NAME_HIGH( 111, PostOperator     )
REG_NAME_HIGH( 112, Final            )
REG_NAME_HIGH( 113, Iterator         )
REG_NAME_HIGH( 114, Latent           )
REG_NAME_HIGH( 115, Return           )
REG_NAME_HIGH( 116, Singular         )
REG_NAME_HIGH( 117, Simulated        )
REG_NAME_HIGH( 118, Exec             )
REG_NAME_HIGH( 119, Event            )
REG_NAME_HIGH( 120, Static           )
REG_NAME_HIGH( 121, Native           )
REG_NAME_HIGH( 122, Invariant        )

// Variable declaration.
REG_NAME_HIGH( 123, Var              )
REG_NAME_HIGH( 124, Local            )
REG_NAME_HIGH( 125, Import           )
REG_NAME_HIGH( 126, From             )

// Special commands.
REG_NAME_HIGH( 127, Spawn            )
REG_NAME_HIGH( 128, Array            )
REG_NAME_HIGH( 129, Map              )

// Misc.
REGISTER_NAME( 130, Tag              )
REGISTER_NAME( 131, Role             )
REGISTER_NAME( 132, RemoteRole       )
REGISTER_NAME( 133, System           )
REGISTER_NAME( 134, User             )

// Log messages.
REGISTER_NAME( 135, Log              )
REGISTER_NAME( 136, Critical         )
REGISTER_NAME( 137, Init             )
REGISTER_NAME( 138, Exit             )
REGISTER_NAME( 139, Cmd              )
REGISTER_NAME( 140, Play             )
REGISTER_NAME( 141, Console          )
REGISTER_NAME( 142, Warning          )
REGISTER_NAME( 143, ExecWarning      )
REGISTER_NAME( 144, ScriptWarning    )
REGISTER_NAME( 145, ScriptLog        )
REGISTER_NAME( 146, Dev              )
REGISTER_NAME( 147, DevNet           )
REGISTER_NAME( 148, DevPath          )
REGISTER_NAME( 149, DevNetTraffic    )
REGISTER_NAME( 150, DevAudio         )
REGISTER_NAME( 151, DevLoad          )
REGISTER_NAME( 152, DevSave          )
REGISTER_NAME( 153, DevGarbage       )
REGISTER_NAME( 154, DevKill          )
REGISTER_NAME( 155, DevReplace       )
REGISTER_NAME( 156, DevMusic         )
REGISTER_NAME( 157, DevSound         )
REGISTER_NAME( 158, DevCompile       )
REGISTER_NAME( 159, DevBind          )
REGISTER_NAME( 160, Localization     )
REGISTER_NAME( 161, Compatibility    )
REGISTER_NAME( 162, NetComeGo        )
REGISTER_NAME( 163, Title            )
REGISTER_NAME( 164, Error            )
REGISTER_NAME( 165, Heading          )
REGISTER_NAME( 166, SubHeading       )
REGISTER_NAME( 167, FriendlyError    )
REGISTER_NAME( 168, Progress         )
REGISTER_NAME( 169, UserPrompt       )

// Console text colors.
REGISTER_NAME( 170, White            )
REGISTER_NAME( 171, Black            )
REGISTER_NAME( 172, Red              )
REGISTER_NAME( 173, Green            )
REGISTER_NAME( 174, Blue             )
REGISTER_NAME( 175, Cyan             )
REGISTER_NAME( 176, Magenta          )
REGISTER_NAME( 177, Yellow           )
REGISTER_NAME( 178, DefaultColor     )

// Misc.
REGISTER_NAME( 179, KeyType          )
REGISTER_NAME( 180, KeyEvent         )
REGISTER_NAME( 181, Write            )
REGISTER_NAME( 182, Message          )
REGISTER_NAME( 183, InitialState     )
REGISTER_NAME( 184, Texture          )
REGISTER_NAME( 185, Sound            )
REGISTER_NAME( 186, FireTexture      )
REGISTER_NAME( 187, IceTexture       )
REGISTER_NAME( 188, WaterTexture     )
REGISTER_NAME( 189, WaveTexture      )
REGISTER_NAME( 190, WetTexture       )
REGISTER_NAME( 191, Main             )
REGISTER_NAME( 192, NotifyLevelChange)
REGISTER_NAME( 193, VideoChange      )
REGISTER_NAME( 194, SendText         )
REGISTER_NAME( 195, SendBinary       )
REGISTER_NAME( 196, ConnectFailure   )

/*-----------------------------------------------------------------------------
	Special engine-generated probe messages.
-----------------------------------------------------------------------------*/

//
//warning: All probe entries must be filled in, otherwise non-probe names might be mapped
// to probe name indices.
//
#define NAME_PROBEMIN ((EName)197)
#define NAME_PROBEMAX ((EName)261)

// Creation and destruction.
REGISTER_NAME( 197, Spawned          ) // Sent to actor immediately after spawning.
REGISTER_NAME( 198, Destroyed        ) // Called immediately before actor is removed from actor list.

// Gaining/losing actors.
REGISTER_NAME( 199, GainedChild      )
REGISTER_NAME( 200, LostChild        )
REGISTER_NAME( 201, Probe4           )
REGISTER_NAME( 202, Probe5           )

// Triggers.
REGISTER_NAME( 203, Trigger          )
REGISTER_NAME( 204, UnTrigger        )

// Physics & world interaction.
REGISTER_NAME( 205, Timer            )
REGISTER_NAME( 206, HitWall          )
REGISTER_NAME( 207, Falling          )
REGISTER_NAME( 208, Landed           )
REGISTER_NAME( 209, ZoneChange       )
REGISTER_NAME( 210, Touch            )
REGISTER_NAME( 211, UnTouch          )
REGISTER_NAME( 212, Bump             )
REGISTER_NAME( 213, BeginState       )
REGISTER_NAME( 214, EndState         )
REGISTER_NAME( 215, BaseChange       )
REGISTER_NAME( 216, Attach           )
REGISTER_NAME( 217, Detach           )
REGISTER_NAME( 218, ActorEntered     )
REGISTER_NAME( 219, ActorLeaving     )
REGISTER_NAME( 220, KillCredit       )
REGISTER_NAME( 221, AnimEnd          )
REGISTER_NAME( 222, EndedRotation    )
REGISTER_NAME( 223, InterpolateEnd   )
REGISTER_NAME( 224, EncroachingOn    )
REGISTER_NAME( 225, EncroachedBy     )
REGISTER_NAME( 226, FootZoneChange   )
REGISTER_NAME( 227, HeadZoneChange   )
REGISTER_NAME( 228, PainTimer        )
REGISTER_NAME( 229, SpeechTimer      )
REGISTER_NAME( 230, MayFall          )
REGISTER_NAME( 231, Probe34          )

// Kills.
REGISTER_NAME( 232, Die              )

// Updates.
REGISTER_NAME( 233, Tick             )
REGISTER_NAME( 234, PlayerTick       )
REGISTER_NAME( 235, Expired          )
REGISTER_NAME( 236, Probe39          )

// AI.
REGISTER_NAME( 237, SeePlayer        )
REGISTER_NAME( 238, EnemyNotVisible  )
REGISTER_NAME( 239, HearNoise        )
REGISTER_NAME( 240, UpdateEyeHeight  )
REGISTER_NAME( 241, SeeMonster       )
REGISTER_NAME( 242, SeeFriend        )
REGISTER_NAME( 243, SpecialHandling  )
REGISTER_NAME( 244, BotDesireability )
REGISTER_NAME( 245, Probe48          )
REGISTER_NAME( 246, Probe49          )
REGISTER_NAME( 247, Probe50          )
REGISTER_NAME( 248, Probe51          )
REGISTER_NAME( 249, Probe52          )
REGISTER_NAME( 250, Probe53          )
REGISTER_NAME( 251, Probe54          )
REGISTER_NAME( 252, Probe55          )
REGISTER_NAME( 253, Probe56          )
REGISTER_NAME( 254, Probe57          )
REGISTER_NAME( 255, Probe58          )
REGISTER_NAME( 256, Probe59          )
REGISTER_NAME( 257, Probe60          )
REGISTER_NAME( 258, Probe61          )
REGISTER_NAME( 259, Probe62          )

// Special tag meaning 'All probes'.
REGISTER_NAME( 260, All              ) // Special meaning, not a message.

REGISTER_NAME( 279, Advanced         )
REGISTER_NAME( 280, Colors           )
REGISTER_NAME( 281, Grid             )
REGISTER_NAME( 282, RotationGrid     )
REGISTER_NAME( 283, Settings         )
REGISTER_NAME( 284, Aliases          )
REGISTER_NAME( 285, RawKeys          )
REGISTER_NAME( 286, Drivers          )
REGISTER_NAME( 287, Client           )
REGISTER_NAME( 288, Quirks           )
REGISTER_NAME( 289, Display          )
REGISTER_NAME( 290, Joystick         )

/*-----------------------------------------------------------------------------
	Closing.
-----------------------------------------------------------------------------*/

#ifdef REGISTERING_ENUM
	};
	#undef REGISTER_NAME
	#undef REG_NAME_HIGH
	#undef REGISTERING_ENUM
#endif

/*-----------------------------------------------------------------------------
	The End.
-----------------------------------------------------------------------------*/
