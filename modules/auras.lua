﻿local SUI=CreateFrame("Frame")
SUI:RegisterEvent("ADDON_LOADED")
SUI:SetScript("OnEvent", function(self, event)

if not SUIDB.A_DARKFRAMES == true then return end

--backdrop
    local backdrop = {
	bgFile = nil,
	edgeFile = "Interface\\AddOns\\SUI\\inc\\media\\core\\outer_shadow",
	tile = false,
	tileSize = 32,
	edgeSize = 4,
	insets = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 4,
	},
    }

--apply aura frame texture func
    local function applySkin(b)
	if not b or (b and b.styled) then return end
	--button name
	local name = b:GetName()
	if (name:match("Debuff")) then
		b.debuff = true
   	else
   		b.buff = true
	end
	--icon
	local icon = _G[name.."Icon"]
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetDrawLayer("BACKGROUND",-8)
	b.icon = icon
	--border
	local border = _G[name.."Border"] or b:CreateTexture(name.."Border", "BACKGROUND", nil, -7)
	border:SetTexture("Interface\\AddOns\\SUI\\inc\\media\\core\\gloss")
	border:SetTexCoord(0, 1, 0, 1)
	border:SetDrawLayer("BACKGROUND",- 7)
	if b.buff then
		border:SetVertexColor(0.4, 0.35, 0.35)
	end
	border:ClearAllPoints()
	border:SetPoint("TOPLEFT", b, "TOPLEFT", -1, 1)
	border:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 1, -1)
	b.border = border
	--shadow
	local back = CreateFrame("Frame", nil, b)
	back:SetPoint("TOPLEFT", b, "TOPLEFT", -4, 4)
	back:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 4, -4)
	back:SetFrameLevel(b:GetFrameLevel() - 1)
	back:SetBackdrop(backdrop)
	back:SetBackdropBorderColor(0, 0, 0, 0.9)
	b.bg = back
	--set button styled variable
	b.styled = true
    end

--apply castbar texture
    local function applycastSkin(b)
	if not b or (b and b.styled) then return end
	-- parent
	if b == CastingBarFrame.Icon then
		b.parent = CastingBarFrame
	elseif b == FocusFrameSpellBar.Icon then
		b.parent = FocusFrameSpellBar
	else
		b.parent = TargetFrameSpellBar
	end
	-- frame
	frame = CreateFrame("Frame", nil, b.parent)
    	--icon
    	b:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    	--border
    	local border = frame:CreateTexture(nil, "BACKGROUND")
    	border:SetTexture("Interface\\AddOns\\SUI\\inc\\media\\core\\gloss")
    	border:SetTexCoord(0, 1, 0, 1)
    	border:SetDrawLayer("BACKGROUND",- 7)
	    border:SetVertexColor(0.4, 0.35, 0.35)
    	border:ClearAllPoints()
	    border:SetPoint("TOPLEFT", b, "TOPLEFT", -1, 1)
      	border:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 1, -1)
    	b.border = border
	--shadow
	local back = CreateFrame("Frame", nil, b.parent)
	back:SetPoint("TOPLEFT", b, "TOPLEFT", -4, 4)
	back:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 4, -4)
	back:SetFrameLevel(frame:GetFrameLevel() - 1)
	back:SetBackdrop(backdrop)
	back:SetBackdropBorderColor(0, 0, 0, 0.9)
	b.bg = back
	--set button styled variable
	b.styled = true
    end

    -- setting timer for castbar icons
    function UpdateTimer(self, elapsed)
	total = total + elapsed
	if CastingBarFrame.Icon then
		if SUIDB.A_CASTBARS == true then 
		applycastSkin(CastingBarFrame.Icon)
		end
	end
	if TargetFrameSpellBar.Icon then
		applycastSkin(TargetFrameSpellBar.Icon)
	end
	if FocusFrameSpellBar.Icon then
		applycastSkin(FocusFrameSpellBar.Icon)
	end
	if CastingBarFrame.Icon.styled and TargetFrameSpellBar.Icon.styled then
		cf:SetScript("OnUpdate", nil)
	end
    end

    hooksecurefunc("TargetFrame_UpdateAuras", function(self)
	for i = 1, MAX_TARGET_BUFFS do
		b = _G["TargetFrameBuff"..i]
		applySkin(b)
	end
	for i = 1, MAX_TARGET_DEBUFFS do
		b = _G["TargetFrameDebuff"..i]
		applySkin(b)
	end
	for i = 1, MAX_TARGET_BUFFS do
		b = _G["FocusFrameBuff"..i]
		applySkin(b)
	end
	for i = 1, MAX_TARGET_DEBUFFS do
		b = _G["FocusFrameDebuff"..i]
		applySkin(b)
	end
    end)

    total = 0
    cf = CreateFrame("Frame")
	cf:SetScript("OnUpdate", UpdateTimer)
end)