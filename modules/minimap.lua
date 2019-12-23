local A, L = ...

local LightUI = CreateFrame("Frame")
LightUI:RegisterEvent("PLAYER_LOGIN")
LightUI:SetScript("OnEvent",function(self, event)
		if not (IsAddOnLoaded("SexyMap")) then
			if LightUIDB.A_DARKFRAMES == true then
				for i, v in pairs(
					{
						MiniMapMailBorder,
						QueueStatusMinimapButtonBorder,
						--select(1, TimeManagerClockButton:GetRegions())
					}
				) do
						v:SetVertexColor(.15, .15, .15)
				end
			end
			Minimap:SetMaskTexture("interface\\addons\\"..A.."\\media\\minimap\\mask")
			MinimapZoneText:SetPoint("CENTER", Minimap, 0, 80)
			MinimapZoneText:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
			MinimapZoneText:SetTextColor(0.8,0.8,0.6,1)

			if LightUIDB.MINIMAP.OLDSYMBOL == true then
				hooksecurefunc("GarrisonLandingPageMinimapButton_UpdateIcon",function(self)
					self:GetNormalTexture():SetTexture(nil)
					self:GetPushedTexture():SetTexture(nil)
					if not gb then
						gb = CreateFrame("Frame", nil, GarrisonLandingPageMinimapButton)
						gb:SetFrameLevel(GarrisonLandingPageMinimapButton:GetFrameLevel() - 1)
						gb:SetPoint("CENTER", 0, 0)
						gb:SetSize(36, 36)

						gb.icon = gb:CreateTexture(nil, "ARTWORK")
						gb.icon:SetPoint("CENTER", 0, 0)
						gb.icon:SetSize(36, 36)

						gb.border = CreateFrame("Frame", nil, gb)
						gb.border:SetFrameLevel(gb:GetFrameLevel() + 1)
						gb.border:SetAllPoints()

						gb.border.texture = gb.border:CreateTexture(nil, "ARTWORK")
						gb.border.texture:SetTexture("Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Ring")
						if LightUIDB.A_DARKFRAMES == true then
							gb.border.texture:SetVertexColor(.1, .1, .1)
						end
						gb.border.texture:SetPoint("CENTER", 1, -2)
						gb.border.texture:SetSize(45, 45)
					end
					if (C_Garrison.GetLandingPageGarrisonType() == 2) then
						if select(1, UnitFactionGroup("player")) == "Alliance" then
							SetPortraitToTexture(gb.icon, select(3, GetSpellInfo(61573)))
						elseif select(1, UnitFactionGroup("player")) == "Horde" then
							SetPortraitToTexture(gb.icon, select(3, GetSpellInfo(61574)))
						end
					else
						local t = CLASS_ICON_TCOORDS[select(2, UnitClass("player"))]
						gb.icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
						gb.icon:SetTexCoord(unpack(t))
					end
			end)
			end

			if LightUIDB.MINIMAP.HIDEGARNI == true then
        if GarrisonLandingPageMinimapButton then
				GarrisonLandingPageMinimapButton:UnregisterAllEvents()
        GarrisonLandingPageMinimapButton:ClearAllPoints()
        end
			end

			--Hide regions
			MinimapBackdrop:SetWidth(1)
			MinimapCluster:SetWidth(1)
			MinimapBorder:Hide()
			MinimapBorderTop:Hide()
			MinimapZoomIn:Hide()
			MinimapZoomOut:Hide()
			MiniMapWorldMapButton:Hide()
			GameTimeFrame:Hide()
			GameTimeFrame:UnregisterAllEvents()
      GameTimeFrame.Show = kill
      if MiniMapTracking then
			  MiniMapTracking:Hide()
			  MiniMapTracking.Show = kill
        MiniMapTracking:UnregisterAllEvents()
      end

			--Blizzard_TimeManager
			LoadAddOn("Blizzard_TimeManager")
			TimeManagerClockButton:GetRegions():Hide()
			--TimeManagerClockButton:ClearAllPoints()
			--TimeManagerClockButton:SetPoint("BOTTOM",0,0)
			TimeManagerClockTicker:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
			TimeManagerClockTicker:SetTextColor(0.8,0.8,0.6,1)

      if QueueStatusMinimapButton then
        QueueStatusMinimapButton:ClearAllPoints();
        QueueStatusMinimapButton:SetPoint("LEFT", Minimap, "LEFT", -22, 30);
      end
			-- BattlefieldMapFrame
			if not BattlefieldMapFrame then
				LoadAddOn("Blizzard_BattlefieldMapFrame")BattlefieldMap_LoadUI();
			end
			--BattlefieldMapFrame:SetScale(1.1)
			BattlefieldMapFrame.BorderFrame:Hide()

			if LightUIDB.A_SHORTBAR == true then
				Minimap:ClearAllPoints()
				Minimap:SetPoint(LightUIDB.MINIMAP.POINT, LightUIDB.MINIMAP.PARENT, LightUIDB.MINIMAP.RELPOINT, LightUIDB.MINIMAP.X , LightUIDB.MINIMAP.Y);
				Minimap:SetWidth(160)
				Minimap:SetHeight(160)
			end

			Minimap:EnableMouseWheel(true)
			Minimap:SetScript(
				"OnMouseWheel",
				function(self, z)
					local c = Minimap:GetZoom()
					if (z > 0 and c < 5) then
						Minimap:SetZoom(c + 1)
					elseif (z < 0 and c > 0) then
						Minimap:SetZoom(c - 1)
					end
				end
			)
			Minimap:SetScript(
				"OnMouseUp",
				function(self, btn)
					if btn == "RightButton" then
						_G.GameTimeFrame:Click()
					elseif btn == "MiddleButton" then
						_G.ToggleDropDownMenu(1, nil, _G.MiniMapTrackingDropDown, self)
					else
						_G.Minimap_OnClick(self)
					end
				end
			)
		end
	end
)