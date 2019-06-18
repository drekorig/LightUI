--[[SUI SKINS v1.0]]

local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)

if not SUIDB.A_SKINS == true then return end	

if not IsAddOnLoaded("Blizzard_TalentUI") then
	LoadAddOn("Blizzard_TalentUI")
end
if not IsAddOnLoaded("Blizzard_GuildUI") then
	LoadAddOn("Blizzard_GuildUI")
	LoadAddOn("Blizzard_PVPUI")
end
if not IsAddOnLoaded("Blizzard_PVPUI") then
	LoadAddOn("Blizzard_PVPUI")
end

--CharacterFrame
for i, v in pairs(
	{
		CharacterFramePortraitFrame,
		CharacterFrameTopRightCorner,
		CharacterFrameTopLeftCorner,
		CharacterFrameBotRightCorner,
		CharacterFrameBotLeftCorner,
		CharacterFrameRightBorder,
		CharacterFrameLeftBorder,
		CharacterFrameTopBorder,
		CharacterFrameBottomBorder,
		CharacterFrameInsetInsetBottomBorder,
		CharacterFrameInsetInsetBorderBottom,
		CharacterFrameInsetInsetBotLeftCorner,
		CharacterFrameInsetInsetBotRightCorner,
		CharacterFrameInsetInsetLeftBorder,
		CharacterFrameInsetInsetRightBorder,
		CharacterFrameInsetInsetTopBorder,
		CharacterFrameInsetInsetTopLeftCorner,
		CharacterFrameInsetInsetTopRightCorner,
		CharacterFrameInsetRightInsetBottomBorder,
		CharacterFrameInsetRightInsetBotLeftCorner,
		CharacterFrameInsetRightInsetBotRightCorner,
		CharacterFrameInsetRightInsetLeftBorder,
		CharacterFrameInsetRightInsetRightBorder,
		CharacterFrameInsetRightInsetTopBorder,
		CharacterFrameInsetRightInsetTopLeftCorner,
		CharacterFrameInsetRightInsetTopRightCorner
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		CharacterFrameBg,
		CharacterFrameTitleBg,
		CharacterFrameInsetBg,
		PaperDollInnerBorderBottomLeft,
		PaperDollInnerBorderBottomRight,
		PaperDollInnerBorderTopLeft,
		PaperDollInnerBorderTopRight,
		PaperDollInnerBorderTop,
		PaperDollInnerBorderBottom,
		PaperDollInnerBorderLeft,
		PaperDollInnerBorderRight
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

--LFG
for i, v in pairs(
	{
		PVEFramePortraitFrame,
		PVEFrameTopRightCorner,
		PVEFrameTopLeftCorner,
		PVEFrameBotRightCorner,
		PVEFrameBotLeftCorner,
		PVEFrameRightBorder,
		PVEFrameLeftBorder,
		PVEFrameTopBorder,
		PVEFrameBottomBorder,
		PVEFrameLeftInsetInsetBottomBorder,
		PVEFrameLeftInsetInsetBotLeftCorner,
		PVEFrameLeftInsetInsetBotRightCorner,
		PVEFrameLeftInsetInsetLeftBorder,
		PVEFrameLeftInsetInsetRightBorder,
		PVEFrameLeftInsetInsetTopBorder,
		PVEFrameLeftInsetInsetTopLeftCorner,
		PVEFrameLeftInsetInsetTopRightCorner,
		LFDParentFrameButtonBottomBorder,
		LFDParentFrameBtnCornerRight
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		LFDQueueFrameBackground,
		LFDParentFrameRoleBackground,
		PVEFrameBg,
		PVEFrameTitleBg,
		PVEFrameLeftInsetBg,
		LFDQueueFrameFindGroupButton_LeftSeparator,
		LFDQueueFrameFindGroupButton_RightSeparator,
		LFDParentFrameInsetInsetBottomBorder,
		LFDParentFrameInsetInsetTopBorder,
		LFDParentFrameInsetInsetRightBorder,
		LFDParentFrameInsetInsetLeftBorder,
		LFDParentFrameInsetInsetBotLeftCorner,
		LFDParentFrameInsetInsetBotRightCorner,
		LFDParentFrameInsetInsetTopLeftCorner,
		LFDParentFrameInsetInsetTopRightCorner,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderTop,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderBottom,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderLeft,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderRight,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderBottomLeft,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderBottomRight,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderTopLeft,
		LFGListFrame.SearchPanel.ResultsInset.InsetBorderTopRight,
		LFGListFrame.CategorySelection.Inset.InsetBorderTop,
		LFGListFrame.CategorySelection.Inset.InsetBorderBottom,
		LFGListFrame.CategorySelection.Inset.InsetBorderLeft,
		LFGListFrame.CategorySelection.Inset.InsetBorderRight,
		LFGListFrame.CategorySelection.Inset.InsetBorderBottomLeft,
		LFGListFrame.CategorySelection.Inset.InsetBorderBottomRight,
		LFGListFrame.CategorySelection.Inset.InsetBorderTopLeft,
		LFGListFrame.CategorySelection.Inset.InsetBorderTopRight
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

for i, v in pairs(
	{
		ConquestFrame.RatedBGTexture,
		ConquestFrame.ArenaTexture,
		ConquestFrame.RatedBGHeader,
		ConquestFrame.ArenaHeader,
		HonorFrame.BonusFrame.WorldBattlesTexture,
		ConquestFrameInsetBottomBorder,
		ConquestFrameInsetTopBorder,
		ConquestFrameInsetRightBorder,
		ConquestFrameInsetLeftBorder,
		ConquestFrameInsetBotLeftCorner,
		ConquestFrameInsetBotRightCorner,
		ConquestFrameInsetTopLeftCorner,
		ConquestFrameInsetTopRightCorner,
		ConquestFrame.Inset.InsetBorderBottom,
		ConquestFrame.Inset.InsetBorderTop,
		ConquestFrame.Inset.InsetBorderLeft,
		ConquestFrame.Inset.InsetBorderRight,
		ConquestFrame.Inset.InsetBorderTopLeft,
		ConquestFrame.Inset.InsetBorderTopRight,
		ConquestFrame.Inset.InsetBorderBottomLeft,
		ConquestFrame.Inset.InsetBorderBottomRight,
		HonorFrameInsetBottomBorder,
		HonorFrameInsetTopBorder,
		HonorFrameInsetRightBorder,
		HonorFrameInsetLeftBorder,
		HonorFrameInsetBotLeftCorner,
		HonorFrameInsetBotRightCorner,
		HonorFrameInsetTopLeftCorner,
		HonorFrameInsetTopRightCorner,
		HonorFrame.Inset.InsetBorderBottom,
		HonorFrame.Inset.InsetBorderTop,
		HonorFrame.Inset.InsetBorderLeft,
		HonorFrame.Inset.InsetBorderRight,
		HonorFrame.Inset.InsetBorderTopLeft,
		HonorFrame.Inset.InsetBorderTopRight,
		HonorFrame.Inset.InsetBorderBottomLeft,
		HonorFrame.Inset.InsetBorderBottomRight
	}
) do
	v:SetVertexColor(.45, .45, .45)
end

for i, v in pairs(
	{
		LFDQueueFrameRandomScrollFrameScrollBackgroundTopLeft,
		LFDQueueFrameRandomScrollFrameScrollBackgroundBottomRight,
		LFDQueueFrameRandomScrollFrameTop,
		LFGListSearchPanelScrollFrameScrollBarTop,
		LFGListSearchPanelScrollFrameScrollBarMiddle,
		LFGListSearchPanelScrollFrameScrollBarBottom
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

for i, v in pairs(
	{
		LFDQueueFrameRandomScrollFrameScrollBarScrollUpButton.Normal,
		LFDQueueFrameRandomScrollFrameScrollBarScrollUpButton.Disabled,
		LFDQueueFrameRandomScrollFrameScrollBarScrollUpButton.Highlight,
		LFDQueueFrameRandomScrollFrameScrollBarScrollUpButton.Pushed,
		LFDQueueFrameRandomScrollFrameScrollBarScrollDownButton.Normal,
		LFDQueueFrameRandomScrollFrameScrollBarScrollDownButton.Disabled,
		LFDQueueFrameRandomScrollFrameScrollBarScrollDownButton.Highlight,
		LFDQueueFrameRandomScrollFrameScrollBarScrollDownButton.Pushed,
		LFDQueueFrameRandomScrollFrameScrollBarThumbTexture,
		LFGListSearchPanelScrollFrameScrollBarScrollUpButton.Normal,
		LFGListSearchPanelScrollFrameScrollBarScrollUpButton.Disabled,
		LFGListSearchPanelScrollFrameScrollBarScrollUpButton.Highlight,
		LFGListSearchPanelScrollFrameScrollBarScrollUpButton.Pushed,
		LFGListSearchPanelScrollFrameScrollBarScrollDownButton.Normal,
		LFGListSearchPanelScrollFrameScrollBarScrollDownButton.Disabled,
		LFGListSearchPanelScrollFrameScrollBarScrollDownButton.Highlight,
		LFGListSearchPanelScrollFrameScrollBarScrollDownButton.Pushed,
		LFGListSearchPanelScrollFrameScrollBarThumbTexture
	}
) do
	v:SetVertexColor(.50, .50, .50)
end

--Talents
for i, v in pairs(
	{
		PlayerTalentFramePortraitFrame,
		PlayerTalentFrameTopRightCorner,
		PlayerTalentFrameBotLeftCorner,
		PlayerTalentFrameBotRightCorner,
		PlayerTalentFrameBottomBorder,
		PlayerTalentFrameBtnCornerLeft,
		PlayerTalentFrameBtnCornerRight,
		PlayerTalentFrameButtonBottomBorder,
		PlayerTalentFrameRightBorder,
		PlayerTalentFrameLeftBorder,
		PlayerTalentFrameTopBorder
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		PlayerTalentFrameBg,
		PlayerTalentFrameTitleBg,
		PlayerTalentFrameInsetInsetBottomBorder,
		PlayerTalentFrameInsetInsetBotLeftCorner,
		PlayerTalentFrameInsetInsetBotRightCorner,
		PlayerTalentFrameInsetInsetTopRightCorner,
		PlayerTalentFrameInsetInsetTopLeftCorner,
		PlayerTalentFrameInsetInsetLeftBorder,
		PlayerTalentFrameInsetInsetRightBorder,
		PlayerTalentFrameInsetInsetTopBorder
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

--SpellBook
for i, v in pairs(
	{
		SpellBookFramePortraitFrame,
		SpellBookFrameTopRightCorner,
		SpellBookFrameBotLeftCorner,
		SpellBookFrameBotRightCorner,
		SpellBookFrameBottomBorder,
		SpellBookFrameBtnCornerLeft,
		SpellBookFrameBtnCornerRight,
		SpellBookFrameButtonBottomBorder,
		SpellBookFrameRightBorder,
		SpellBookFrameLeftBorder,
		SpellBookFrameTopBorder
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		SpellBookFrameBg,
		SpellBookFrameTitleBg,
		SpellBookFrameInsetInsetBottomBorder,
		SpellBookFrameInsetInsetBotLeftCorner,
		SpellBookFrameInsetInsetBotRightCorner,
		SpellBookFrameInsetInsetTopRightCorner,
		SpellBookFrameInsetInsetTopLeftCorner,
		SpellBookFrameInsetInsetLeftBorder,
		SpellBookFrameInsetInsetRightBorder,
		SpellBookFrameInsetInsetTopBorder
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

--FriendList
for i, v in pairs(
	{
		FriendsFramePortraitFrame,
		FriendsFrameTopRightCorner,
		FriendsFrameBotLeftCorner,
		FriendsFrameBotRightCorner,
		FriendsFrameBottomBorder,
		FriendsFrameBtnCornerLeft,
		FriendsFrameBtnCornerRight,
		FriendsFrameButtonBottomBorder,
		FriendsFrameRightBorder,
		FriendsFrameLeftBorder,
		FriendsFrameTopBorder
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		FriendsFrameAddFriendButton.Middle,
		FriendsFrameAddFriendButton.Right,
		FriendsFrameAddFriendButton.Left,
		FriendsFrameSendMessageButton.Middle,
		FriendsFrameSendMessageButton.Right,
		FriendsFrameSendMessageButton.Left
	}
) do
	v:SetVertexColor(.05, .05, .05)
end

for i, v in pairs(
	{
		FriendsFrameBg,
		FriendsFrameTitleBg,
		FriendsFrameInsetInsetBottomBorder,
		FriendsFrameInsetInsetBotLeftCorner,
		FriendsFrameInsetInsetBotRightCorner,
		FriendsFrameInsetInsetTopRightCorner,
		FriendsFrameInsetInsetTopLeftCorner,
		FriendsFrameInsetInsetLeftBorder,
		FriendsFrameInsetInsetRightBorder,
		FriendsFrameInsetInsetTopBorder,
		FriendsFrameFriendsScrollFrameBottom,
		FriendsFrameFriendsScrollFrameMiddle,
		FriendsFrameFriendsScrollFrameTop,
		FriendsFrameStatusDropDownLeft,
		FriendsFrameStatusDropDownMiddle,
		FriendsFrameStatusDropDownRight,
		FriendsFrameStatusDropDownButtonNormalTexture
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

for i, v in pairs(
	{
		FriendsTabHeaderTab1Left,
		FriendsTabHeaderTab1Middle,
		FriendsTabHeaderTab1Right,
		FriendsTabHeaderTab1LeftDisabled,
		FriendsTabHeaderTab1MiddleDisabled,
		FriendsTabHeaderTab1RightDisabled,
		FriendsTabHeaderTab2Left,
		FriendsTabHeaderTab2Middle,
		FriendsTabHeaderTab2Right,
		FriendsTabHeaderTab2LeftDisabled,
		FriendsTabHeaderTab2MiddleDisabled,
		FriendsTabHeaderTab2RightDisabled,
		FriendsTabHeaderTab3Left,
		FriendsTabHeaderTab3Middle,
		FriendsTabHeaderTab3Right,
		FriendsTabHeaderTab3LeftDisabled,
		FriendsTabHeaderTab3MiddleDisabled,
		FriendsTabHeaderTab3RightDisabled,
		FriendsFrameFriendsScrollFrameScrollBarScrollUpButton.Normal,
		FriendsFrameFriendsScrollFrameScrollBarScrollUpButton.Disabled,
		FriendsFrameFriendsScrollFrameScrollBarScrollUpButton.Highlight,
		FriendsFrameFriendsScrollFrameScrollBarScrollUpButton.Pushed,
		FriendsFrameFriendsScrollFrameScrollBarScrollDownButton.Normal,
		FriendsFrameFriendsScrollFrameScrollBarScrollDownButton.Disabled,
		FriendsFrameFriendsScrollFrameScrollBarScrollDownButton.Highlight,
		FriendsFrameFriendsScrollFrameScrollBarScrollDownButton.Pushed,
		FriendsFrameFriendsScrollFrameScrollBarThumbTexture
	}
) do
	v:SetVertexColor(.50, .50, .50)
	FriendsTabHeaderRecruitAFriendButton.Icon:Hide()
end

--Map
for i, v in pairs(
	{
		WorldMapFramePortraitFrame,
		WorldMapFrameTopLeftCorner,
		WorldMapFrameTopRightCorner,
		WorldMapFrameBotLeftCorner,
		WorldMapFrameBotRightCorner,
		WorldMapFrameBottomBorder,
		WorldMapFrameBtnCornerLeft,
		WorldMapFrameBtnCornerRight,
		WorldMapFrameButtonBottomBorder,
		WorldMapFrameRightBorder,
		WorldMapFrameLeftBorder,
		WorldMapFrameTopBorder
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		WorldMapFrameBg,
		WorldMapFrameTitleBg,
		WorldMapFrame.BorderFrame.ButtonFrameEdge,
		--WorldMapFrameNavBar.InsetBorderBottom,
		--WorldMapFrameNavBar.InsetBorderBottomRight,
		--WorldMapFrameNavBar.InsetBorderBottomLeft,
		WorldMapFrameInsetTopBorder,
		QuestScrollFrameScrollBarTop,
		QuestScrollFrameScrollBarMiddle,
		QuestScrollFrameScrollBarBottom
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

for i, v in pairs(
	{
		QuestScrollFrameScrollBarScrollUpButton.Normal,
		QuestScrollFrameScrollBarScrollUpButton.Disabled,
		QuestScrollFrameScrollBarScrollUpButton.Highlight,
		QuestScrollFrameScrollBarScrollUpButton.Pushed,
		QuestScrollFrameScrollBarScrollDownButton.Normal,
		QuestScrollFrameScrollBarScrollDownButton.Disabled,
		QuestScrollFrameScrollBarScrollDownButton.Highlight,
		QuestScrollFrameScrollBarScrollDownButton.Pushed,
		QuestScrollFrameScrollBarThumbTexture
	}
) do
	v:SetVertexColor(.50, .50, .50)
end

--Guild
for i, v in pairs(
	{
		GuildFrameRightBorder,
		GuildFramePortraitFrame,
		GuildFrameTopLeftCorner,
		GuildFrameTopRightCorner,
		GuildFrameBotLeftCorner,
		GuildFrameBotRightCorner,
		GuildFrameBottomBorder,
		GuildFrameBtnCornerLeft,
		GuildFrameBtnCornerRight,
		GuildFrameButtonBottomBorder,
		GuildFrameRightBorder,
		GuildFrameLeftBorder,
		GuildFrameTopBorder
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		GuildFrameBg,
		GuildFrameTitleBg,
		GuildRosterViewDropdownButtonNormalTexture,
		GuildRosterViewDropdownButtonPushedTexture,
		GuildFrameInsetInsetBottomBorder,
		GuildFrameInsetInsetBotLeftCorner,
		GuildFrameInsetInsetBotRightCorner,
		GuildFrameInsetInsetTopRightCorner,
		GuildFrameInsetInsetTopLeftCorner,
		GuildFrameInsetInsetLeftBorder,
		GuildFrameInsetInsetRightBorder,
		GuildFrameInsetInsetTopBorder,
		GuildRosterContainerScrollBarTop,
		GuildRosterContainerScrollBarMiddle,
		GuildRosterContainerScrollBarBottom,
		GuildRewardsContainerScrollBarTop,
		GuildRewardsContainerScrollBarMiddle,
		GuildRewardsContainerScrollBarBottom,
		GuildRosterViewDropdownLeft,
		GuildRosterViewDropdownMiddle,
		GuildRosterViewDropdownRight,
		GuildRosterColumnButton1Left,
		GuildRosterColumnButton1Middle,
		GuildRosterColumnButton1Right,
		GuildRosterColumnButton2Left,
		GuildRosterColumnButton2Middle,
		GuildRosterColumnButton2Right,
		GuildRosterColumnButton3Left,
		GuildRosterColumnButton3Middle,
		GuildRosterColumnButton3Right,
		GuildRosterColumnButton4Left,
		GuildRosterColumnButton4Middle,
		GuildRosterColumnButton4Right
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

for i, v in pairs(
	{
		GuildNewsContainerScrollBarScrollUpButton.Normal,
		GuildNewsContainerScrollBarScrollUpButton.Disabled,
		GuildNewsContainerScrollBarScrollUpButton.Highlight,
		GuildNewsContainerScrollBarScrollUpButton.Pushed,
		GuildNewsContainerScrollBarScrollDownButton.Normal,
		GuildNewsContainerScrollBarScrollDownButton.Disabled,
		GuildNewsContainerScrollBarScrollDownButton.Highlight,
		GuildNewsContainerScrollBarScrollDownButton.Pushed,
		GuildNewsContainerScrollBarThumbTexture,
		GuildRosterContainerScrollBarScrollUpButton.Normal,
		GuildRosterContainerScrollBarScrollUpButton.Disabled,
		GuildRosterContainerScrollBarScrollUpButton.Highlight,
		GuildRosterContainerScrollBarScrollUpButton.Pushed,
		GuildRosterContainerScrollBarScrollDownButton.Normal,
		GuildRosterContainerScrollBarScrollDownButton.Disabled,
		GuildRosterContainerScrollBarScrollDownButton.Highlight,
		GuildRosterContainerScrollBarScrollDownButton.Pushed,
		GuildRosterContainerScrollBarThumbTexture,
		GuildRewardsContainerScrollBarScrollUpButton.Normal,
		GuildRewardsContainerScrollBarScrollUpButton.Disabled,
		GuildRewardsContainerScrollBarScrollUpButton.Highlight,
		GuildRewardsContainerScrollBarScrollUpButton.Pushed,
		GuildRewardsContainerScrollBarScrollDownButton.Normal,
		GuildRewardsContainerScrollBarScrollDownButton.Disabled,
		GuildRewardsContainerScrollBarScrollDownButton.Highlight,
		GuildRewardsContainerScrollBarScrollDownButton.Pushed,
		GuildRewardsContainerScrollBarThumbTexture,
		GuildFactionBarLeft,
		GuildFactionBarMiddle,
		GuildFactionBarRight
	}
) do
	v:SetVertexColor(.50, .50, .50)
end

--Merchant
for i, v in pairs(
	{
		MerchantFrameRightBorder,
		MerchantFramePortraitFrame,
		MerchantFrameTopLeftCorner,
		MerchantFrameTopRightCorner,
		MerchantFrameBotLeftCorner,
		MerchantFrameBotRightCorner,
		MerchantFrameBottomBorder,
		MerchantFrameBtnCornerLeft,
		MerchantFrameBtnCornerRight,
		MerchantFrameButtonBottomBorder,
		MerchantFrameRightBorder,
		MerchantFrameLeftBorder,
		MerchantFrameTopBorder
	}
) do
	v:SetVertexColor(.20, .20, .20)
end

for i, v in pairs(
	{
		MerchantFrameBg,
		MerchantFrameTitleBg,
		MerchantFrameInsetInsetBottomBorder,
		MerchantFrameInsetInsetBotLeftCorner,
		MerchantFrameInsetInsetBotRightCorner,
		MerchantFrameInsetInsetTopRightCorner,
		MerchantFrameInsetInsetTopLeftCorner,
		MerchantFrameInsetInsetLeftBorder,
		MerchantFrameInsetInsetRightBorder,
		MerchantFrameInsetInsetTopBorder,
		MerchantFrameBottomRightBorder,
		MerchantFrameBottomLeftBorder,
		MerchantBuyBackItemSlotTexture,
		MerchantBuyBackItemNameFrame
	}
) do
	v:SetVertexColor(.35, .35, .35)
	BuybackBG:SetVertexColor(.10, .10, .10)
end

--AV

--Journal

--ADDONS
--LiteBags
if IsAddOnLoaded("LiteBag") and SUIDB.SKINSLITEBAG == true then
	for i, v in pairs(
		{
			--Main
			LiteBagInventoryTopRightCorner,
			LiteBagInventoryPortraitFrame,
			LiteBagInventoryTopBorder,
			LiteBagInventoryInsetInsetTopLeftCorner,
			LiteBagInventoryInsetInsetTopRightCorner,
			LiteBagInventoryInsetInsetBotLeftCorner,
			LiteBagInventoryInsetInsetBotRightCorner,
			LiteBagInventoryInsetInsetTopBorder,
			LiteBagInventoryInsetInsetBottomBorder,
			LiteBagInventoryInsetInsetLeftBorder,
			LiteBagInventoryInsetInsetRightBorder,
			LiteBagInventoryButtonBottomBorder,
			LiteBagInventoryBottomBorder,
			LiteBagInventoryLeftBorder,
			LiteBagInventoryRightBorder,
			LiteBagInventoryTitleBG,
			--Tokens
			LiteBagInventoryTokenFrameBorderLeft,
			LiteBagInventoryTokenFrameBorderMiddle,
			LiteBagInventoryTokenFrameBorderRight,
			--Money
			LiteBagInventoryMoneyFrameBorderLeft,
			LiteBagInventoryMoneyFrameBorderMiddle,
			LiteBagInventoryMoneyFrameBorderRight
		}
	) do
		v:SetVertexColor(.20, .20, .20)
		LiteBagInventoryBtnCornerLeft:SetVertexColor(.25, .25, .25)
		LiteBagInventoryBtnCornerRight:SetVertexColor(.25, .25, .25)
	end
	for i, v in pairs(
		{
			LiteBagInventoryBg,
			LiteBagInventoryTitleBg
		}
	) do
		v:SetVertexColor(.35, .35, .35)
	end
end

end)
