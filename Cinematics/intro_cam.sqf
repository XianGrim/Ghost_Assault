showCinemaBorder true;
enableEnvironment [false,false];
/*
_this spawn {
	params[
		["_missionName", "Enemy Assault - Version Tanoa"],
		["_missionAuthor", "Intro Music 'Monolith' by Tri-Tachyon"],
		["_missionVersion", "SoundCloud.com\Tri-Tachyon"],
		["_quote", "If you fall, I'll be there...\n\n-The Floor"],
		["_duration", 10]
	];

	titleFadeOut _duration;

	// New "sitrep style" text in bottom right corner, typed out over time.
	[ 
		[_missionName,"font = 'PuristaSemiBold'"],
		["","<br/>"],
		[_missionAuthor,"font = 'PuristaMedium'"],
		["","<br/>"],
		[_missionVersion,"font = 'PuristaLight'"]
	]  execVM "\a3\missions_f_bootcamp\Campaign\Functions\GUI\fn_SITREP.sqf";
};
*/
_camera = "camera" camCreate (getPos cam1);
_camera cameraEffect ["internal","back"];
_camera camSetRelPos [0,0,150];
_camera camCommit 3;
waitUntil {camCommitted _camera;};
playSound "metal_intro";
_camera camSetPos (getPos cave_cam);
_camera camSetTarget cave_cam_target;
_camera camCommit 16;
waitUntil {camCommitted _camera;};
_camera camSetPos (getPos cave_cam_1);
_camera camCommit 5;
waitUntil {camCommitted _camera;};
_camera camSetRelPos [0,0,100];
_camera camCommit 10;
waitUntil {camCommitted _camera;};
_camera camSetTarget player;
_camera camSetRelPos [0,0,100];
_camera camCommit 13;
waitUntil {camCommitted _camera;};
_camera camSetRelPos [0,0,1.75];
_camera camCommit 4;
waitUntil {camCommitted _camera;};
titleCut ["", "BLACK IN", 5];
_camera cameraEffect ["terminate","back"];
camDestroy _camera;

enableEnvironment [true,true];