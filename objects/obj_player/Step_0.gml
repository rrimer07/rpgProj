// Input check
input_left = keyboard_check(ord("A"));
input_right = keyboard_check(ord("D"));
input_up = keyboard_check(ord("W"));
input_down = keyboard_check(ord("S"));
input_walk = keyboard_check(vk_control);
input_run = keyboard_check(vk_shift);

// Alter speed
if (input_walk or input_run){
	spd = abs((input_walk*w_spd) - (input_run*r_spd));
} else{
	spd = n_spd;	
}

// Reset var
moveX = 0;
moveY = 0;

// Intended Movement
// inputs cancel out if both pressed since they are 0s and 1s
moveX = (input_right - input_left) * spd;
if(moveX == 0){moveY = (input_down - input_up) * spd;}

// get direction facing
if(moveX != 0) {
	switch(sign(moveX)){
		case 1: facing = dir.right; break;
		case -1: facing = dir.left; break;
	}
} else if(moveY != 0) {
	switch(sign(moveY)){
		case 1: facing = dir.down; break;
		case -1: facing = dir.up; break;
	}
} else {
	facing = -1;
}

// Collision Check
// Horizontal
if(moveX != 0){
	if(place_meeting(x+moveX, y, obj_collision)){
		repeat(abs(moveX)){
			if(!place_meeting(x+sign(moveX), y, obj_collision)){
				x += sign(moveX);
			} else{
				break;
			}
		}
		moveX = 0;
	}
}

// Vertical
if(moveY != 0){
	if(place_meeting(x, y+moveY, obj_collision)){
		repeat(abs(moveY)){
			if(!place_meeting(x, y+sign(moveY), obj_collision)){
				y += sign(moveY);
			} else{
				break;
			}
		}
		moveY = 0;
	}
}

//Objects
var inst = instance_place(x, y, obj_transition);
if (inst != noone and facing == inst.playerFacingBefore){
	with(game){
		if(!doTransition){
			spawnRoom = inst.targetRoom;
			spawnX = inst.targetX;
			spawnY = inst.targetY;
			spawnPlayerFacing = inst.playerFacingAfter;
			doTransition = true;
		}
	}
}

	
// Apply movement
x += moveX;
y += moveY;