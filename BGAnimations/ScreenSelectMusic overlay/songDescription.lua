local t = Def.ActorFrame{

	InitCommand=function(self)
		if IsUsingWideScreen() then
			self:xy(_screen.cx - 197, _screen.cy - 28-10)
		else
			self:xy(_screen.cx - 163, _screen.cy - 28-10)
		end
	end,

	-- ----------------------------------------
	-- Actorframe for Artist, BPM, and Song length
	Def.ActorFrame{
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set"),

		-- background for Artist, BPM, and Song Length
		Def.Quad{
			InitCommand=function(self)
				self:diffuse(color("#1e282f"))
				if IsUsingWideScreen() then
					self:zoomto(320, _screen.h/7.2)
				else
					self:zoomto(310, _screen.h/7.2)
					self:addx(-2)
				end
			end
		},

		Def.ActorFrame{

			InitCommand=cmd(x, -110),

			-- Artist Label
			LoadFont("_misoreg hires")..{
				Text="ARTIST",
				InitCommand=cmd(horizalign, right; y, 0),
				OnCommand=cmd(diffuse,color("0.5,0.5,0.5,1"))
			},

			-- Song Artist
			LoadFont("_misoreg hires")..{
				InitCommand=cmd(horizalign,left; xy, 5,0; maxwidth,WideScale(255,260) ),
				SetCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()

					if song and song:GetDisplayArtist() then
						self:settext(song:GetDisplayArtist())
					else
						self:settext("")
					end
				end
			},

			-- Song Folder Label
			LoadFont("_misoreg hires")..{
				Text="FOLDER",
				InitCommand=cmd(horizalign, right; y, -20),
				OnCommand=cmd(diffuse,color("0.5,0.5,0.5,1"))
			},			

			-- Song Folder
			LoadFont("_misoreg hires")..{
				InitCommand=cmd(horizalign,left; xy, 6,-20; maxwidth,WideScale(255,260) ),
				SetCommand=function( actor )
					local song = GAMESTATE:GetCurrentSong()
				    local text = ""
						if song then
								--I would like to find a better method to trim up GetSongDir, but this will work for now, because I highly doubt people will name their packs "Songs" or "AdditionalSongs"
							local fulldir = song:GetSongDir();
								--removes the "/ " suffix placed by GetSongDir() (will not impact
							local remove_end = string.sub(fulldir, 0, -2);
								--removes "/Songs/" prefix, but if a songs folder is called "Songs" you'll get weird formatting
							local trimmed_dir = string.gsub(remove_end, "/Songs/", "", 1)
								--removes "/AdditionalSongs/" from the directory string, and will cause formatting weirdness if there is a song folder with that name 
							local SongDir = string.gsub(trimmed_dir, "/AdditionalSongs/", "", 1)
							text = SongDir
						end
				   actor:settext( text )
				end
			},

			-- BPM Label
			LoadFont("_misoreg hires")..{
				InitCommand=cmd(horizalign, right; NoStroke; y, 20),
				SetCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					self:diffuse(0.5,0.5,0.5,1)
					self:settext("BPM")
				end
			},

			-- BPM value
			LoadFont("_misoreg hires")..{
				InitCommand=cmd(horizalign, left; NoStroke; y, 20; x, 5; diffuse, color("1,1,1,1")),
				SetCommand=function(self)

					--defined in ./Scipts/SL-CustomSpeedMods.lua
					local text = GetDisplayBPMs()

					if text then
						self:settext(text)
					else
						self:settext("")
					end
				end
			},

			-- Song Length Label
			LoadFont("_misoreg hires")..{
				InitCommand=cmd(horizalign, right; NoStroke; y, 20; x, 200),
				SetCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					self:diffuse(0.5,0.5,0.5,1)
					self:settext("LENGTH")
				end
			},

			-- Song Length Value
			LoadFont("_misoreg hires")..{
				InitCommand=cmd(horizalign, left; NoStroke; y, 20; x, 207),
				SetCommand=function(self)
					local duration

					if GAMESTATE:IsCourseMode() then
						local Players = GAMESTATE:GetHumanPlayers()
						local player = Players[1]
						local trail = GAMESTATE:GetCurrentTrail(player)

						if trail then
							duration = TrailUtil.GetTotalSeconds(trail)
						end
					else
						local song = GAMESTATE:GetCurrentSong()
						if song then
							duration = song:MusicLengthSeconds()
						end
					end


					if duration then
						if duration == 105.0 then
							-- r21 lol
							self:settext("not 1:45")
						else
							local finalText = SecondsToMSSMsMs(duration)
							self:settext( string.sub(finalText, 0, finalText:len()-3) )
						end
					else
						self:settext("")
					end
				end
			}
		},

		Def.ActorFrame{
			OnCommand=function(self)
				if IsUsingWideScreen() then
					self:x(102)
				else
					self:x(97)
				end
			end,

			LoadActor("bubble.png")..{
				InitCommand=cmd(diffuse,GetCurrentColor(); visible, false; zoom, 0.9; y, 39),
				SetCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()

					if song then
						if song:IsLong() or song:IsMarathon() then
							self:visible(true)
						else
							self:visible(false)
						end
					else
						self:visible(false)
					end
				end
			},

			LoadFont("_misoreg hires")..{
				InitCommand=cmd(diffuse, Color.Black; zoom,0.8; y, 43),
				SetCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()

					if song then
						if song:IsLong() then
							self:settext("COUNTS AS 2 ROUNDS")
						elseif song:IsMarathon() then
							self:settext("COUNTS AS 3 ROUNDS")
						else
							self:settext("")
						end
					else
						self:settext("")
					end
				end
			}
		}
	}
}

return t