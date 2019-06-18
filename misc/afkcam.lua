local PName = UnitPVPName("player")
local PLevel = UnitLevel("player")
local PClass = select(2, UnitClass("player"))
local PRace = select(2, UnitRace("player"))
local PFaction = UnitFactionGroup("player")
local color = RAID_CLASS_COLORS[PClass]
local blank = [[Interface\AddOns\CreelUI\textures\blank.tga]]
local normTex = [[Interface\AddOns\CreelUI\textures\normTex.tga]]
local font = STANDARD_TEXT_FONT

local PGuild
if IsInGuild() then
	PGuild = select(1, GetGuildInfo("player"))
else
	PGuild = " "
end

local function UpdateColor(t)
	if t == template then return end

	if t == "Transparent" then
		local balpha = 1
		if t == "Transparent" then balpha = 0.7 end
		borderr, borderg, borderb = { .125, .125, .125 }
		backdropr, backdropg, backdropb = { .05, .05, .05 }
		backdropa = balpha
	end

	template = t
end

local function SetTemplate(f, t, tex)
	if tex then
		texture = normTex
	else
		texture = blank
	end

	UpdateColor(t)

	f:SetBackdrop({
	  bgFile = texture,
	  edgeFile = blank,
	  tile = false, tileSize = 0, edgeSize = 1,
	})

	if not noinset and not f.isInsetDone then
		f.insettop = f:CreateTexture(nil, "BORDER")
		f.insettop:SetPoint("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insettop:SetPoint("TOPRIGHT", f, "TOPRIGHT", 1, -1)
		f.insettop:SetHeight(1)
		f.insettop:SetTexture(0, 0, 0)
		f.insettop:SetDrawLayer("BORDER", -7)

		f.insetbottom = f:CreateTexture(nil, "BORDER")
		f.insetbottom:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", -1, -1)
		f.insetbottom:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, -1)
		f.insetbottom:SetHeight(1)
		f.insetbottom:SetTexture(0, 0, 0)
		f.insetbottom:SetDrawLayer("BORDER", -7)

		f.insetleft = f:CreateTexture(nil, "BORDER")
		f.insetleft:SetPoint("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insetleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, -1)
		f.insetleft:SetWidth(1)
		f.insetleft:SetTexture(0, 0, 0)
		f.insetleft:SetDrawLayer("BORDER", -7)

		f.insetright = f:CreateTexture(nil, "BORDER")
		f.insetright:SetPoint("TOPRIGHT", f, "TOPRIGHT", 1, 1)
		f.insetright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, -1)
		f.insetright:SetWidth(1)
		f.insetright:SetTexture(0, 0, 0)
		f.insetright:SetDrawLayer("BORDER", -7)

		f.insetinsidetop = f:CreateTexture(nil, "BORDER")
		f.insetinsidetop:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsidetop:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, 1)
		f.insetinsidetop:SetHeight(1)
		f.insetinsidetop:SetTexture(0, 0, 0)
		f.insetinsidetop:SetDrawLayer("BORDER", -7)

		f.insetinsidebottom = f:CreateTexture(nil, "BORDER")
		f.insetinsidebottom:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
		f.insetinsidebottom:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
		f.insetinsidebottom:SetHeight(1)
		f.insetinsidebottom:SetTexture(0, 0, 0)
		f.insetinsidebottom:SetDrawLayer("BORDER", -7)

		f.insetinsideleft = f:CreateTexture(nil, "BORDER")
		f.insetinsideleft:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsideleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", -1, 1)
		f.insetinsideleft:SetWidth(1)
		f.insetinsideleft:SetTexture(0, 0, 0)
		f.insetinsideleft:SetDrawLayer("BORDER", -7)

		f.insetinsideright = f:CreateTexture(nil, "BORDER")
		f.insetinsideright:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
		f.insetinsideright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, 1)
		f.insetinsideright:SetWidth(1)
		f.insetinsideright:SetTexture(0, 0, 0)
		f.insetinsideright:SetDrawLayer("BORDER", -7)

		f.isInsetDone = true
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.SetTemplate then mt.SetTemplate = SetTemplate end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end

local AFKPanel = CreateFrame( "Frame", "AFKPanel", nil )
AFKPanel:SetPoint( "BOTTOMLEFT", UIParent, "BOTTOMLEFT", -2, -2 )
AFKPanel:SetPoint( "TOPRIGHT", UIParent, "BOTTOMRIGHT", 2, 150 )
AFKPanel:SetTemplate("Transparent")
AFKPanel:Hide()

local AFKPanelTop = CreateFrame( "Frame", "AFKPanelTop", nil )
AFKPanelTop:SetPoint( "TOPLEFT", UIParent, "TOPLEFT",-2, 2 )
AFKPanelTop:SetPoint( "BOTTOMRIGHT", UIParent, "TOPRIGHT", 2, -80 )
AFKPanelTop:SetTemplate("Transparent")
AFKPanelTop:SetFrameStrata("FULLSCREEN")
AFKPanelTop:Hide()

AFKPanelTop.Text = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanelTop.Text:SetPoint( "CENTER", AFKPanelTop, "CENTER", 0, 0 )
AFKPanelTop.Text:SetFont( font, 40, "OUTLINE" )
AFKPanelTop.Text:SetText( "AFK" )
AFKPanelTop.Text:SetTextColor( color.r, color.g, color.b )

AFKPanelTop.DateText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanelTop.DateText:SetPoint( "BOTTOMLEFT", AFKPanelTop, "BOTTOMRIGHT", -100, 44 )
AFKPanelTop.DateText:SetFont( font, 15, "OUTLINE" )

AFKPanelTop.ClockText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanelTop.ClockText:SetPoint( "BOTTOMLEFT", AFKPanelTop, "BOTTOMRIGHT", -100, 20 )
AFKPanelTop.ClockText:SetFont( font, 20, "OUTLINE" )

AFKPanelTop.PlayerNameText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanelTop.PlayerNameText:SetPoint( "LEFT", AFKPanelTop, "LEFT", 25, 19 )
AFKPanelTop.PlayerNameText:SetFont( font, 26, "OUTLINE" )
AFKPanelTop.PlayerNameText:SetText( PName )
AFKPanelTop.PlayerNameText:SetTextColor( color.r, color.g, color.b )

--[[
--GLADS
local function getglad(gladid,rank1id,gladlogo,rank1logo,anchor)

local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText = GetAchievementInfo(gladid);
local isglad = Completed

local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText =  GetAchievementInfo(rank1id);
local isrank1 = Completed

if isrank1 == true then
	print("rank1")
end
if isglad == true and isrank1 == false then
	print("isglad")
	emblem = AFKPanel:CreateTexture( nil, 'OVERLAY')
	emblem:SetSize(25, 25)
	emblem:SetPoint("LEFT", anchor, "LEFT", 30, 0 )
	emblem:SetTexture("Interface\\AddOns\\SUI\\inc\\media\\glad\\" .. gladlogo)
end

end

local GladAnchor = AFKPanel:CreateTexture( nil, 'OVERLAY')
GladAnchor:SetSize(25, 25)
GladAnchor:SetPoint("LEFT", AFKPanel, "LEFT", 0, -50 )

getglad("11011","11012","gladlegion1","rank1legion1",GladAnchor) --Legion1
getglad("11013","11014","gladlegion2","rank1legion1",emblem) --Legion2
getglad("11038","11037","gladlegion3","rank1legion1",emblem) --Legion3
getglad("11061","11062","gladlegion4","rank1legion1",emblem) --Legion4
getglad("12045","12010","gladlegion5","rank1legion1",emblem) --Legion5
getglad("12167","12134","gladlegion6","rank1legion1",emblem) --Legion6
getglad("12168","12185","gladlegion7","rank1legion1",emblem) --Legion7
]]

AFKPanel.Text = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanel.Text:SetPoint("CENTER", AFKPanel, "CENTER", 0, 15 )
AFKPanel.Text:SetFont( font, 110, "OUTLINE" )
AFKPanel.Text:SetText( "|cfff58cbaS|r|cff009cffUI|r" )

AFKPanel.Text = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanel.Text:SetPoint("CENTER", AFKPanel, "CENTER", 0, -40 )
AFKPanel.Text:SetFont( font, 22, "OUTLINE" )
AFKPanel.Text:SetText( "|cfff58cbav|r|cff009cff8.0|r" )

--[[
AFKPanel.logo = AFKPanel:CreateTexture( nil, 'OVERLAY')
AFKPanel.logo:SetSize(50, 50)
AFKPanel.logo:SetPoint("CENTER", AFKPanel, "CENTER", 0, 50 )
AFKPanel.logo:SetTexture("Interface\\AddOns\\SUI\\inc\\media\\logo.tga")
--]]

-- Set Up the Player Model
AFKPanel.playerModel = CreateFrame('PlayerModel', nil, AFKPanel);
AFKPanel.playerModel:SetSize(800, 1000)
AFKPanel.playerModel:SetPoint("RIGHT", AFKPanel, "RIGHT", 250, 110 )
AFKPanel.playerModel:SetUnit('player');
AFKPanel.playerModel:SetAnimation(0);
AFKPanel.playerModel:SetRotation(math.rad(-15));
AFKPanel.playerModel:SetCamDistanceScale(1.8);

AFKPanelTop.GuildText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanelTop.GuildText:SetPoint( "LEFT", AFKPanelTop, "LEFT", 25, -3 )
AFKPanelTop.GuildText:SetFont( font, 15, "OUTLINE" )
AFKPanelTop.GuildText:SetText( "|cff0394ff" .. PGuild .. "|r" )

AFKPanelTop.PlayerInfoText = AFKPanelTop:CreateFontString( nil, "OVERLAY" )
AFKPanelTop.PlayerInfoText:SetPoint( "LEFT", AFKPanelTop, "LEFT", 25, -20 )
AFKPanelTop.PlayerInfoText:SetFont( font, 15, "OUTLINE" )
AFKPanelTop.PlayerInfoText:SetText( LEVEL .. " " .. PLevel .. " " .. PFaction .. " " .. PClass )

local interval = 0
AFKPanelTop:SetScript( "OnUpdate", function( self, elapsed )
	interval = interval - elapsed
	if( interval <= 0 ) then
		AFKPanelTop.ClockText:SetText( format("%s", date( "%H:%M:%S" ) ) )
		AFKPanelTop.DateText:SetText( format("%s", date( "%a %b/%d" ) ) )
		interval = 0.5
	end
end )

local OnEvent = function(self, event, unit)
	if event == "PLAYER_FLAGS_CHANGED" then
		local isArena, isRegistered = IsActiveBattlefieldArena()
		if unit == "player" then
			if UnitIsAFK(unit) and not UnitIsDead(unit) and not InCombatLockdown() and not isArena then
				SpinStart()
				AFKPanel:Show()
				AFKPanelTop:Show()
				Minimap:Hide()
			else
				SpinStop()
				AFKPanel:Hide()
				AFKPanelTop:Hide()
				Minimap:Show()
			end
		end
	elseif event == "PLAYER_LEAVING_WORLD" then
		SpinStop()
	elseif event == "PLAYER_DEAD" then
		if UnitIsAFK("player") then
			SpinStop()
			AFKPanel:Hide()
			AFKPanelTop:Hide()
			Minimap:Show()
		end
	end
end

AFKPanel:RegisterEvent( "PLAYER_ENTERING_WORLD" )
AFKPanel:RegisterEvent( "PLAYER_LEAVING_WORLD" )
AFKPanel:RegisterEvent( "PLAYER_FLAGS_CHANGED" )
AFKPanel:SetScript( "OnEvent", OnEvent )

AFKPanel:SetScript( "OnShow", function( self )
	UIParent:Hide();
end )

AFKPanel:SetScript( "OnHide", function( self )
	UIFrameFadeOut( UIParent, 0.5, 0, 1 )
end )

function SpinStart()
	spinning = true
	MoveViewRightStart( 0.1 )
end

function SpinStop()
	if( not spinning ) then return end
	spinning = nil
	MoveViewRightStop()
end