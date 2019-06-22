local A, L = ...
local name, title, notes, loadable, reason, security, newVersion = GetAddOnInfo(A)
LightUIDB = {}

local LightUI=CreateFrame("Frame")
LightUI:RegisterEvent("PLAYER_LOGIN")
LightUI:SetScript("OnEvent", function(self, event)

print("Welcome to |cfff58cbaLight|r|cff009cffUI|r use |CFFFE8A0E/LightUI|r for Options.")

--SavedVariables Defaults
local defaults = {
	A_SMARTKITTY = true,
	A_UNITFRAMES = false,
	A_PARTYFRAMES = true,
	A_CLASSCOLORS = true,
	A_CASTBARS = true,
	A_VIEWPORT = false,
	A_HOTKEYS = true,
	A_MACROS = true,
	A_FONTS = false,
	A_GRYPHONES = true,
	A_DARKFRAMES = true,
	A_STATS = true,
	A_CHAT = true,
	A_RANGE = true,
	A_SHORTBAR = true,
	A_TOOLTIP = false,
	A_TABBINDER = false,
	A_SAFEQUEUE = true,
	A_HOVERBIND = false,
	A_ITEMLEVEL = true,
	A_INCOMBAT = false,
	A_FRIENDLIST = true,
	A_CHARLINKS = false,
	A_AUTOREP = true,
	A_ORDERHALLBAR = false,
	A_TALKINGHEAD = false,
	A_KEYPRESS = false,
	A_SKINS = false,
	A_EASYDELETE = false,
	A_PARTYBUFFS = false,
	A_TEXTURES = true,
	A_INVISBAGS = false,

	FONTS = {
		NORMAL = "Interface\\AddOns\\" .. A .. "\\media\\fonts\\FRIZQT__.TTF"
	},
	UNITFRAMES = {
		ACTIV = true,
		SIZE = 1,
		LBUFF = 27,
		SBUFF = 25,
		COLOR = true,
		CLASSCOLOR = true,
		HIDEBACK = true,
		HIDESTUFF = true,
	},
	PLAYER = {
		POINT = "CENTER",
		PARENT = "UIParent",
		RELPOINT = "CENTER",
		X = -290,
		Y = -180,
	},
	TARGET = {
		POINT = "CENTER",
		PARENT = "UIParent",
		RELPOINT = "CENTER",
		X = 290,
		Y = -180,
	},
	PLAYERCASTBAR = {
		POINT = "CENTER",
		PARENT = "UIParent",
		RELPOINT = "CENTER",
		X = 0,
		Y = -160,
		TIMER = true,
	},
	TARGETCASTBAR = {
		POINT = "CENTER",
		PARENT = "UIParent",
		RELPOINT = "CENTER",
		X = 0,
		Y = -45,
		TIMER = true,
	},
	FOCUSCASTBAR = {
		POINT = "CENTER",
		PARENT = "UIParent",
		RELPOINT = "CENTER",
		X = 0,
		Y = 0,
	},
	TOOLTIP = {
		X = -100,
		Y = 250,
	},
	MINIMAP = {
		OLDSYMBOL = false,
		HIDEGARNI = true,
		POINT = "BOTTOM",
		PARENT = "MainMenuBarHolderFrame",
		RELPOINT = "BOTTOM",
		X = 0,
		Y = -4,
	},
	STATS = {
		ACTIV = true,
		POINT = "TOPRIGHT",
		PARENT = "UIParent",
		RELPOINT = "TOPRIGHT",
		X = -320,
		Y = -4,
		SIZE = 13,
		COLOR = true,
		CLOCK = false,
	},
	VIEWPORT = {
		bottom = 170,
		top = 20,
		left = 0,
		right = 0,
		backround = "Interface\\ChatFrame\\ChatFrameBackground", --Set a custom backround!
		color = { 0, 0, 0 , 1 } --adjust the color (DO NOT CHANGE THE 1 ON THE END)
	},
	SKINS = {
		LITEBAG = true,
	},

	--LORTI
	textures = {
		normal = "Interface\\AddOns\\" .. A .. "\\media\\core\\gloss",
		flash = "Interface\\AddOns\\" .. A .. "\\media\\core\\flash",
		hover = "Interface\\AddOns\\" .. A .. "\\media\\core\\hover",
		pushed = "Interface\\AddOns\\" .. A .. "\\media\\core\\pushed",
		checked = "Interface\\AddOns\\" .. A .. "\\media\\core\\checked",
		equipped = "Interface\\AddOns\\" .. A .. "\\media\\core\\gloss_grey",
		buttonback = "Interface\\AddOns\\" .. A .. "\\media\\core\\button_background",
		buttonbackflat = "Interface\\AddOns\\" .. A .. "\\media\\core\\button_background_flat",
		outer_shadow = "Interface\\AddOns\\" .. A .. "\\media\\core\\outer_shadow"
	},
	background = {
		showbg = true, --show an background image?
		showshadow = true, --show an outer shadow?
		useflatbackground = false, --true uses plain flat color instead
		backgroundcolor = {r = 0.2, g = 0.2, b = 0.2, a = 0.3},
		shadowcolor = {r = 0, g = 0, b = 0, a = 0.9},
		classcolored = false,
		inset = 5
	},
	color = {
		maincolor = {r = 0.37, g = 0.3, b = 0.3},
		normal = {r = 0.37, g = 0.3, b = 0.3},
		equipped = {r = 0.1, g = 0.5, b = 0.1},
		classcolored = false
	},
	hotkeys = {
		show = false,
		fontsize = 12,
		pos1 = {a1 = "TOPRIGHT", x = 0, y = 0},
		pos2 = {a1 = "TOPLEFT", x = 0, y = 0} --important! two points are needed to make the hotkeyname be inside of the button
	},
	macroname = {
		show = false,
		fontsize = 12,
		pos1 = {a1 = "BOTTOMLEFT", x = 0, y = 0},
		pos2 = {a1 = "BOTTOMRIGHT", x = 0, y = 0} --important! two points are needed to make the macroname be inside of the button
	},
	itemcount = {
		show = true,
		fontsize = 12,
		pos1 = {a1 = "BOTTOMRIGHT", x = 0, y = 0}
	},
	cooldown = {
		spacing = 0
	},
	adjustOneletterAbbrev = true,
	consolidatedTooltipScale = 1.2,
	combineBuffsAndDebuffs = false,
	buffFrame = {
		pos = {a1 = "TOPRIGHT", af = "UIParent", a2 = "TOPRIGHT", x = -8, y = -24},
		gap = 30, --gap between buff and debuff rows
		userplaced = true, --want to place the bar somewhere else?
		rowSpacing = 10,
		colSpacing = 7,
		buttonsPerRow = 10,
		button = {
		  size = 32
		},
		icon = {
		  padding = -2
		},
		border = {
		  texture = "Interface\\AddOns\\" .. A .. "\\media\\core\\gloss",
		  color = {r = 0.4, g = 0.35, b = 0.35},
		  classcolored = false
		},
		background = {
		  show = true, --show backdrop
		  edgeFile = "Interface\\AddOns\\" .. A .. "\\media\\core\\outer_shadow",
		  color = {r = 0, g = 0, b = 0, a = 0.9},
		  classcolored = false,
		  inset = 6,
		  padding = 4
		},
		duration = {
		  font = STANDARD_TEXT_FONT,
		  size = 12,
		  pos = {a1 = "BOTTOM", x = 0, y = 0}
		},
		count = {
		  font = STANDARD_TEXT_FONT,
		  size = 11,
		  pos = {a1 = "TOPRIGHT", x = 0, y = 0}
		}
	},
	debuffFrame = {
		pos = {a1 = "TOPRIGHT", af = "UIParent", a2 = "TOPRIGHT", x = -8, y = -112},
		gap = 10, --gap between buff and debuff rows
		userplaced = true, --want to place the bar somewhere else?
		rowSpacing = 10,
		colSpacing = 7,
		buttonsPerRow = 10,
		button = {
		  size = 34
		},
		icon = {
		  padding = -2
		},
		border = {
		  texture = "Interface\\AddOns\\" .. A .. "\\media\\core\\gloss",
		  color = {r = 0.4, g = 0.35, b = 0.35},
		  classcolored = false
		},
		background = {
		  show = true, --show backdrop
		  edgeFile = "Interface\\AddOns\\" .. A .. "\\media\\core\\outer_shadow",
		  color = {r = 0, g = 0, b = 0, a = 0.9},
		  classcolored = false,
		  inset = 6,
		  padding = 4
		},
		duration = {
		  font = STANDARD_TEXT_FONT,
		  size = 12,
		  pos = {a1 = "BOTTOM", x = 0, y = 0}
		},
		count = {
		  font = STANDARD_TEXT_FONT,
		  size = 11,
		  pos = {a1 = "TOPRIGHT", x = 0, y = 0}
		}
	}
}

--CopyDefaults
local function LightUICopyDefaults(src, dst)
	if type(src) ~= "table" then return {} end
	if type(dst) ~= "table" then dst = { } end
	for k, v in pairs(src) do
	if type(v) == "table" then
		dst[k] = LightUICopyDefaults(v, dst[k])
		elseif type(v) ~= type(dst[k]) then
		dst[k] = v
		end
	end
	return dst
end

LightUIDB = LightUICopyDefaults(defaults, LightUIDB)

if LightUIDB.A_DEFAULTS == nil then
	--Install
	StaticPopupDialogs["INSTALL"] = {
		text = "Welcome to LightUI thanks for using it.",
		button1 = "Install",
		button2 = "Skip",
		OnAccept = function()
			LightUIDB.A_DEFAULTS = true
			ReloadUI()
		end,
		OnCancel = function()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3
	}
	StaticPopup_Show("INSTALL")
end

end)

--LightUIConfigFrame
local function LightUICreateConfig()
	--FRAME
	local LightUIConfig = CreateFrame("Frame", "LightUIConfig", UIParent, "ButtonFrameTemplate")
	SetPortraitToTexture(LightUIConfig.portrait, "Interface\\Icons\\Inv_helmet_06")
	LightUIConfig:SetSize(450, 550)
	LightUIConfig:SetPoint("CENTER")
	LightUIConfig:SetClampedToScreen(true)
	LightUIConfig:EnableMouse(true)
	LightUIConfig:SetMovable(true)
	LightUIConfig:RegisterForDrag("LeftButton")
	LightUIConfig:SetScript("OnDragStart",function(self)self:StartMoving()end)
	LightUIConfig:SetScript("OnDragStop",function(self)self:StopMovingOrSizing()end)
	LightUIConfig:Hide()

	local LightUIConfigTitle = LightUIConfig:CreateFontString(nil, LightUIConfig, "GameFontNormalLarge")
	LightUIConfigTitle:SetPoint("TOP", 0, -32)
	LightUIConfigTitle:SetText(notes .." Config ")

	--COLOR
	for i, v in pairs(
		{
		LightUIConfigBg,
		LightUIConfigTitleBg
		}
		) do
		v:SetVertexColor(.40, .40, .40)
	end

	for i, v in pairs(
		{
		LightUIConfigPortraitFrame,
		LightUIConfig.NineSlice.TopEdge,
		LightUIConfig.NineSlice.BottomEdge,
		LightUIConfig.NineSlice.RightEdge,
		LightUIConfig.NineSlice.LeftEdge,
		LightUIConfig.NineSlice.TopLeftCorner,
		LightUIConfig.NineSlice.BottomLeftCorner,
		LightUIConfig.NineSlice.TopRightCorner,
		LightUIConfig.NineSlice.BottomRightCorner,
		}
		) do
		v:SetVertexColor(.30, .30, .30)
	end
end
LightUICreateConfig()

--LightUI SHOW
local function LightUICONFIGSHOW()
	--Backdrop
	local backdrop = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
	}

	--POPUPS
	local function RESET()
		StaticPopupDialogs["RESET"] = {
			text = "Do you want reset Light UI ?",
			button1 = "Close",
			button2 = "Reset UI",
			OnAccept = function()
				LightUICONFIGSHOW()
			end,
			OnCancel = function()
				LightUIDB = nil
				ReloadUI()
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 3
		}
		StaticPopup_Show("RESET")
	end

	--FAQ
	--[[
	local function FAQ()
		print("|CFFFF0303How can i open the Minimap menu ?|R")
		print("|CFF20C000press middle mouse button|R")
	end
	--]]

	--LightUI BUTTONS
	local function LightUICreateBTN(text,point1,anchor,point2,pos1,pos2,width,height)
		LightUIBTN = CreateFrame("Button", nil, LightUIConfig, "UIPanelButtonTemplate")
		LightUIBTN:SetPoint(point1, anchor, point2, pos1, pos2)
		LightUIBTN:SetWidth(width)
		LightUIBTN:SetHeight(height)
		LightUIBTN:SetText(text)
	end

	--LightUI TEXT
	local function LightUICreateTXT(text,anchor,point,pos1,pos2, ...)
		LightUITXT = LightUIConfig:CreateFontString(nil, LightUIConfig, "GameFontNormalLarge")
		LightUITXT:SetPoint(point, anchor, pos1, pos2)
		LightUITXT:SetText(text)
	end

	--LightUI CHECKBOX
	local function LightUICreateCB(name,anchor,tooltip,db, ...)
		LightUICheckbox = CreateFrame("CheckButton", nil , LightUIConfig, "OptionsBaseCheckButtonTemplate")
		LightUICheckbox:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -5)

		LightUICheckbox:SetScript(
			"OnClick",
			function(frame)
				local tick = frame:GetChecked()
				LightUIDB[db] = tick
				if tick then
					DEFAULT_CHAT_FRAME:AddMessage(name .. " Enabled", 0, 1, 0)
					LightUIDB[db] = true
				else
					DEFAULT_CHAT_FRAME:AddMessage(name .. " Disabled", 1, 0, 0)
					LightUIDB[db] = false
				end
			end
		)
		LightUICheckbox:SetScript(
			"OnShow",
			function(frame)
				frame:SetChecked(LightUIDB[db])
			end
		)

		LightUICheckbox:SetScript(
			"OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
				GameTooltip:AddLine(tooltip, 248, 248, 255)
				GameTooltip:Show()
			end
		)
		LightUICheckbox:SetScript("OnLeave", GameTooltip_Hide)

		text = LightUIConfig:CreateFontString(nil, LightUIConfig, "GameFontHighlight")
		text:SetPoint("LEFT", LightUICheckbox, "RIGHT", 0, 1)
		text:SetText(name)

	end

	--[[
	local function showColorPicker(callback)
		ColorPickerFrame:SetColorRGB(LightUIDB.color.r,LightUIDB.color.g,LightUIDB.color.b)
		ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a
		ColorPickerFrame.previousValues = {LightUIDB.color.r,LightUIDB.color.g,LightUIDB.color.b,LightUIDB.color.a}
		ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = LightUIDB.color.r, LightUIDB.color.g, LightUIDB.color.b
		ColorPickerFrame:Hide() -- Need to run the OnShow handler.
		ColorPickerFrame:Show()
	end
	--]]

	--BUTTONS
	LightUICreateBTN("Save & Reload","BOTTOMLEFT",LightUIConfig,"BOTTOMLEFT",16,35,100,25)
	LightUIBTN:SetScript(
		"OnClick",
		function(self, button, down)
			ReloadUI()
		end
	)

	LightUICreateBTN("Reset","BOTTOMLEFT",LightUIConfig,"BOTTOMLEFT",120,35,100,25)
	LightUIBTN:SetScript(
		"OnClick",
		function(self, button, down)
			LightUIConfig:Hide()
			RESET()
		end
	)

	--[[
	LightUICreateBTN("FAQ","BOTTOMLEFT",LightUIConfig,"BOTTOMLEFT",225,35,40,25)
	LightUIBTN:SetScript(
		"OnClick",
		function(self, button, down)
			FAQ()
		end
	)
	--]]

	LightUICreateBTN("Edit","BOTTOMLEFT",LightUIConfig,"BOTTOMRIGHT",-116,35,100,25)
	LightUIBTN:SetScript(
		"OnClick",
		function(self, button, down)
			LightUIConfig:Hide()
			LightUIEDIT()
		end
	)

	--[[
	LightUICreateBTN("UI Color","BOTTOMLEFT",LightUIConfig,"BOTTOMRIGHT",-116,65,100,25)
	LightUIBTN:SetScript(
		"OnClick",
		function(self, button, down)
			LightUIConfig:Hide()
			showColorPicker()
		end
	)
	--]]

	--UI
	LightUICreateTXT("Custom UI",LightUIConfig,"TOPLEFT",20,-75)

	--SPACE
	LightUICreateTXT("",LightUIConfig,"TOPLEFT",20,-100)

	LightUICreateCB("Unitframes",LightUITXT,"Custom UnitFrames","A_UNITFRAMES")
	LightUICreateCB("PartyFrames",LightUICheckbox,"Custom PartyFrames","A_PARTYFRAMES")
	LightUICreateCB("Castbars",LightUICheckbox,"Custom CastBars","A_CASTBARS")
	LightUICreateCB("Chat",LightUICheckbox,"Custom Chat","A_CHAT")
	LightUICreateCB("Tooltip",LightUICheckbox,"Custom Tooltips","A_TOOLTIP")

	--SPACE
	LightUICreateTXT("",LightUIConfig,"TOPLEFT",180,-100)

	LightUICreateCB("Keys",LightUITXT,"Show Keys on Actionbar","A_HOTKEYS")
	LightUICreateCB("Macros",LightUICheckbox,"Show Macros on Actionbar","A_MACROS")
	LightUICreateCB("Gryphones",LightUICheckbox,"Show Gryphones","A_GRYPHONES")
	LightUICreateCB("Dark Frames",LightUICheckbox,"Dark Interface","A_DARKFRAMES")
	LightUICreateCB("Friendlist",LightUICheckbox,"Friendlist Class Colors","A_FRIENDLIST")

	--SPACE
	LightUICreateTXT("",LightUITXT,"CENTER",150,0)

	LightUICreateCB("ShortBar",LightUITXT,"Short Actionbar","A_SHORTBAR")
	LightUICreateCB("Range",LightUICheckbox,"Actionbar Spellrange Color","A_RANGE")
	LightUICreateCB("Invismenu",LightUICheckbox,"Invisible Mainmenu","A_INVISBAGS")
	LightUICreateCB("Textures",LightUICheckbox,"Custom Textures","A_TEXTURES")
	LightUICreateCB("Fonts",LightUICheckbox,"Custom Fonts","A_FONTS")
	--END

	--MISC
	LightUICreateTXT("MISC",LightUIConfig,"TOPLEFT",20,-270)

	--SPACE
	LightUICreateTXT("",LightUIConfig,"TOPLEFT",20,-295)

	LightUICreateCB("Safequeue",LightUITXT,"Time left for Q accept","A_SAFEQUEUE")
	LightUICreateCB("SmartKitty",LightUICheckbox,"Action bar for display druid dps cycle","A_SMARTKITTY")
	LightUICreateCB("TabBinder",LightUICheckbox,"Binds the Tabkey to Player only in Arena","A_TABBINDER")
	LightUICreateCB("KeyPress",LightUICheckbox,"Keypress Effect on Actionbar","A_KEYPRESS")
	LightUICreateCB("Itemlevel",LightUICheckbox,"Item Level","A_ITEMLEVEL")

	--SPACE
	LightUICreateTXT("",LightUIConfig,"TOPLEFT",180,-295)

	LightUICreateCB("ShowViewport",LightUITXT,"Show top and bottom Viewports","A_VIEWPORT")
	LightUICreateCB("InCombat",LightUICheckbox,"Incombat Symbols on UnitFrames","A_INCOMBAT")
	LightUICreateCB("Charlinks",LightUICheckbox,"Charlinks on UnitFrame Menu","A_CHARLINKS")
	LightUICreateCB("HoverBind",LightUICheckbox,"/hb to bind Keys on Actionbar","A_HOVERBIND")
	LightUICreateCB("TalkingHead",LightUICheckbox,"Show Talking Head over Actionbar","A_TALKINGHEAD")

	--SPACE
	LightUICreateTXT("",LightUITXT,"CENTER",150,0)

	LightUICreateCB("PartyBuffs",LightUITXT,"Big Party Buffs","A_PARTYBUFFS")
	LightUICreateCB("FPS/MS",LightUICheckbox,"FPS/MS Frame","A_STATS")
	LightUICreateCB("AutoRep",LightUICheckbox,"Auto Repair","A_AUTOREP")
	LightUICreateCB("EasyDelete",LightUICheckbox,"Easy delete Items","A_EASYDELETE")
	LightUICreateCB("OrderhallBar",LightUICheckbox,"Show the Orderhallbar","A_ORDERHALLBAR")
	--END

	LightUIConfig:Show()
end

local activ = false
SlashCmdList["LightUI"] = function()
	if activ == false then
	LightUICONFIGSHOW()
	activ = true
	else
	LightUIConfig:Show()
	end
end
SLASH_LightUI1 = "/LightUI"
