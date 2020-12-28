
--- GUI STUFF
local w, h = draw.GetScreenSize()
local x = w/2
local y = h/2
local current_angle = 0
local drawLeft = 0
local drawRight = 0
local drawBack = 0

setFont = draw.SetFont
createFont = draw.CreateFont
getScreenSize = draw.GetScreenSize
getLocal = entities.GetLocalPlayer
color = draw.Color
text = draw.TextShadow

--- LOADER

local SCRIPT_FILE_NAME = GetScriptName()
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/sam100111/Aimware-Luas/main/Unlimited.lua"
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/sam100111/Aimware-Luas/main/version.txt"
local VERSION_NUMBER = "1.0"
local version_check_done = false
local update_downloaded = false
local update_available = false
local up_to_date = false
local updaterfont1 = draw.CreateFont("Bahnschrift", 18)
local updaterfont2 = draw.CreateFont("Bahnschrift", 14)
local updateframes = 0
local fadeout = 0
local spacing = 0
local fadein = 0

callbacks.Register( "Draw", "handleUpdates", function()
	if updateframes < 5.5 then
		if up_to_date or updateframes < 0.25 then
			updateframes = updateframes + globals.AbsoluteFrameTime()
			if updateframes > 5 then
				fadeout = ((updateframes - 5) * 510)
			end
			if updateframes > 0.1 and updateframes < 0.25 then
				fadein = (updateframes - 0.1) * 4500
			end
			if fadein < 0 then fadein = 0 end
			if fadein > 650 then fadein = 650 end
			if fadeout < 0 then fadeout = 0 end
			if fadeout > 255 then fadeout = 255 end
		end
		if updateframes >= 0.25 then fadein = 650 end
		for i = 0, 600 do
			local alpha = 200-i/3 - fadeout
			if alpha < 0 then alpha = 0 end
			draw.Color(15,15,15,alpha)
			draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30)
			draw.Color(255, 150, 75,alpha)
			draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31)
		end
		draw.SetFont(updaterfont1)
		draw.Color(255,150,75,255 - fadeout)
		draw.Text(7 - 650 + fadein, 7, "Unlimited ")
		draw.Color(225,225,225,255 - fadeout)
		draw.Text(7 + draw.GetTextSize("Unlimited ") - 650 + fadein, 7, "Script")
		draw.Color(255,150,75,255 - fadeout)
		draw.Text(7 + draw.GetTextSize("Unlimited Script  ") - 650 + fadein, 7, "\\")
		spacing = draw.GetTextSize("Unlimited Script  \\  ")
		draw.SetFont(updaterfont2)
		draw.Color(225,225,225,255 - fadeout)
	end

    if (update_available and not update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false
        update_downloaded = true
	end
	
    if (update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.")
        return
    end

    if (not version_check_done) then
        version_check_done = true
		local version = http.Get(VERSION_FILE_ADDR)
		version = string.gsub(version, "\n", "")
		if (version ~= VERSION_NUMBER) then
            update_available = true
		else 
			up_to_date = true
		end
	end
	
	if up_to_date and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER)
	end
end)

