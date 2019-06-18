local LightUI=CreateFrame("Frame")
LightUI:RegisterEvent("PLAYER_LOGIN")
LightUI:SetScript("OnEvent", function(self, event)

if not LightUIDB.A_VIEWPORT == true then return end

local function blackbox(point1, point2, point3, point4)
	local frame = CreateFrame("Frame")
	frame:SetBackdrop({bgFile = LightUIDB.VIEWPORT.backround})
	frame:SetBackdropBorderColor(0,0,0,0)
	frame:SetBackdropColor(unpack(LightUIDB.VIEWPORT.color))
	frame:SetFrameStrata("BACKGROUND")
	frame:SetPoint(point1, UIParent, point1)
	frame:SetPoint(point2, UIParent, point2)
	frame:SetPoint(point3, WorldFrame, point4)
	frame:Show()
end

blackbox("TOPLEFT",    "TOPRIGHT",    "BOTTOM", "TOP");
blackbox("BOTTOMLEFT", "BOTTOMRIGHT", "TOP",    "BOTTOM");
blackbox("TOPLEFT",    "BOTTOMLEFT",  "RIGHT",  "LEFT");
blackbox("TOPRIGHT",   "BOTTOMRIGHT", "LEFT",   "RIGHT");

--all you need for an addon like this, literally, code above is to make sure it stays black
local scale = 768 / UIParent:GetHeight()
WorldFrame:SetPoint("TOPLEFT", ( LightUIDB.VIEWPORT.left * scale ), -( LightUIDB.VIEWPORT.top * scale ) )
WorldFrame:SetPoint("BOTTOMRIGHT", -( LightUIDB.VIEWPORT.right * scale ), ( LightUIDB.VIEWPORT.bottom * scale ) )

end)