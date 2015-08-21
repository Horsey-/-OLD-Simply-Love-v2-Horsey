local t = Def.ActorFrame{}

-- Apply player modifiers from profile
t[#t+1] = LoadActor("playerModifiers")

-- Banner
t[#t+1] = LoadActor("banner")

-- Song Description (Artist, BPM, Duration)
t[#t+1] = LoadActor("songDescription")

-- Difficulty Blocks
t[#t+1] = LoadActor("CustomStepsDisplayList")

-- StepArtist Boxes
t[#t+1] =  LoadActor("stepArtist.lua")

-- Step Data (Number of steps, jumps, holds, etc.)
t[#t+1] = LoadActor("panedisplay")

-- Select Menu/Bottom Bar
t[#t+1] = LoadActor("bottombar")

-- the fadeout that informs users to press START if they want options
t[#t+1] = LoadActor("fadeOut")

return t