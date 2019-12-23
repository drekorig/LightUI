if not LightUIDB.A_SMARTKITTY == true then return end

local combatInfo = {
    ["order"] = {
        "Rake",
        "Shred",
        -- /run print(IsUsableSpell("Rake"))
        -- /run print(CastSpellByName(164812, "target"));
        -- /run print(GetSpellBookItemInfo("Brutal Slash"))
        "BrutalSlash",
        "Rip",
        "FerociousBite",
        "Mangle",
        "Berserk",
        "TigersFury",
        "Regrowth",
        "EntanglingRoots",
        "Thrash",
        "Moonfire",
        "CatForm",
        "BearForm",
    },
    spelluid = {
            ["BearForm"] = 5487,
            ["Berserk"] = 106951,
            ["Bloodtalons"] = 145152,
            ["BrutalSlash"] = 202028,
            ["CatForm"] = 768,
            ["Clearcasting"] = 135700,
            ["EntanglingRoots"] = 339,
            ["FerociousBite"] = 22568,
            ["Mangle"] = 33917,
            --["Moonfire"] = 8921,
            ["Moonfire"] = 164812,
            ["PredatorySwiftness"] = 69369,
            --["Rake"] = 1822,
            ["Rake"] = 155722,
            ["Regrowth"] = 8936,
            ["Rip"] = 1079,
            ["Shred"] = 5221,
            --["Thrash"] = 77758,
            ["Thrash"] = 192090,
            ["TigersFury"] = 5217,
    },
    ["button"] = {},
    ["used"] = {
        ["CatForm"] = 0,
        ["Rake"] = 0,
        ["TigersFury"] = 0,
        ["FerociousBite"] = 0,
        ["Moonfire"] = 0,
        ["Shred"] = 0,
        ["BearForm"] = 0,
        ["Mangle"] = 0,
        ["Thrash"] = 0,
        ["Rip"] = 0,
        ["BrutalSlash"] = 0,
        ["Regrowth"] = 0,
        ["EntanglingRoots"] = 0,
        ["Berserk"] = 0,
    },
}

local h,v
for order, spell in ipairs(combatInfo["order"]) do
    v = order - 1
    v = v % 7
    h = (order - v) / 7
	combatInfo["button"][spell] = CreateFrame(
        "Button",
        "LightUI" .. spell .. "Button",
        UIParent,
        "SecureActionButtonTemplate"
    )
    combatInfo["button"][spell]:SetSize(32,32)
    combatInfo["button"][spell]:SetPoint("CENTER", -112 + v * 36, h * 36 - 132)

	combatInfo["button"][spell]:SetAttribute("type", "spell");
	name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(combatInfo["spelluid"][spell])
	combatInfo["button"][spell]:SetAttribute("spell", name);
	combatInfo["button"][spell]:SetNormalTexture(icon)
	combatInfo["button"][spell]:SetAlpha(.1)
end

local LightUI=CreateFrame("Frame")
for i, e in pairs({
    "ADDON_LOADED",
    "PLAYER_REGEN_DISABLED",
    "PLAYER_REGEN_ENABLED",
    "PLAYER_TARGET_CHANGED",
    "UNIT_SPELLCAST_SUCCEEDED",
    "UNIT_POWER_UPDATE",
    "SPELL_UPDATE_USABLE",
 }) do
    LightUI:RegisterEvent(e)
end
LightUI:SetScript("OnEvent", function(self, event, ...)
    local localizedClass, englishClass, classIndex = UnitClass("player")
    if not englishClass == "DRUID" then return end
    if not LightUIDB.A_SMARTKITTY == true then return end
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        unitTarget, castGUID, spellId = ...
        for spell, uid in pairs(combatInfo["spelluid"]) do
            if(spell == "Thrash") then
                uid = 77758
            end
            --print(event)
            --print(spellId)
            --print(uid)
            if uid == spellId then
                combatInfo["used"][spell] = combatInfo["used"][spell] + 1
            end
        end
    end
    CombatAlgorithme()
    -- if in combat ?
    if UnitAffectingCombat("player") == true then
        return
    end
    -- if not in combat hide all buttons
    for spell, button in pairs(combatInfo["button"]) do
        --button:SetAlpha(.1)
        button:SetAlpha(.1)
    end
end)

function CombatAlgorithme()
    --1 = Bear/Dire Bear Form
    --2 = Cat Form
    -- bear form
    if GetShapeshiftForm() == 1 then
        BearCombat()
        return
    end
    -- cat form
    if GetShapeshiftForm() == 2 then
        CatCombat()
        return
    end
    combatInfo["button"]["CatForm"]:SetAlpha(1)
    return
end

function BearCombat()
    local hp = UnitHealth("player")
    local hpMax = UnitHealthMax("player")
    local hpPercent = hp / hpMax * 100;

    BuffTracker(combatInfo["spelluid"]["Clearcasting"])
    --return

    if BuffTracker(combatInfo["spelluid"]["PredatorySwiftness"]) then
        if hpPercent > 85 then
            HideAllButton()
            combatInfo["button"]["Regrowth"]:SetAlpha(.1)
            combatInfo["button"]["EntanglingRoots"]:SetAlpha(1)
            return
        else
            HideAllButton()
            combatInfo["button"]["Regrowth"]:SetAlpha(1)
            combatInfo["button"]["EntanglingRoots"]:SetAlpha(.1)
            return
        end
    end
    if DebuffTracker(combatInfo["spelluid"]["Moonfire"]) then
        combatInfo["button"]["Moonfire"]:SetAlpha(.1)
    else
        HideAllButton()
        combatInfo["button"]["Moonfire"]:SetAlpha(1)
        return
    end
    --if combatInfo["used"]["Thrash"] then
    if DebuffTracker(combatInfo["spelluid"]["Thrash"],6) then
        combatInfo["button"]["Thrash"]:SetAlpha(.1)
    else
        HideAllButton()
        combatInfo["button"]["Thrash"]:SetAlpha(1)
        return
    end


    if combatInfo["used"]["Mangle"] > 0 then
        combatInfo["button"]["Mangle"]:SetAlpha(.1)
        combatInfo["button"]["CatForm"]:SetAlpha(1)
    else
        combatInfo["button"]["Mangle"]:SetAlpha(1)
    end
end

function CatCombat()
    local hp = UnitHealth("player")
    local hpMax = UnitHealthMax("player")
    local hpPercent = hp / hpMax * 100;
    local comboPoints = GetComboPoints("player","target")
    local power = UnitPower("player")

    if SpellCanBeUsed(combatInfo["spelluid"]["Berserk"]) then
        combatInfo["used"]["Berserk"] = 0
    end

    if not IsPlayerSpell(combatInfo["spelluid"]["Berserk"]) then
        combatInfo["used"]["Berserk"] = 1
    end
    --[[ Virtuel Energy under Berserk
    Reduces the energy cost of all Cat Form abilities by 40%
    and increases maximum Energy by 50 for 20 sec. ]]
    if BuffTracker(combatInfo["spelluid"]["Berserk"]) then
        power = power / 0.4
    end

    local enabled = SpellCanBeUsed(combatInfo["spelluid"]["TigersFury"]);
    if enabled and power < 80 then
        HideAllButton()
        combatInfo["button"]["TigersFury"]:SetAlpha(1)
        return
    else
        combatInfo["button"]["TigersFury"]:SetAlpha(.1)
    end

    if BuffTracker(combatInfo["spelluid"]["PredatorySwiftness"]) then
        if hpPercent > 85 then
            if comboPoints > 3 then
                HideAllButton()
                combatInfo["button"]["Regrowth"]:SetAlpha(.1)
                combatInfo["button"]["EntanglingRoots"]:SetAlpha(1)
                return
            end
        else
            HideAllButton()
            combatInfo["button"]["Regrowth"]:SetAlpha(1)
            combatInfo["button"]["EntanglingRoots"]:SetAlpha(.1)
            return
        end
    end

    if comboPoints > 4 then
        HideAllButton()
        if DebuffTracker(combatInfo["spelluid"]["Rip"],1) then
            if power < 45 then
                if combatInfo["used"]["Berserk"] == 0 then
                    HideAllButton()
                    combatInfo["button"]["Berserk"]:SetAlpha(1)
                    return
                end
                combatInfo["button"]["BearForm"]:SetAlpha(1)
                return
            end
            combatInfo["button"]["Rip"]:SetAlpha(.1)
            combatInfo["button"]["FerociousBite"]:SetAlpha(1)
        else
            combatInfo["button"]["Rip"]:SetAlpha(1)
            combatInfo["button"]["FerociousBite"]:SetAlpha(.1)
        end
        return
    else
        combatInfo["button"]["Rip"]:SetAlpha(.1)
        combatInfo["button"]["FerociousBite"]:SetAlpha(.1)
    end

    if BuffTracker(combatInfo["spelluid"]["Clearcasting"],1) then
        HideAllButton()
        combatInfo["button"]["Shred"]:SetAlpha(1)
        combatInfo["button"]["BrutalSlash"]:SetAlpha(.1)
        return
    else
        combatInfo["button"]["Shred"]:SetAlpha(.1)
    end

    if DebuffTracker(combatInfo["spelluid"]["Rake"]) then
        combatInfo["button"]["Rake"]:SetAlpha(.1)
    else
        HideAllButton()
        combatInfo["button"]["Rake"]:SetAlpha(1)
        return
    end

    -- /dump IsSpellKnown(202028)
    -- /dump IsUsableSpell(202028)
    -- /dump GetSpellCooldown(202028)
    -- /dump IsAttackSpell(202028)
    -- /dump IsPlayerSpell(202028)
    if IsPlayerSpell(combatInfo["spelluid"]["BrutalSlash"]) then
        local currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(combatInfo["spelluid"]["BrutalSlash"]);
        if currentCharges > 0 then
            HideAllButton()
            combatInfo["button"]["BrutalSlash"]:SetAlpha(1)
            return
        elseif cooldownDuration < 3 then
            HideAllButton()
            combatInfo["button"]["BrutalSlash"]:SetAlpha(1)
            return
        else
            combatInfo["button"]["BrutalSlash"]:SetAlpha(.1)
        end
    end

    if power < 30 then
        if combatInfo["used"]["Berserk"] == 0 then
            HideAllButton()
            combatInfo["button"]["Berserk"]:SetAlpha(1)
            return
        end
        -- if under Tiger's Fury don't change to Bear Form
        if BuffTracker(combatInfo["spelluid"]["TigersFury"],5) then
            combatInfo["button"]["BearForm"]:SetAlpha(.1)
            return
        else
            combatInfo["button"]["BearForm"]:SetAlpha(1)
        end
    else
        combatInfo["button"]["Shred"]:SetAlpha(1)
        combatInfo["button"]["BearForm"]:SetAlpha(.1)
    end

end

function BuffTracker(trackId,trackDuration)
    if not trackDuration then
        trackDuration = 3
    end
    for i=1,40 do
        local name, icon, count, buffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId = UnitBuff("player",i)
        --[[
        if spellId then
            print(name .. " - " .. "SpellId : " .. spellId .. " | TrackId : " .. trackId)
        end
        --]]
        if spellId == trackId then
            duration = expirationTime - GetTime()
            if duration > trackDuration then
                return true
            else
                return false
            end
        end
    end
    return false
end

function DebuffTracker(trackId,trackDuration)
    if not trackDuration then
        trackDuration = 3
    end
    for i=1,40 do
        local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId = UnitDebuff("target",i)
        --[[
        if spellId then
            print(name .. " - " .. "SpellId : " .. spellId .. " | TrackId : " .. trackId)
        end
        --]]
        if spellId == trackId then
            duration = expirationTime - GetTime()
            if duration > 3 then
                return true
            else
                return false
            end
        end
    end
    return false
end

function SpellCanBeUsed(uid,trackDuration)
    if not trackDuration then
        trackDuration = 3
    end
    local usable, nomana = IsUsableSpell(uid)
    if not usable then
        return false
    end
    --]]
    -- /run print(GetSpellCooldown(106951))
    local start, duration, enabled = GetSpellCooldown(uid);
    --print(GetSpellCooldown(uid))
    if enabled == 0 then
        return false
    elseif ( start > 0 or duration >= 3) then
        return false
    else
        return true
    end
end

function HideAllButton()
    for spell, button in pairs(combatInfo["button"]) do
        button:SetAlpha(.1)
    end
end