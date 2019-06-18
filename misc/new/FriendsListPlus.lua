local K, C = unpack(select(2, ...))
if C["Misc"].EnhancedFriends ~= true then
	return
end

local Module = K:NewModule("FriendsListPlus", "AceEvent-3.0", "AceHook-3.0")

-- Sourced: ProjectAzilroka (Azilroka)
-- Edited: KkthnxUI (Kkthnx)

local _G = _G
local format = format
local pairs = pairs
local tonumber = tonumber
local unpack = unpack

local BNConnected = _G.BNConnected
local BNGetFriendInfo = _G.BNGetFriendInfo
local BNGetGameAccountInfo = _G.BNGetGameAccountInfo
local CanCooperateWithGameAccount = _G.CanCooperateWithGameAccount
local GetFriendInfo = _G.GetFriendInfo
local GetQuestDifficultyColor = _G.GetQuestDifficultyColor

Module.Classes = {}

for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	Module.Classes[v] = k
end

for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
	Module.Classes[v] = k
end

local function ClassColorCode(class)
	local color = class and (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[Module.Classes[class]] or RAID_CLASS_COLORS[Module.Classes[class]]) or {r = 1, g = 1, b = 1}
	return format("|cFF%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
end

local MediaIconPath = "Interface\\AddOns\\KkthnxUI\\Media\\Textures\\GameIcons\\"

Module.Icons = {
	Game = {
		Alliance = MediaIconPath .. "Alliance",
		App = MediaIconPath .. "BattleNet",
		BSAp = MediaIconPath .. "BattleNet",
		D3 = MediaIconPath .. "D3",
		DST2 = MediaIconPath .. "Destiny2",
		Hero = MediaIconPath .. "Heroes",
		Horde = MediaIconPath .. "Horde",
		Neutral = MediaIconPath .. "WoW",
		Pro = MediaIconPath .. "Overwatch",
		S1 = MediaIconPath .. "SC",
		S2 = MediaIconPath .. "SC2",
		WTCG = MediaIconPath .. "Hearthstone",
		VIPR = MediaIconPath .. "COD4"
	},

	Status = {
		Online = FRIENDS_TEXTURE_ONLINE,
		Offline = FRIENDS_TEXTURE_OFFLINE,
		DND = FRIENDS_TEXTURE_DND,
		AFK = FRIENDS_TEXTURE_AFK,
	}
}

function Module:UpdateFriends(button)
	local nameText, nameColor, infoText, broadcastText, _, Cooperate
	if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
		local name, level, class, area, connected, status = GetFriendInfo(button.id)
		broadcastText = nil
		if connected then
			button.status:SetTexture(Module.Icons.Status[(status == CHAT_FLAG_DND and "DND" or status == CHAT_FLAG_AFK and "AFK" or "Online")])
			nameText = format("%s%s - (%s - %s %s)", ClassColorCode(class), name, class, LEVEL, level)
			nameColor = FRIENDS_WOW_NAME_COLOR
			Cooperate = true
		else
			button.status:SetTexture(Module.Icons.Status.Offline)
			nameText = name
			nameColor = FRIENDS_GRAY_COLOR
		end
		infoText = area
	elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET and BNConnected() then
		local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(button.id)
		local realmName, realmID, faction, race, class, zoneName, level, gameText
		broadcastText = messageText
		local characterName = toonName
		if presenceName then
			nameText = presenceName
			if isOnline then
				characterName = BNet_GetValidatedCharacterName(characterName, battleTag, client)
			end
		else
			nameText = UNKNOWN
		end

		if characterName then
			_, _, _, realmName, realmID, faction, race, class, _, zoneName, level, gameText = BNGetGameAccountInfo(toonID)
			if client == BNET_CLIENT_WOW then
				if (level == nil or tonumber(level) == nil) then level = 0 end
				local classcolor = ClassColorCode(class)
				local diff = level ~= 0 and format("|cFF%02x%02x%02x", GetQuestDifficultyColor(level).r * 255, GetQuestDifficultyColor(level).g * 255, GetQuestDifficultyColor(level).b * 255) or "|cFFFFFFFF"
				nameText = format("%s |cFFFFFFFF(|r%s%s|r - %s %s%s|r|cFFFFFFFF)|r", nameText, classcolor, characterName, LEVEL, diff, level)
				Cooperate = CanCooperateWithGameAccount(toonID)
			else
				if not Module.Icons.Game[client] then
					client = "App"
				end
				nameText = format("|cFF%s%s|r", Module.Icons.Game[client].Color or "FFFFFF", nameText)
			end
		end

		if isOnline then
			button.status:SetTexture(Module.Icons.Status[(status == CHAT_FLAG_DND and "DND" or status == CHAT_FLAG_AFK and "AFK" or "Online")])
			if client == BNET_CLIENT_WOW then
				if not zoneName or zoneName == "" then
					infoText = UNKNOWN
				else
					if realmName == Module.MyRealm then
						infoText = zoneName
					else
						infoText = gsub(gameText, "&apos;", "'")
					end
				end
				button.gameIcon:SetTexture(Module.Icons.Game[faction])
			else
				if not Module.Icons.Game[client] then
					client = "App"
				end
				infoText = gameText
				button.gameIcon:SetTexture(Module.Icons.Game[client])
			end
			nameColor = FRIENDS_BNET_NAME_COLOR
			button.gameIcon:SetTexCoord(0, 1, 0, 1)
		else
			button.status:SetTexture(Module.Icons.Status.Offline)
			nameColor = FRIENDS_GRAY_COLOR
			infoText = lastOnline == 0 and FRIENDS_LIST_OFFLINE or format(BNET_LAST_ONLINE_TIME, FriendsFrame_GetLastOnline(lastOnline))
		end
	end

	if button.summonButton:IsShown() then
		button.gameIcon:SetPoint("TOPRIGHT", -50, -2)
	else
		button.gameIcon:SetPoint("TOPRIGHT", -21, -2)
	end

	if not button.isUpdateHooked then
		button:HookScript("OnUpdate", function(self, elapsed)
			if button.gameIcon:GetTexture() == MediaIconPath.."GameIcons\\Bnet" then
				AnimateTexCoords(self.gameIcon, 512, 256, 64, 64, 25, elapsed, 0.02)
			end
		end)
		button.isUpdateHooked = true
	end

	if nameText then
		button.name:SetText(nameText)
		button.name:SetTextColor(nameColor.r, nameColor.g, nameColor.b)
		button.info:SetText(infoText)
		button.info:SetTextColor(unpack(Cooperate and {1, .96, .45} or {.49, .52, .54}))
		button.name:SetFont(C["Media"].Font, C["Media"].FontSize, "")
		button.info:SetFont(C["Media"].Font, 11, "")
	end
end

function Module:OnInitialize()
	if C["Misc"].EnhancedFriends ~= true then
		return
	end

	self:SecureHook("FriendsFrame_UpdateFriendButton", "UpdateFriends")
end
