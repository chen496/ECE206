#include "library.h"
const double win_width=1000;
const double win_height=500;
const double pi = acos(-1.0);
const double rad2deg = 180 / pi;
const double deg2rad = pi / 180;

const double skycolors[25][3] = {
	{ 0.1,0.1,0.34 }, // 0: midnightblue3
	{ 0.1,0.1,0.34 }, // 1: midnightblue3
	{ 0.1,0.1,0.34 }, // 2: midnightblue3
	{ 0.1,0.1,0.44 }, // 3: midnightblue
	{ 0.1,0.1,0.44 }, // 4: midnightblue
	{ 0.06,0.3,0.55 }, // 5: dodgerblue4
	{ 0,0.6,0.8 }, // 6: DeepSkyBlue3
	{ 0,0.6,0.8 }, // 7: DeepSkyBlue3
	{ 0.5,0.75,0.93 }, // 8: skyblue2
	{ 0.5,0.75,0.93 }, // 9: skyblue2
	{ 0.7,0.87,0.93 }, // 10: light blue 2
	{ 0.7,0.87,0.93 }, // 11: light blue 2
	{ 0.75,0.94,1 }, // noon : light blue
	{ 0.75,0.94,1 }, // 13: light blue
	{ 0.7,0.87,0.93 }, // 14: light blue 2
	{ 0.7,0.87,0.93 }, // 15: light blue 2
	{ 0.5,0.75,0.93 }, // 16: skyblue2
	{ 0.5,0.75,0.93 }, // 17: skyblue2
	{ 0,0.6,0.8 }, // 18: DeepSkyBlue3
	{ 0,0.6,0.8 }, // 19: DeepSkyBlue3
	{ 0.06,0.3,0.55 }, // 20: dodgerblue
	{ 0.1,0.1,0.44 }, // 21: midnightblue
	{ 0.1,0.1,0.44 }, // 22: midnightblue
	{ 0.1,0.1,0.34 }, // 23: midnightblue3
	{ 0.1,0.1,0.34 }, // 24: midnightblue3 = 0 am
};

const double building0colors[5][3] = {
{ 0.6, 0.6, 0.6}, // grey6
{ 0.76, 0.80, 0.76}, // honeydew3
{ 0.70, 0.87, 0.93}, //LightBlue2
{ 0.96, 1.00, 0.98}, //MintCream
{ 0.23, 0.37, 0.80}, //RoyalBlue3
};

const double building1colors[5][3] = {
	{ 0.80, 0.36, 0.36 }, // indianred
	{ 0.80, 0.73, 0.59 }, // wheat3
	{ 0.85, 0.75, 0.85 }, //thistle
	{ 0.21, 0.39, 0.55 }, //steelblue4
	{ 0.80, 0.52, 0.25 }, //peru
};

const double roof1colors[5][3] = {
	{ 0.41, 0.41, 0.41 }, // grey41
	{ 0.80, 0.52, 0.25 }, // peru
	{ 0.60, 0.25, 0.25 }, // 
	{ 0.39, 0.58, 0.93 }, // CornflowerBlue
	{ 0.28, 0.24, 0.55 }, // DarkSlateBlue
};

void draw_mt(const int points, const double range1, const double range2, const double red, const double green, const double blue)
{
	start_shape();
	move_to(0.0, 0.5*win_height);
	note_position();
	const double del = 1.0/points;
	for (double a = del; a <= 1; a = a + del)
	{
		draw_to(random_in_range( (a-del)*win_width, (a)*win_width), random_in_range(range1*win_height, range2*win_height));
		note_position();
	}
	// close the filling region
	draw_to(win_width, 0.5*win_height);
	note_position();
	draw_to(win_width,win_height);
	note_position();
	draw_to(0. , win_height);
	note_position();
	draw_to(0. , 0.5*win_height);
	note_position();
	set_pen_color(red,green,blue);
	fill_shape();
}


void draw_background(int skyset)
{
	set_pen_color(skycolors[skyset][0],skycolors[skyset][1],skycolors[skyset][2]); // need to change later.
	fill_rectangle(0. , 0. , win_width, win_height);
	
	if (skyset >= 6 && skyset <=13)
	{ 
		set_pen_color(color::yellow);
		start_shape();
		draw_circle((0.8-0.05*(skyset-6))*win_width,(0.35-0.05*(skyset-6))*win_height,0.1*win_height,0);
		fill_shape();
	}

	if (skyset >= 22)
	{
		set_pen_color(color::yellow);
		start_shape();
		draw_circle((0.8 - 0.05*(skyset - 22))*win_width, (0.35 - 0.05*(skyset - 22))*win_height, 0.1*win_height, 0);
		fill_shape();
	}

	if (skyset <= 3)
	{
		set_pen_color(color::yellow);
		start_shape();
		draw_circle((0.8 - 0.05*(skyset +4))*win_width, (0.35 - 0.05*(skyset +5))*win_height, 0.1*win_height, 0);
		fill_shape();
	}

	if ( skyset>= 21 || skyset <= 4 ) // night background (mountain?) settings
	{
		draw_mt(4, 0.3, 0.7, 0.15, 0.15, 0.15); // some dark background
		draw_mt(6, 0.6, 0.8, 0.25, 0.25, 0.25);
	}
	else // day background settings
	{
		draw_mt(4,  0.3, 0.7, 0.85, 1, 0.85); // some kinda light green
		draw_mt(7,  0.4, 0.7, 0.56, 0.73, 0.56); // darkseagreen
		draw_mt(15, 0.6, 0.8, 0.18, 0.55, 0.34); //seagreen
	}

}

void bd1_fill(double x, double y, double z, double w, int colorcode, int h)
{
	double bdh = z*win_height;
	double bdw = w*win_height;

	// garage if this house has enough land
	if (bdw <= 0.25*win_width*0.65) {
		start_shape();
		set_pen_width(1);
		move_to(x + bdw, y);
		note_position();
		set_heading_degrees(0);
		draw_distance(0.6*bdh);
		note_position();
		set_heading_degrees(90);
		draw_distance(0.4*bdw);
		note_position();
		set_heading_degrees(180);
		draw_distance(0.6*bdh);
		note_position();
		set_heading_degrees(270);
		draw_distance(0.4*bdw);
		note_position();
		set_pen_color(building1colors[colorcode][0], building1colors[colorcode][1], building1colors[colorcode][2]);
		fill_shape();

		// garage roof
		double rfh = 0.20*bdh;
		start_shape();
		move_to(x +0.96*bdw, y - 0.6*bdh);
		note_position();
		draw_to(x +bdw, y - 0.6*bdh - rfh);
		note_position();
		draw_to(x + 1.4* bdw, y - 0.6* bdh - rfh);
		note_position();
		draw_to(x + 1.44*bdw, y - 0.6*bdh);
		note_position();
		draw_to(x +0.96*bdw, y - 0.6*bdh);
		note_position();
		set_pen_color(roof1colors[colorcode][0], roof1colors[colorcode][1], roof1colors[colorcode][2]);
		fill_shape();

		// garage door
		start_shape();
		move_to(x + 1.05 *bdw, y);
		note_position();
		set_heading_degrees(0);
		draw_distance(0.4*bdh);
		note_position();
		set_heading_degrees(90);
		draw_distance(0.3*bdw);
		note_position();
		set_heading_degrees(180);
		draw_distance(0.4*bdh);
		note_position();
		set_heading_degrees(270);
		draw_distance(0.3*bdw);
		note_position();
		set_pen_color(color::white);
		fill_shape();

		// garage door outline
		set_pen_color(color::light_grey);
		move_to(x + 1.05 *bdw, y);
		set_heading_degrees(0);
		draw_distance(0.4*bdh);
		set_heading_degrees(90);
		draw_distance(0.3*bdw);
		set_heading_degrees(180);
		draw_distance(0.4*bdh);
		set_heading_degrees(270);
		draw_distance(0.3*bdw);

		move_to(x + 1.05 *bdw, y-0.1*bdh);
		set_heading_degrees(90);
		draw_distance(0.3*bdw);
		move_to(x + 1.05 *bdw, y - 0.2*bdh);
		set_heading_degrees(90);
		draw_distance(0.3*bdw);
		move_to(x + 1.05 *bdw, y - 0.3*bdh);
		set_heading_degrees(90);
		draw_distance(0.3*bdw);

	} // end if 

	// draw main house
	start_shape();
	move_to(x, y);
	note_position();
	set_heading_degrees(0);
	draw_distance(bdh);
	note_position();
	set_heading_degrees(90);
	draw_distance(bdw);
	note_position();
	set_heading_degrees(180);
	draw_distance(bdh);
	note_position();
	set_heading_degrees(270);
	draw_distance(bdw);
	note_position();
	set_pen_color(building1colors[colorcode][0], building1colors[colorcode][1], building1colors[colorcode][2]);
	fill_shape();

	// house roof
	double rfh = 0.25*bdh;
	start_shape();
	move_to(x - 0.04*bdw, y - bdh);
	note_position();
	draw_to(x, y - bdh - rfh);
	note_position();
	draw_to(x + bdw, y - bdh - rfh);
	note_position();
	draw_to(x + 1.04*bdw, y - bdh);
	note_position();
	draw_to(x - 0.04*bdw, y - bdh);
	note_position();
	set_pen_color(roof1colors[colorcode][0], roof1colors[colorcode][1], roof1colors[colorcode][2]);
	fill_shape();

	// house windows
	int windowcol = random_in_range(2, 3);
	int windowrow = 2;
	double winh = 0.5*(bdh / windowrow);
	double winw = 0.5*(bdw / windowcol);
	for (int iii = 0; iii < windowcol; iii++) {
		for (int jjj = 0; jjj < windowrow; jjj++) {
			move_to(x + ((iii + 0.25)*bdw / windowcol), y - bdh + ((jjj + 0.25)*bdh / windowrow));
			int rr = random_in_range(0, 5);
			if (h >= 6 && h <= 20)
			{
				set_pen_color(0.59, 1.00, 1.00); //darkslategray1
			}
			else
			{
				if (rr == 0)
					set_pen_color(color::yellow);
				else
					set_pen_color(0, 0, 0);
			}
			fill_rectangle(x + ((iii + 0.25)*bdw / windowcol), y - bdh + ((jjj + 0.25)*bdh / windowrow), winw, winh);
			if (rr == 0)
			{
				// draw curtain
				int curtainstyle = random_in_range(0, 2);
				set_pen_width(1);
				if (curtainstyle == 0)
				{
					set_pen_color(color::dark_grey);
					fill_rectangle(x + ((iii + 0.25)*bdw / windowcol), y - bdh + ((jjj + 0.25)*bdh / windowrow), 0.4*winw, winh);
					start_shape();
					move_to(x + ((iii + 0.25)*bdw / windowcol) + 0.6*winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + winw, y - bdh + (jjj + 0.25)*bdh / windowrow + 0.6*winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + 0.8*winw, y - bdh + (jjj + 0.25)*bdh / windowrow + winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + winw, y - bdh + (jjj + 0.25)*bdh / windowrow + winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + 0.6* winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					fill_shape();	
				}
				else if (curtainstyle >= 1)
				{
					set_pen_color(color::dark_grey);
					start_shape();
					move_to(x + ((iii + 0.25)*bdw / windowcol) + 0.4*winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol), y - bdh + (jjj + 0.25)*bdh / windowrow + 0.6*winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + 0.2*winw, y - bdh + (jjj + 0.25)*bdh / windowrow + winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol), y - bdh + (jjj + 0.25)*bdh / windowrow + winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol), y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + 0.4* winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					fill_shape();


					start_shape();
					move_to(x + ((iii + 0.25)*bdw / windowcol) + 0.6*winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + winw, y - bdh + (jjj + 0.25)*bdh / windowrow + 0.6*winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + 0.8*winw, y - bdh + (jjj + 0.25)*bdh / windowrow + winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + winw, y - bdh + (jjj + 0.25)*bdh / windowrow + winh);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					draw_to(x + ((iii + 0.25)*bdw / windowcol) + 0.6* winw, y - bdh + (jjj + 0.25)*bdh / windowrow);
					note_position();
					fill_shape();

				}
			}
		}
	}

	// draw door
	move_to(x + (1.25*bdw / windowcol), y - bdh + 1.25*bdh / windowrow);
	double random_grey = random_in_range(20, 80)*0.01;
	set_pen_color(random_grey, random_grey, random_grey);
	fill_rectangle(x + (1.25*bdw / windowcol) - 0.1*winw, y - 1.1*bdh + 1.25*bdh / windowrow, 1.2*winw, bdh*0.6);

	// draw door knob
	move_to(x + (1.25*bdw / windowcol) + 0.9*winw, y - 1.1* bdh + 1.75*bdh / windowrow);
	set_pen_color(roof1colors[colorcode][0], roof1colors[colorcode][1], roof1colors[colorcode][2]);
	set_pen_width(5);
	draw_point();
	set_pen_width(1);

	// draw bushes
	int drawbush= random_in_range(0,2);
	if (drawbush <= 1)
	{
		set_pen_width(win_height / 100);
		for (int k = 0; k<250; k++)
		{
			int posx = x + winw* ( random_in_range(-100, 2200) / 1000.0);
			int posy = y - bdh * random_in_range(0, 120) / 1000.0;
			int pickagreen = random_in_range(0, 2);
			move_to(posx, posy);
			if (pickagreen == 0)
				set_pen_color(color::green);
			else if (pickagreen == 1)
				set_pen_color(color::dark_green);
			else if (pickagreen == 2)
				set_pen_color(color::light_green);
			draw_point();
		}
		if (windowcol == 3){
		for (int k = 0; k<250; k++)
		{
			int posx = x + (2.1*bdw / windowcol) + winw* (random_in_range(-100, 2000) / 1000.0);
			int posy = y - bdh * random_in_range(0, 120) / 1000.0;
			int pickagreen = random_in_range(0, 2);
			move_to(posx, posy);
			if (pickagreen == 0)
				set_pen_color(color::green);
			else if (pickagreen == 1)
				set_pen_color(color::dark_green);
			else if (pickagreen == 2)
				set_pen_color(color::light_green);
			draw_point();
		}}
		set_pen_width(1);
	}

}
