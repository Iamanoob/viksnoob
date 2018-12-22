﻿local T, C, L, _ = unpack(select(2, ...))

local ChangeLog = CreateFrame("frame")
local ChangeLogData = {
	"Changes:",
		"Update 8.7",
		"• Fixed PowerType check for combopoints",
		"• Fixed combo points message for CombatText.",
		"• Updated location coords - Less memory leak this way",
		"• Hiding some more panels during Pet battle",
		"• New: Icy-Vein Stats Priority InfoPanel Above CharacterFrame",
		"• New Option to control some of the skin look/skada",
		"• Azerite skin updated",
		"• Garrison skin updated",
		"• Panels linked to Details hide correctly",
		"• Updated MagePortals with new portals/teleport",
		"• New: War Mode and phase indicator added to frames",
		"• MapInfo Updated",
		"• Island Expeditions skin added",
		"• AutoAccept Updated",
		"• Added Azerite texture for Bags",
		"• Fixed color for available quest",
		"• + Many more minor fixes and skin/libs updates",
		"",
		--"• ",
	--" ",
	"FIRST PATREON: joelsoul - Huge Thanks for the support",
		"",
	"NOTE:",
		"NEW Donate button added",
		"NEW Patreon button added",
		"6 years with hundreds of hours on coding, ",
		"and countless hours with support for free!",
		"BE NR 2 TO DONATE :)",
		"",
	"PATREON's: joelsoul",
}

--// TODO LIST
-- Make a global function for Cords

local function ModifiedString(string)
	local count = string.find(string, ":")
	local newString = string
	
	if count then
		local prefix = string.sub(string, 0, count)
		local suffix = string.sub(string, count + 1)
		local subHeader = string.find(string, "•")
		
		if subHeader then newString = tostring("|cFFFFFF00".. prefix .. "|r" .. suffix) else newString = tostring("|cffC41F3B" .. prefix .. "|r" .. suffix) end
	end

	for pattern in gmatch(string, "('.*')") do newString = newString:gsub(pattern, "|cFFFF8800" .. pattern:gsub("'", "") .. "|r") end
	return newString
end

local function GetChangeLogInfo(i)
	for line, info in pairs(ChangeLogData) do
		if line == i then return info end
	end
end

_G.StaticPopupDialogs["BUGREPORT"] = {
	text = "Bugreporting for ViksUI",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) 
		self.editBox:SetFocus()
		self.editBox:SetText("http://www.wowinterface.com/downloads/info21462-ViksUI.html#comments")
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

_G.StaticPopupDialogs["TWITCH"] = {
	text = "Twitch channel to ViksUI",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) 
		self.editBox:SetFocus()
		self.editBox:SetText("https://www.twitch.tv/vikingpower")
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

_G.StaticPopupDialogs["DISCORD"] = {
	text = "Discord channel to ViksUI",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) 
		self.editBox:SetFocus()
		self.editBox:SetText("https://discord.gg/pDEnZSV")
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

_G.StaticPopupDialogs["DONATE"] = {
	text = "Support my work by donating on Paypal",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) 
		self.editBox:SetFocus()
		self.editBox:SetText("https://www.paypal.me/Tryllemann")
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

_G.StaticPopupDialogs["PATRON"] = {
	text = "Support my work on Patreon",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) 
		self.editBox:SetFocus()
		self.editBox:SetText("https://www.patreon.com/user?u=9534738")
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

function ChangeLog:CreateChangelog()
	local frame = CreateFrame("Frame", "ViksUIChangeLog", UIParent)
	frame:SetPoint("TOP",0,-50)
	frame:SetSize(445, 550)
	frame:SetTemplate("Transparent")
	frame:SetFrameLevel(4)
	
	local icon = CreateFrame("Frame", nil, frame)
	icon:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 3)
	icon:SetSize(20, 20)
	icon:SetTemplate("Transparent")
	icon.bg = icon:CreateTexture(nil, "ARTWORK")
	icon.bg:SetPoint("TOPLEFT", 2, -2)
	icon.bg:SetPoint("BOTTOMRIGHT", -2, 2)
	icon.bg:SetTexture([[Interface\AddOns\ViksUI\Media\textures\viksicon.blp]])
	
	local title = CreateFrame("Frame", nil, frame)
	title:SetPoint("LEFT", icon, "RIGHT", 3, 0)
	title:SetSize(422, 20)
	title:SetTemplate("Transparent")
	title.text = title:CreateFontString(nil, "OVERLAY")
	title.text:SetPoint("CENTER", title, 0, -1)
	title.text:SetFont(C["media"].normal_font, 15)
	title.text:SetText("|cffC41F3BViksUI|r - ChangeLog " .. T.version)
	
	T["CreateBtn"]("close", frame, 65, 19, "Close Changelog", "Close", frame)
	close:SetPoint("BOTTOMRIGHT", frame, -5, 5)
	close:SetScript("OnClick", function(self) frame:Hide() end)
	
	T["CreateBtn"]("bReport", frame, 65, 19, "Bugreport", "Bugreport", frame)
	bReport:SetPoint("BOTTOMLEFT", frame, 5, 5)
	bReport:SetScript("OnClick", function(self) StaticPopup_Show("BUGREPORT") end)
	
	T["CreateBtn"]("bTwitch", frame, 65, 19, "Twitch", "Twitch", frame)
	bTwitch:SetPoint("BOTTOMLEFT", bReport, "BOTTOMRIGHT", 5, 0)
	bTwitch:SetScript("OnClick", function(self) StaticPopup_Show("TWITCH") end)
	
	T["CreateBtn"]("bDiscord", frame, 65, 19, "Discord", "Discord", frame)
	bDiscord:SetPoint("BOTTOMLEFT", bTwitch, "BOTTOMRIGHT", 5, 0)
	bDiscord:SetScript("OnClick", function(self) StaticPopup_Show("DISCORD") end)
	
	T["CreateBtn"]("bDonate", frame, 65, 19, "Donate", "Donate", frame)
	bDonate:SetPoint("BOTTOMLEFT", bDiscord, "BOTTOMRIGHT", 5, 0)
	bDonate:SetScript("OnClick", function(self) StaticPopup_Show("DONATE") end)
	
	T["CreateBtn"]("bPatreon", frame, 65, 19, "Patreon", "Patreon", frame)
	bPatreon:SetPoint("BOTTOMLEFT", bDonate, "BOTTOMRIGHT", 5, 0)
	bPatreon:SetScript("OnClick", function(self) StaticPopup_Show("PATRON") end)
	
	local offset = 4
	for i = 1, #ChangeLogData do
		local button = CreateFrame("Frame", "Button"..i, frame)
		button:SetSize(375, 16)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -offset)
		
		if i <= #ChangeLogData then
			local string = ModifiedString(GetChangeLogInfo(i))
			
			button.Text = button:CreateFontString(nil, "OVERLAY")
			button.Text:SetFont(C["media"].normal_font, 11)
			button.Text:SetText(string)
			button.Text:SetPoint("LEFT", 0, 0)
		end
		offset = offset + 16
	end
end

function ViksUI_ToggleChangeLog()
	ChangeLog:CreateChangelog()
end

if SavedOptionsPerChar == nil then SavedOptionsPerChar = {} end

function ChangeLog:OnCheckVersion(self)
	if not SavedOptions["version"] or (SavedOptions["version"] and SavedOptions["version"] ~= T.version) then
		SavedOptions["version"] = T.version
		ChangeLog:CreateChangelog()
	end
end

ChangeLog:RegisterEvent("ADDON_LOADED")
ChangeLog:RegisterEvent("PLAYER_ENTERING_WORLD")
ChangeLog:SetScript("OnEvent", function(self, event, ...)
	if SavedOptions == nil then SavedOptions = {} end
	ChangeLog:OnCheckVersion()
end)

SLASH_CHANGELOG1 = "/changelog"
SlashCmdList.CHANGELOG = function() ViksUI_ToggleChangeLog() end