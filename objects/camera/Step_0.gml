moveCam = keyboard_check(ord("C"));

if(moveCam){
	x += (keyboard_check(ord("L")) - keyboard_check(ord("J")))*6;
	y += (keyboard_check(ord("K")) - keyboard_check(ord("I")))*6;
}else{
	x = clamp(x, following.x - h_border, following.x + h_border);
	y = clamp(y, following.y - v_border, following.y + v_border);
}