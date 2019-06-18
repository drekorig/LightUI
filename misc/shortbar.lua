local LightUI=CreateFrame("Frame")
LightUI:RegisterEvent("PLAYER_LOGIN")
LightUI:SetScript("OnEvent", function(self, event)

if not LightUIDB.A_SHORTBAR == true then return end

local size = 32
local spacing = 2

local invisible = CreateFrame("Frame", nil)
invisible:EnableMouse(false)
invisible:Hide()

local BlizzArt = {
	MainMenuBarArtFrameBackground.BackgroundLarge,
	MainMenuBarArtFrameBackground.BackgroundSmall,
	MainMenuBarTexture0,
	MainMenuBarTexture1,
	MainMenuBarTexture2,
	MainMenuBarTexture3,
	MainMenuBarArtFrame.LeftEndCap,
	MainMenuBarArtFrame.RightEndCap,
	PossessBackground1,
	PossessBackground2,
	PossessBackground3,
	PossessBackground4,
	PossessBackground5,
	PossessBackground6,
	PossessBackground7,
	PossessBackground8,
	PossessBackground9,
	PossessBackground10,
	PossessBackground11,
	PossessBackground12,
	--OverrideActionBarBG,
	--OverrideActionBarBorder,
	--OverrideActionBarButtonBGR,
	--OverrideActionBarDivider1,
	--OverrideActionBarDivider2,
	--OverrideActionBarEndCapR,
	--OverrideActionBarEndCapL,
	--MainMenuBarArtFrame.PageNumber,
	--ActionBarUpButton,
	--ActionBarDownButton,
	StanceBarLeft,
	StanceBarRight,
	--ReputationWatchBar,
	--MainMenuExpBar,
	--ArtifactWatchBar,
	--HonorWatchBar,
}

for _, frame in pairs(BlizzArt) do
	frame:SetParent(invisible)
end

local holder = CreateFrame("Frame", "MainMenuBarHolderFrame", UIParent, "SecureHandlerStateTemplate")
holder:SetSize(size * 12 + spacing * 11 + Minimap:GetWidth() + 72 , size)
holder:SetPoint("BOTTOM", UIParent, 0, 14)
holder:RegisterEvent("PLAYER_LOGIN")
holder:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Action bars
ActionButton1:ClearAllPoints()
ActionButton1:SetPoint("BOTTOMLEFT", holder, 0, 0)
ActionButton7:ClearAllPoints();
ActionButton7:SetPoint("RIGHT", ActionButton6, "RIGHT", Minimap:GetWidth() + 72 - spacing * 3, 0);

MultiBarBottomLeftButton1:ClearAllPoints()
MultiBarBottomLeftButton1:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", 0, 2 * spacing)
MultiBarBottomLeftButton7:ClearAllPoints();
MultiBarBottomLeftButton7:SetPoint("BOTTOMLEFT", ActionButton7, "TOPLEFT", 0, 2 * spacing);

MultiBarBottomRightButton1:ClearAllPoints()
MultiBarBottomRightButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 0, 2 * spacing)
MultiBarBottomRightButton7:ClearAllPoints()
MultiBarBottomRightButton7:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton7, "TOPLEFT", 0, 2 * spacing)

-- Side bars
MultiBarLeftButton1:ClearAllPoints()
MultiBarLeftButton1:SetPoint("TOPLEFT", MultiBarRightButton1, "TOPLEFT", -2 * spacing - size, 0)

MultiBarRightButton1:ClearAllPoints()
MultiBarRightButton1:SetPoint("RIGHT", UIParent, "RIGHT", -2 * spacing, 150)

-- Pet Bar
PetActionButton1:ClearAllPoints()
PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1, "TOPLEFT", size/2, 2 * spacing)
PetActionButton6:ClearAllPoints()
PetActionButton6:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton7, "TOPLEFT", size/2, 2 * spacing)
PetActionBarFrame:SetWidth(size)
PetActionBarFrame:SetHeight(size)

-- Possess Bar
PossessButton1:ClearAllPoints()
PossessButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1, "TOPLEFT", size/2, 2 * spacing)

for i = 1, NUM_ACTIONBAR_BUTTONS do
	local ab = _G["ActionButton" .. i]
	local mbbl = _G["MultiBarBottomLeftButton" .. i]
	local mbbr = _G["MultiBarBottomRightButton" .. i]
	local mbl = _G["MultiBarLeftButton" .. i]
	local mbr = _G["MultiBarRightButton" .. i]
	local pab = _G["PetActionButton" .. i]
	local mcab = _G["MultiCastActionButton" .. i]
	local pb = _G["PossessButton" .. i]

	ab:SetSize(size, size)

	mbbl:SetSize(size, size)

	mbbr:SetSize(size, size)

	mbl:SetSize(size, size)

	mbr:SetSize(size, size)

	if pab then
	--pab:SetSize(size, size)
	end

	if pb then
		pb:SetSize(size, size)
	end
end

-- Bar's Page number
MainMenuBarArtFrame.PageNumber:ClearAllPoints();
MainMenuBarArtFrame.PageNumber:SetPoint("LEFT", ActionButton1, "LEFT", size/-2, 0);
MainMenuBarArtFrame.PageNumber.SetPoint = function() end
MainMenuBarArtFrame.PageNumber.ClearAllPoints = function() end

-- XP & Reputation bars
local SetPoint = getmetatable(MainMenuBar).__index.SetPoint
hooksecurefunc(MainMenuBar, 'SetPoint', function()
    MainMenuBar:ClearAllPoints();
	SetPoint(MainMenuBar, 'TOP', UIParent, 'TOP', 0, 48)
	MultiBarBottomLeft:ClearAllPoints();
	SetPoint(MultiBarBottomLeft, 'TOP', UIParent, 'TOP', 0, 48)
	OverrideActionBar:ClearAllPoints();
	SetPoint(OverrideActionBar, 'BOTTOM', UIParent, 'BOTTOM', 0, 170)
end);
-- Bags
MicroButtonAndBagsBar.MicroBagBar:Hide();
--MainMenuBarBackpackButton:ClearAllPoints();
--MainMenuBarBackpackButton:SetPoint("LEFT", CharacterMicroButton, "LEFT", -1.5 * size, 0);
--MainMenuBarBackpackButton:SetHeight(30)
--MainMenuBarBackpackButton:SetWidth(32)
--CharacterBag0Slot:ClearAllPoints();
--CharacterBag0Slot:SetPoint("Right", MainMenuBarBackpackButton, "LEFT", -spacing, 0);

end)