local t = Def.ActorFrame{

Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(zoomto,_screen.w,87; diffuse,color("0.65,0.65,0.65,1");x,_screen.cx; y, SCREEN_BOTTOM+9);
		SelectMenuOpenedMessageCommand=cmd(accelerate,0.2;addy,-31);
		SelectMenuClosedMessageCommand=cmd(linear,0.3;addy,31);
	},
};

	Def.ActorFrame{
		Name="SelButtonMenu";
		InitCommand=cmd(y,SCREEN_BOTTOM+16-3);
		SelectMenuOpenedMessageCommand=cmd(accelerate,0.2;addy,-31);
		SelectMenuClosedMessageCommand=cmd(linear,0.3;addy,31);
			Def.ActorFrame{
				LoadFont("_misoreg hires")..{
					Text="&START; Change Sort";
					InitCommand=cmd(CenterX;diffusealpha,1;);
					OffCommand=cmd(linear,.3;diffusealpha,0);
				};
				Def.ActorFrame{
					Name="Easier";
					InitCommand=function(self)
						self:x(SCREEN_CENTER_X-100)
					end;
					LoadFont("_misoreg hires")..{
						Text="&MENULEFT;";
						OnCommand=cmd(x,-50;horizalign,right;);
						OffCommand=cmd(linear,.3;diffusealpha,0);
					};
					LoadFont("_misoreg hires")..{
						Text="Easier";
						OnCommand=cmd(x,-45;horizalign,left;diffuseramp;effectperiod,1;effectoffset,0.20;effectclock,'beat';effectcolor1,color("#FFFFFF");effectcolor2,color("#20D020");shadowlength,0);
						OffCommand=cmd(linear,.3;diffusealpha,0);
					};
				};
				Def.ActorFrame{
					Name="Harder";
					InitCommand=function(self)
						self:x(SCREEN_CENTER_X+100)
					end;
					LoadFont("_misoreg hires")..{
						Text="Harder";
						OnCommand=cmd(x,45;horizalign,right;diffuseramp;effectperiod,1;effectoffset,0.20;effectclock,'beat';effectcolor1,color("#FFFFFF");effectcolor2,color("#E06060");shadowlength,0);
						OffCommand=cmd(linear,.3;diffusealpha,0);
					};
					LoadFont("_misoreg hires")..{
						Text="&MENURIGHT;";
						OnCommand=cmd(x,58;horizalign,center;);
						OffCommand=cmd(linear,.3;diffusealpha,0);
					};
				};
			};
		};
};

return t;