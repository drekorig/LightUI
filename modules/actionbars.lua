﻿local LightUI=CreateFrame("Frame")
LightUI:RegisterEvent("ADDON_LOADED")
LightUI:SetScript("OnEvent", function(self, event)

if not LightUIDB.A_DEFAULTS == true then return end

local classcolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
local dominos = IsAddOnLoaded("Dominos")
local bartender4 = IsAddOnLoaded("Bartender4")

--backdrop settings
local bgfile, edgefile = "", ""
if LightUIDB.background.showshadow then
  edgefile = LightUIDB.textures.outer_shadow
end
if LightUIDB.background.useflatbackground and LightUIDB.background.showbg then
  bgfile = LightUIDB.textures.buttonbackflat
end

--backdrop
local backdrop = {
  bgFile = bgfile,
  edgeFile = edgefile,
  tile = false,
  tileSize = 32,
  edgeSize = LightUIDB.background.inset,
  insets = {
    left = LightUIDB.background.inset,
    right = LightUIDB.background.inset,
    top = LightUIDB.background.inset,
    bottom = LightUIDB.background.inset
  }
}

--font
local FONT = nil
if LightUIDB.A_FONTS == true then
FONT = LightUIDB.FONTS.NORMAL
else
FONT = STANDARD_TEXT_FONT
end
---------------------------------------
-- FUNCTIONS
---------------------------------------

if IsAddOnLoaded("Masque") and (dominos or bartender4) then
  return
end

local function applyBackground(bu)
  if not bu or (bu and bu.bg) then
    return
  end
  --shadows+background
  if bu:GetFrameLevel() < 1 then
    bu:SetFrameLevel(1)
  end
  if LightUIDB.background.showbg or LightUIDB.background.showshadow then
    bu.bg = CreateFrame("Frame", nil, bu)
    -- bu.bg:SetAllPoints(bu)
    bu.bg:SetPoint("TOPLEFT", bu, "TOPLEFT", -4, 4)
    bu.bg:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", 4, -4)
    bu.bg:SetFrameLevel(bu:GetFrameLevel() - 1)
    if LightUIDB.background.showbg and not LightUIDB.background.useflatbackground then
      local t = bu.bg:CreateTexture(nil, "BACKGROUND", -8)
      t:SetTexture(LightUIDB.textures.buttonback)
      --t:SetAllPoints(bu)
      t:SetVertexColor(
        LightUIDB.background.backgroundcolor.r,
        LightUIDB.background.backgroundcolor.g,
        LightUIDB.background.backgroundcolor.b,
        LightUIDB.background.backgroundcolor.a
      )
    end
    bu.bg:SetBackdrop(backdrop)
    if LightUIDB.background.useflatbackground then
      bu.bg:SetBackdropColor(
        LightUIDB.background.backgroundcolor.r,
        LightUIDB.background.backgroundcolor.g,
        LightUIDB.background.backgroundcolor.b,
        LightUIDB.background.backgroundcolor.a
      )
    end
    if LightUIDB.background.showshadow then
      bu.bg:SetBackdropBorderColor(
        LightUIDB.background.shadowcolor.r,
        LightUIDB.background.shadowcolor.g,
        LightUIDB.background.shadowcolor.b,
        LightUIDB.background.shadowcolor.a
      )
    end
  end
end

--style extraactionbutton
local function styleExtraActionButton(bu)
  if not bu or (bu and bu.rabs_styled) then
    return
  end
  local name = bu:GetName() or bu:GetParent():GetName()
  local style = bu.style or bu.Style
  local icon = bu.icon or bu.Icon
  local cooldown = bu.cooldown or bu.Cooldown
  local ho = _G[name .. "HotKey"]
  -- remove the style background theme
  style:SetTexture(nil)
  hooksecurefunc(
    style,
    "SetTexture",
    function(self, texture)
      if texture then
        --print("reseting texture: "..texture)
        self:SetTexture(nil)
      end
    end
  )
  --icon
  icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
  --icon:SetAllPoints(bu)
  icon:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
  icon:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
  --cooldown
  cooldown:SetAllPoints(icon)
  --hotkey
  if ho then
    ho:Hide()
  end
  --add button normaltexture
  bu:SetNormalTexture(LightUIDB.textures.normal)
  local nt = bu:GetNormalTexture()
  nt:SetVertexColor(LightUIDB.color.normal.r, LightUIDB.color.normal.g, LightUIDB.color.normal.b, 1)
  nt:SetAllPoints(bu)
  --apply background
  --if not bu.bg then applyBackground(bu) end
  bu.Back = CreateFrame("Frame", nil, bu)
  bu.Back:SetPoint("TOPLEFT", bu, "TOPLEFT", -3, 3)
  bu.Back:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", 3, -3)
  bu.Back:SetFrameLevel(bu:GetFrameLevel() - 1)
  bu.Back:SetBackdrop(backdrop)
  bu.Back:SetBackdropBorderColor(0, 0, 0, 0.9)
  bu.rabs_styled = true
end

--gryphones
if LightUIDB.A_GRYPHONES == false then
  MainMenuBarArtFrame.LeftEndCap:Hide()
  MainMenuBarArtFrame.RightEndCap:Hide()
end

--initial style func
local function styleActionButton(bu)
  if not bu or (bu and bu.rabs_styled) then
    return
  end
  local action = bu.action
  local name = bu:GetName()
  local ic = _G[name .. "Icon"]
  local co = _G[name .. "Count"]
  local bo = _G[name .. "Border"]
  local ho = _G[name .. "HotKey"]
  local cd = _G[name .. "Cooldown"]
  local na = _G[name .. "Name"]
  local fl = _G[name .. "Flash"]
  local nt = _G[name .. "NormalTexture"]
  local fbg = _G[name .. "FloatingBG"]
  local fob = _G[name .. "FlyoutBorder"]
  local fobs = _G[name .. "FlyoutBorderShadow"]
  if fbg then
    fbg:Hide()
  end --floating background
  --flyout border stuff
  if fob then
    fob:SetTexture(nil)
  end
  if fobs then
    fobs:SetTexture(nil)
  end
  bo:SetTexture(nil) --hide the border (plain ugly, sry blizz)
  --hotkey
  ho:SetFont(FONT, LightUIDB.hotkeys.fontsize, "OUTLINE")
  ho:ClearAllPoints()
  ho:SetPoint(LightUIDB.hotkeys.pos1.a1, bu, LightUIDB.hotkeys.pos1.x, LightUIDB.hotkeys.pos1.y)
  ho:SetPoint(LightUIDB.hotkeys.pos2.a1, bu, LightUIDB.hotkeys.pos2.x, LightUIDB.hotkeys.pos2.y)
  if not dominos and not bartender4 and not LightUIDB.A_HOTKEYS == true then
    ho:Hide()
  end
  --macro name
  na:SetFont(FONT, LightUIDB.macroname.fontsize, "OUTLINE")
  na:ClearAllPoints()
  na:SetPoint(LightUIDB.macroname.pos1.a1, bu, LightUIDB.macroname.pos1.x, LightUIDB.macroname.pos1.y)
  na:SetPoint(LightUIDB.macroname.pos2.a1, bu, LightUIDB.macroname.pos2.x, LightUIDB.macroname.pos2.y)
  if not dominos and not bartender4 and not LightUIDB.A_MACROS == true then
    na:Hide()
  end
  --item stack count
  co:SetFont(FONT, LightUIDB.itemcount.fontsize, "OUTLINE")
  co:ClearAllPoints()
  co:SetPoint(LightUIDB.itemcount.pos1.a1, bu, LightUIDB.itemcount.pos1.x, LightUIDB.itemcount.pos1.y)
  if not dominos and not bartender4 and not LightUIDB.itemcount.show then
    co:Hide()
  end
  --applying the textures
  if LightUIDB.A_DARKFRAMES == true then
    fl:SetTexture(LightUIDB.textures.flash)
    --bu:SetHighlightTexture(LightUIDB.textures.hover)
    bu:SetPushedTexture(LightUIDB.textures.pushed)
    --bu:SetCheckedTexture(LightUIDB.textures.checked)
    bu:SetNormalTexture(LightUIDB.textures.normal)
    if not nt then
      --fix the non existent texture problem (no clue what is causing this)
      nt = bu:GetNormalTexture()
    end
    --cut the default border of the icons and make them shiny
    ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
    ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
    --adjust the cooldown frame
    cd:SetPoint("TOPLEFT", bu, "TOPLEFT", LightUIDB.cooldown.spacing, -LightUIDB.cooldown.spacing)
    cd:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -LightUIDB.cooldown.spacing, LightUIDB.cooldown.spacing)
    --apply the normaltexture
    if action and IsEquippedAction(action) then
      --bu:SetNormalTexture(LightUIDB.textures.equipped)
      nt:SetVertexColor(LightUIDB.color.equipped.r, LightUIDB.color.equipped.g, LightUIDB.color.equipped.b, 1)
    else
      bu:SetNormalTexture(LightUIDB.textures.normal)
      nt:SetVertexColor(LightUIDB.color.normal.r, LightUIDB.color.normal.g, LightUIDB.color.normal.b, 1)
    end
    --make the normaltexture match the buttonsize
    nt:SetAllPoints(bu)
    --hook to prevent Blizzard from reseting our colors
    hooksecurefunc(
      nt,
      "SetVertexColor",
      function(nt, r, g, b, a)
        local bu = nt:GetParent()
        local action = bu.action
        --print("bu"..bu:GetName().."R"..r.."G"..g.."B"..b)
        if r == 1 and g == 1 and b == 1 and action and (IsEquippedAction(action)) then
          if LightUIDB.color.equipped.r == 1 and LightUIDB.color.equipped.g == 1 and LightUIDB.color.equipped.b == 1 then
            nt:SetVertexColor(0.999, 0.999, 0.999, 1)
          else
            nt:SetVertexColor(LightUIDB.color.equipped.r, LightUIDB.color.equipped.g, LightUIDB.color.equipped.b, 1)
          end
        elseif r == 0.5 and g == 0.5 and b == 1 then
          --blizzard oom color
          if LightUIDB.color.normal.r == 0.5 and LightUIDB.color.normal.g == 0.5 and LightUIDB.color.normal.b == 1 then
            nt:SetVertexColor(0.499, 0.499, 0.999, 1)
          else
            nt:SetVertexColor(LightUIDB.color.normal.r, LightUIDB.color.normal.g, LightUIDB.color.normal.b, 1)
          end
        elseif r == 1 and g == 1 and b == 1 then
          if LightUIDB.color.normal.r == 1 and LightUIDB.color.normal.g == 1 and LightUIDB.color.normal.b == 1 then
            nt:SetVertexColor(0.999, 0.999, 0.999, 1)
          else
            nt:SetVertexColor(LightUIDB.color.normal.r, LightUIDB.color.normal.g, LightUIDB.color.normal.b, 1)
          end
        end
      end
    )
    --shadows+background
    if not bu.bg then
      applyBackground(bu)
    end
    bu.rabs_styled = true
    if bartender4 then --fix the normaltexture
      nt:SetTexCoord(0, 1, 0, 1)
      nt.SetTexCoord = function()
        return
      end
      bu.SetNormalTexture = function()
        return
      end
    end
  end
end

-- style leave button
local function styleLeaveButton(bu)
  if LightUIDB.A_DARKFRAMES == true then
    if not bu or (bu and bu.rabs_styled) then
      return
    end
    --local region = select(1, bu:GetRegions())
    local name = bu:GetName()
    local nt = bu:GetNormalTexture()
    local bo = bu:CreateTexture(name .. "Border", "BACKGROUND", nil, -7)
    nt:SetTexCoord(0.2, 0.8, 0.2, 0.8)
    nt:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
    nt:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
    bo:SetTexture(LightUIDB.textures.normal)
    bo:SetTexCoord(0, 1, 0, 1)
    bo:SetDrawLayer("BACKGROUND", -7)
    bo:SetVertexColor(0.4, 0.35, 0.35)
    bo:ClearAllPoints()
    bo:SetAllPoints(bu)
    --shadows+background
    if not bu.bg then
      applyBackground(bu)
    end
    bu.rabs_styled = true
  end
end

--style pet buttons
local function stylePetButton(bu)
  if LightUIDB.A_DARKFRAMES == true then
    if not bu or (bu and bu.rabs_styled) then
      return
    end
    local name = bu:GetName()
    local ic = _G[name .. "Icon"]
    local fl = _G[name .. "Flash"]
    local nt = _G[name .. "NormalTexture2"]
    nt:SetAllPoints(bu)
    --applying color
    nt:SetVertexColor(LightUIDB.color.normal.r, LightUIDB.color.normal.g, LightUIDB.color.normal.b, 1)
    --setting the textures
    fl:SetTexture(LightUIDB.textures.flash)
    --bu:SetHighlightTexture(LightUIDB.textures.hover)
    bu:SetPushedTexture(LightUIDB.textures.pushed)
    --bu:SetCheckedTexture(LightUIDB.textures.checked)
    bu:SetNormalTexture(LightUIDB.textures.normal)
    hooksecurefunc(
      bu,
      "SetNormalTexture",
      function(self, texture)
        --make sure the normaltexture stays the way we want it
        if texture and texture ~= LightUIDB.textures.normal then
          self:SetNormalTexture(LightUIDB.textures.normal)
        end
      end
    )
    --cut the default border of the icons and make them shiny
    ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
    ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
    --shadows+background
    if not bu.bg then
      applyBackground(bu)
    end
    bu.rabs_styled = true
  end
end

--style stance buttons
local function styleStanceButton(bu)
  if LightUIDB.A_DARKFRAMES == true then
    if not bu or (bu and bu.rabs_styled) then
      return
    end
    local name = bu:GetName()
    local ic = _G[name .. "Icon"]
    local fl = _G[name .. "Flash"]
    local nt = _G[name .. "NormalTexture2"]
    nt:SetAllPoints(bu)
    --applying color
    nt:SetVertexColor(LightUIDB.color.normal.r, LightUIDB.color.normal.g, LightUIDB.color.normal.b, 1)
    --setting the textures
    fl:SetTexture(LightUIDB.textures.flash)
    --bu:SetHighlightTexture(LightUIDB.textures.hover)
    bu:SetPushedTexture(LightUIDB.textures.pushed)
    --bu:SetCheckedTexture(LightUIDB.textures.checked)
    bu:SetNormalTexture(LightUIDB.textures.normal)
    --cut the default border of the icons and make them shiny
    ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
    ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
    --shadows+background
    if not bu.bg then
      applyBackground(bu)
    end
    bu.rabs_styled = true
  end
end

--style possess buttons
local function stylePossessButton(bu)
  if LightUIDB.A_DARKFRAMES == true then
    if not bu or (bu and bu.rabs_styled) then
      return
    end
    local name = bu:GetName()
    local ic = _G[name .. "Icon"]
    local fl = _G[name .. "Flash"]
    local nt = _G[name .. "NormalTexture"]
    nt:SetAllPoints(bu)
    --applying color
    nt:SetVertexColor(LightUIDB.color.normal.r, LightUIDB.color.normal.g, LightUIDB.color.normal.b, 1)
    --setting the textures
    fl:SetTexture(LightUIDB.textures.flash)
    --bu:SetHighlightTexture(LightUIDB.textures.hover)
    bu:SetPushedTexture(LightUIDB.textures.pushed)
    --bu:SetCheckedTexture(LightUIDB.textures.checked)
    bu:SetNormalTexture(LightUIDB.textures.normal)
    --cut the default border of the icons and make them shiny
    ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
    ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
    --shadows+background
    if not bu.bg then
      applyBackground(bu)
    end
    bu.rabs_styled = true
  end
end

-- style bags
local function styleBag(bu)
  if LightUIDB.A_DARKFRAMES == true then
    if not bu or (bu and bu.rabs_styled) then
      return
    end
    local name = bu:GetName()
    local ic = _G[name .. "IconTexture"]
    local nt = _G[name .. "NormalTexture"]
    nt:SetTexCoord(0, 1, 0, 1)
    nt:SetDrawLayer("BACKGROUND", -7)
    nt:SetVertexColor(0.4, 0.35, 0.35)
    nt:SetAllPoints(bu)
    local bo = bu.IconBorder
    bo:Hide()
    bo.Show = function()
    end
    ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
    ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
    bu:SetNormalTexture(LightUIDB.textures.normal)
    --bu:SetHighlightTexture(LightUIDB.textures.hover)
    bu:SetPushedTexture(LightUIDB.textures.pushed)
    --bu:SetCheckedTexture(LightUIDB.textures.checked)

    --make sure the normaltexture stays the way we want it
    hooksecurefunc(
      bu,
      "SetNormalTexture",
      function(self, texture)
        if texture and texture ~= LightUIDB.textures.normal then
          self:SetNormalTexture(LightUIDB.textures.normal)
        end
      end
    )
    bu.Back = CreateFrame("Frame", nil, bu)
    bu.Back:SetPoint("TOPLEFT", bu, "TOPLEFT", -4, 4)
    bu.Back:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", 4, -4)
    bu.Back:SetFrameLevel(bu:GetFrameLevel() - 1)
    bu.Back:SetBackdrop(backdrop)
    bu.Back:SetBackdropBorderColor(0, 0, 0, 0.9)
  end
end

--update hotkey func
local function updateHotkey(self, actionButtonType)
  local ho = _G[self:GetName() .. "HotKey"]
  if ho and not LightUIDB.A_HOTKEYS == true and ho:IsShown() then
    ho:Hide()
  end
end

local function init()
  --style the actionbar buttons
  for i = 1, NUM_ACTIONBAR_BUTTONS do
    styleActionButton(_G["ActionButton" .. i])
    styleActionButton(_G["MultiBarBottomLeftButton" .. i])
    styleActionButton(_G["MultiBarBottomRightButton" .. i])
    styleActionButton(_G["MultiBarRightButton" .. i])
    styleActionButton(_G["MultiBarLeftButton" .. i])
  end
  --style bags
  for i = 0, 3 do
    styleBag(_G["CharacterBag" .. i .. "Slot"])
  end
  styleBag(MainMenuBarBackpackButton)
  for i = 1, 6 do
    styleActionButton(_G["OverrideActionBarButton" .. i])
  end
  --style leave button
  styleLeaveButton(MainMenuBarVehicleLeaveButton)
  styleLeaveButton(rABS_LeaveVehicleButton)
  --petbar buttons
  for i = 1, NUM_PET_ACTION_SLOTS do
    stylePetButton(_G["PetActionButton" .. i])
  end
  --stancebar buttons
  for i = 1, NUM_STANCE_SLOTS do
    styleStanceButton(_G["StanceButton" .. i])
  end
  --possess buttons
  if NUM_POSSESS_SLOTS then
    for i = 1, NUM_POSSESS_SLOTS do
      stylePossessButton(_G["PossessButton" .. i])
    end
  end

  --hide stancebarbackground
  --[[
  StanceBarLeft:SetAlpha(0)
  StanceBarMiddle:SetAlpha(0)
  StanceBarRight:SetAlpha(0)
  ]]
  --StanceBarLeft:SetPoint("BOTTOMLEFT", "StanceBarFrame", "BOTTOMLEFT", 0,-2)
  StanceButton1:ClearAllPoints();
  StanceButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton7, "TOPLEFT", 16, 4);

  --fix gryphons

  --extraactionbutton1
  styleExtraActionButton(ExtraActionButton1)
  if ZoneAbilityFrame then
    styleExtraActionButton(ZoneAbilityFrame.SpellButton)
  end
  --spell flyout

  if ZoneAbilityFrame then
    SpellFlyoutBackgroundEnd:SetTexture(nil)
    SpellFlyoutHorizontalBackground:SetTexture(nil)
    SpellFlyoutVerticalBackground:SetTexture(nil)
    local function checkForFlyoutButtons(self)
      local NUM_FLYOUT_BUTTONS = 10
      for i = 1, NUM_FLYOUT_BUTTONS do
        styleActionButton(_G["SpellFlyoutButton" .. i])
      end
    end
    SpellFlyout:HookScript("OnShow", checkForFlyoutButtons)
  end

  --dominos styling
  if dominos then
    --print("Dominos found")
    for i = 1, 60 do
      styleActionButton(_G["DominosActionButton" .. i])
    end
  end
  --bartender4 styling
  if bartender4 then
    --print("Bartender4 found")
    for i = 1, 120 do
      styleActionButton(_G["BT4Button" .. i])
      stylePetButton(_G["BT4PetButton" .. i])
    end
  end

  --hide the hotkeys if needed
  if not dominos and not bartender4 and not LightUIDB.A_HOTKEYS == true then
    hooksecurefunc("ActionButton_UpdateHotkeys", updateHotkey)
  end
end

local a = CreateFrame("Frame")
a:RegisterEvent("PLAYER_LOGIN")
a:SetScript("OnEvent", init)
end)