local t = Def.ActorFrame{}

for p=1,2 do

	local player = "PlayerNumber_P"..p;

	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			if not IsUsingWideScreen() then
				self:zoomx(0.95)
			end
			if player == PLAYER_1 then
				self:player(PLAYER_1)
				self:horizalign(left)
				self:y(_screen.cy + 43)
				if IsUsingWideScreen() then
					self:x(_screen.cx - 383)
				else
					self:x(_screen.cx - 347)
				end
			elseif player == PLAYER_2 then
				self:player(PLAYER_2)
				self:horizalign(right)
				self:y(_screen.cy + 97)
				if IsUsingWideScreen() then
					self:x(_screen.cx - 213)
				else
					self:x(_screen.cx - 177)
				end
			end

			if p == 1 and GAMESTATE:IsHumanPlayer(PLAYER_1) then
				self:queuecommand("AppearP1")
			end
			if p == 2 and GAMESTATE:IsHumanPlayer(PLAYER_2) then
				self:queuecommand("AppearP2")
			end
		end,

		AppearP1Command=cmd(visible, true; ease, 0.5, 275; addy, -30),
		AppearP2Command=cmd(visible, true; ease, 0.5, 275; addy,  30),

		PlayerJoinedMessageCommand=function(self, params)
			if p == 1 and params.Player == PLAYER_1 then
				self:queuecommand("AppearP1")
			elseif p == 2 and params.Player == PLAYER_2 then
				self:queuecommand("AppearP2")
			end
		end,

		-- colored background	
		LoadActor("stepartistbubble.png")..{
			InitCommand=function(self)
				if p == 1 then
					self:diffuse(PlayerColor(PLAYER_1))
					self:x(125.5)
					self:y(4)
					self:rotationx(180)
				end
				if p == 2 then
					self:diffuse(PlayerColor(PLAYER_2))
					self:x(76.5)
					self:y(-4)
					self:rotationy(180)
				end
			end,
			SetCommand=function(self)
				
				if GAMESTATE:IsHumanPlayer(player) then
					local currentSteps = GAMESTATE:GetCurrentSteps(player)
					if currentSteps then
						local currentDifficulty = currentSteps:GetDifficulty()
						self:diffuse(DifficultyColor(currentDifficulty))
					end
				end
			end
		},
	
		--STEPS label
		LoadFont("_misoreg hires")..{
			OnCommand=function(self)
				self:diffuse(0,0,0,1)
				self:horizalign(left)
				self:settext("STEPS")
				if p == 1 then
					self:x(30)
					self:y(-2)
				else 
					self:x(133)
					self:y(1)
				end
			end
		},
	
		--stepartist text
		LoadFont("_misoreg hires")..{
			OnCommand=function(self)
				self:diffuse(.118,.157,.184,1)
				self:maxwidth(142)
				if p == 1 then
					self:x(75)
					self:y(-2)
					self:horizalign(left)
				else
					self:x(126.5)
					self:y(1)
					self:horizalign(right)
				end
			end,
			SetCommand=function(self)
				local stepartist
				local cs = GAMESTATE:GetCurrentSteps(player)

				if cs then
					stepartist = cs:GetAuthorCredit()
				end

				if stepartist then
					if stepartist ~= "" then
						self:settext(stepartist)
					else
						self:settext("???")
					end
				end


				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				self:visible(song ~= nil or course ~= nil)
			end
		},

		-- song and course changes
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),

		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end,
		CurrentTrailP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end,
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end,
		CurrentTrailP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end
	}
end

return t