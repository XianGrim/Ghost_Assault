playSound "piano_end";
_camera = "camera" camCreate getPos player;
_camera cameraEffect ["internal","back"];
_camera camSetFOV 1.5;
_camera camSetTarget player;
_camera camSetRelPos [0,0,100];
_camera camCommit 2.5;
end_plane enableSimulation true;
waitUntil {camCommitted _camera;};
_camera camSetTarget end_cam_target;
_camera camCommit 5;
waitUntil {camCommitted _camera;};
bomb="Bo_GBU12_lgb" createVehicle (getPos gbu);
sleep 1;
bomb1="Bo_GBU12_lgb" createVehicle (getPos gbu_1);
sleep 1;
bomb2="Bo_GBU12_lgb" createVehicle (getPos gbu_2);
sleep 1;
bomb3="Bo_GBU12_lgb" createVehicle (getPos gbu_3);
sleep 1;
bomb4="Bo_GBU12_lgb" createVehicle (getPos gbu_4);
sleep 0.20;
end_ied setdamage 1;
sleep 0.20;
end_ied_1 setdamage 1;
sleep 0.20;
end_ied_2 setdamage 1;
{ _x setdamage 1;} foreach ( nearestobjects [getpos end_logic, [], 50 ] );
sleep 0.20;
end_ied_3 setdamage 1;
sleep 0.20;
end_ied_4 setdamage 1;
titleText ["To Be Continued.....", "BLACK OUT", 5];
sleep 0.20;
end_ied_5 setdamage 1;
sleep 0.60;
end_ied_6 setdamage 1;
sleep 7;
endMission "END1";


_camera camSetTarget end_cam_target;
_camera camCommit 5;
waitUntil {camCommitted _camera;};
titleText ["To Be Continued.....", "BLACK OUT", 10];
sleep 8;
endMission "END1";



