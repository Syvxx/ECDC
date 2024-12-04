local category, layout
local ADDON_NAME, addon = ...
local L

function ECDC_OnLoad(self)
	L = addon.L	

	ECDC_ToolTips = {};
	ECDC_ToolTipDetails = {};
	ECDC_ErrCountdown = 0;
	ECDC_UsedSkills = {};
	ECDC_UpdateInterval = 0.1;
	ECDC_TimeSinceLastUpdate = 0;

	ECDC_LoadSkills();
	ECDC_Activate(self);	
end

function ECDC_ToggleStack(setPos)
	if (not ECDC_Pos or ECDC_Pos == nil) then
		ECDC_Pos = "Hori"
	end
	
	if (not ECDC_Padding or ECDC_Padding == nil) then
		ECDC_Padding = 0;
	end
	local pa = ECDC_Padding;
	
	if (setPos == "Verti") and (ECDC_Row == 1 or nil) then
		ECDC_Pos = "Verti";
		ECDC_Tex1:ClearAllPoints(); ECDC_Tex1:SetPoint("TOP", "ECDC", "BOTTOM", 0, 3);
		ECDC_Tex2:ClearAllPoints(); ECDC_Tex2:SetPoint("TOP", "ECDC_Tex1", "BOTTOM", 0, -pa);
		ECDC_Tex3:ClearAllPoints(); ECDC_Tex3:SetPoint("TOP", "ECDC_Tex2", "BOTTOM", 0, -pa);
		ECDC_Tex4:ClearAllPoints(); ECDC_Tex4:SetPoint("TOP", "ECDC_Tex3", "BOTTOM", 0, -pa);
		ECDC_Tex5:ClearAllPoints(); ECDC_Tex5:SetPoint("TOP", "ECDC_Tex4", "BOTTOM", 0, -pa);
		ECDC_Tex6:ClearAllPoints(); ECDC_Tex6:SetPoint("TOP", "ECDC_Tex5", "BOTTOM", 0, -pa);
		ECDC_Tex7:ClearAllPoints(); ECDC_Tex7:SetPoint("TOP", "ECDC_Tex6", "BOTTOM", 0, -pa);
		ECDC_Tex8:ClearAllPoints(); ECDC_Tex8:SetPoint("TOP", "ECDC_Tex7", "BOTTOM", 0, -pa);
		ECDC_Tex9:ClearAllPoints(); ECDC_Tex9:SetPoint("TOP", "ECDC_Tex8", "BOTTOM", 0, -pa);
		ECDC_Tex10:ClearAllPoints(); ECDC_Tex10:SetPoint("TOP", "ECDC_Tex9", "BOTTOM", 0, -pa);
	elseif (setPos == "Verti") and (ECDC_Row == 2) then
		ECDC_Pos = "Verti";
		ECDC_Tex1:ClearAllPoints(); ECDC_Tex1:SetPoint("TOP", "ECDC", "BOTTOM", 0, 3);
		ECDC_Tex2:ClearAllPoints(); ECDC_Tex2:SetPoint("TOP", "ECDC_Tex1", "BOTTOM", 0, -pa);
		ECDC_Tex3:ClearAllPoints(); ECDC_Tex3:SetPoint("TOP", "ECDC_Tex2", "BOTTOM", 0, -pa);
		ECDC_Tex4:ClearAllPoints(); ECDC_Tex4:SetPoint("TOP", "ECDC_Tex3", "BOTTOM", 0, -pa);
		ECDC_Tex5:ClearAllPoints(); ECDC_Tex5:SetPoint("TOP", "ECDC_Tex4", "BOTTOM", 0, -pa);
		
		ECDC_Tex6:ClearAllPoints(); ECDC_Tex6:SetPoint("LEFT", "ECDC_Tex1", "RIGHT", pa, 0); -- new row
		ECDC_Tex7:ClearAllPoints(); ECDC_Tex7:SetPoint("TOP", "ECDC_Tex6", "BOTTOM", 0, -pa);
		ECDC_Tex8:ClearAllPoints(); ECDC_Tex8:SetPoint("TOP", "ECDC_Tex7", "BOTTOM", 0, -pa);
		ECDC_Tex9:ClearAllPoints(); ECDC_Tex9:SetPoint("TOP", "ECDC_Tex8", "BOTTOM", 0, -pa);
		ECDC_Tex10:ClearAllPoints(); ECDC_Tex10:SetPoint("TOP", "ECDC_Tex9", "BOTTOM", 0, -pa);
	elseif (setPos == "Hori") and (ECDC_Row == 1 or nil) then
		ECDC_Pos = "Hori";
		ECDC_Tex1:ClearAllPoints(); ECDC_Tex1:SetPoint("LEFT", "ECDC", "RIGHT", 0, 0);
		ECDC_Tex2:ClearAllPoints(); ECDC_Tex2:SetPoint("LEFT", "ECDC_Tex1", "RIGHT", pa, 0);
		ECDC_Tex3:ClearAllPoints(); ECDC_Tex3:SetPoint("LEFT", "ECDC_Tex2", "RIGHT", pa, 0);
		ECDC_Tex4:ClearAllPoints(); ECDC_Tex4:SetPoint("LEFT", "ECDC_Tex3", "RIGHT", pa, 0);
		ECDC_Tex5:ClearAllPoints(); ECDC_Tex5:SetPoint("LEFT", "ECDC_Tex4", "RIGHT", pa, 0);
		ECDC_Tex6:ClearAllPoints(); ECDC_Tex6:SetPoint("LEFT", "ECDC_Tex5", "RIGHT", pa, 0);
		ECDC_Tex7:ClearAllPoints(); ECDC_Tex7:SetPoint("LEFT", "ECDC_Tex6", "RIGHT", pa, 0);
		ECDC_Tex8:ClearAllPoints(); ECDC_Tex8:SetPoint("LEFT", "ECDC_Tex7", "RIGHT", pa, 0);
		ECDC_Tex9:ClearAllPoints(); ECDC_Tex9:SetPoint("LEFT", "ECDC_Tex8", "RIGHT", pa, 0);
		ECDC_Tex10:ClearAllPoints(); ECDC_Tex10:SetPoint("LEFT", "ECDC_Tex9", "RIGHT", pa, 0);
	elseif (setPos == "Hori") and (ECDC_Row == 2) then
		ECDC_Pos = "Hori";
		ECDC_Tex1:ClearAllPoints(); ECDC_Tex1:SetPoint("LEFT", "ECDC", "RIGHT", 0, 0);
		ECDC_Tex2:ClearAllPoints(); ECDC_Tex2:SetPoint("LEFT", "ECDC_Tex1", "RIGHT", pa, 0);
		ECDC_Tex3:ClearAllPoints(); ECDC_Tex3:SetPoint("LEFT", "ECDC_Tex2", "RIGHT", pa, 0);
		ECDC_Tex4:ClearAllPoints(); ECDC_Tex4:SetPoint("LEFT", "ECDC_Tex3", "RIGHT", pa, 0);
		ECDC_Tex5:ClearAllPoints(); ECDC_Tex5:SetPoint("LEFT", "ECDC_Tex4", "RIGHT", pa, 0);
		
		ECDC_Tex6:ClearAllPoints(); ECDC_Tex6:SetPoint("TOP", "ECDC_Tex1", "BOTTOM", 0, -pa); -- new row
		ECDC_Tex7:ClearAllPoints(); ECDC_Tex7:SetPoint("LEFT", "ECDC_Tex6", "RIGHT", pa, 0);
		ECDC_Tex8:ClearAllPoints(); ECDC_Tex8:SetPoint("LEFT", "ECDC_Tex7", "RIGHT", pa, 0);
		ECDC_Tex9:ClearAllPoints(); ECDC_Tex9:SetPoint("LEFT", "ECDC_Tex8", "RIGHT", pa, 0);
		ECDC_Tex10:ClearAllPoints(); ECDC_Tex10:SetPoint("LEFT", "ECDC_Tex9", "RIGHT", pa, 0);
	end
end
addon.ECDC_ToggleStack = ECDC_ToggleStack;

function ECDC_Rows(amount)
	if (amount == 1) then
		ECDC_Row = 1;
		ECDC_ToggleStack(ECDC_Pos)
	elseif (amount == 2) then
		ECDC_Row = 2;
		ECDC_ToggleStack(ECDC_Pos)
	else
		ECDC_Row = 1;
		ECDC_ToggleStack(ECDC_Pos)
	end
end
addon.ECDC_Rows = ECDC_Rows;

function ECDC_ToggleVisi(setVisi)
	local button = _G[("ECDC_Button")];
	local frame = _G[("ECDC")];
	if (setVisi == "show") then
		ECDC_Visi = "show";
		frame:EnableMouse(true)
		button:Show();
	elseif (setVisi == "hide") then
		ECDC_Visi = "hide";
		frame:EnableMouse(false)
		button:Hide();
	else
		frame:EnableMouse(true)
		button:Show();
	end
end
addon.ECDC_ToggleVisi = ECDC_ToggleVisi;

function ECDC_SetSize(size)
	if size == nil then
		size = 1
	end
	ECDC_Size = size
	for i=1,10 do
		_G[("ECDC_Frame"..i)]:SetScale(ECDC_Size);
		_G[("ECDC_CD"..i)]:SetScale(ECDC_Size);
		_G[("ECDC_Tex"..i)]:SetScale(ECDC_Size);
	end
end
addon.ECDC_SetSize = ECDC_SetSize;

function ECDC_Click(self, button)
	if (button == "RightButton") then	
		if (ECDC_Activated == 0) then
			ECDC_Activate(self);
			print("|cff1a9fc0ECDC|r: activated")
			UIErrorsFrame:AddMessage("|cff1a9fc0ECDC|r: activated")
		else 
			ECDC_Deactivate(self); 
			print("|cff1a9fc0ECDC|r: disabled. |cff1a9fc0Right-click|r the fist icon to enable the addon.")
			UIErrorsFrame:AddMessage("|cff1a9fc0ECDC|r: disabled. |cff1a9fc0Right-click|r the fist icon to enable the addon.")
		end
	end
end

function ECDC_Activate(self)
	ECDC_Activated = 1;
	ECDC_Button:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Abilities-Up.blp");

	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
 end

function ECDC_Deactivate(self)
	ECDC_Activated = 0;
	ECDC_Button:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Abilities-Disabled.blp");

	self:UnregisterEvent("CHAT_MSG_ADDON")
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function ECDC_ToolTip(self, tooltipnum)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:AddLine(ECDC_ToolTips[tooltipnum]);
	GameTooltip:AddLine(ECDC_ToolTipDetails[tooltipnum], .8, .8, .8, 1);
	GameTooltip:Show();
end

function ECDC_ClickIcon(self, button, frameid)
	if button=='RightButton' and IsShiftKeyDown() then
		for k, v in pairs(ECDC_UsedSkills) do
				if (UnitGUID("target") == v.player and ECDC_ToolTips[frameid] == v.skill) then
				v.countdown = 0
			end
		end
	end
end

function ECDC_TableContains(guid, spell, spelltime)
	local index = 1;
	while ECDC_UsedSkills[index] do
		if (guid == ECDC_UsedSkills[index].player and spell == ECDC_UsedSkills[index].skill and spelltime >= ECDC_UsedSkills[index].started and spelltime <= (ECDC_UsedSkills[index].started + 4)) then
			return true;
		end
		index = index + 1;
	end
	return false;
end

function ECDC_OnEvent(self, event, addOnName, prefix, message, channel, sender, ...)
	local _, subevent, _, sourceGUID, sourceName, _, _, destGUID, _, _, _, _, spellName = CombatLogGetCurrentEventInfo()
	local realmSuffix = "-" .. gsub(GetRealmName(), "%s", "")
	local playerFullName = UnitName("player") .. realmSuffix
	
	if (event == "ADDON_LOADED" and addOnName == ADDON_NAME) then
		ECDC_ToggleStack(ECDC_Pos);
		ECDC_ToggleVisi(ECDC_Visi);
		ECDC_SetSize(ECDC_Size);
		ECDC_Rows(ECDC_Row);
		ECDC_CreateOptionsMenu();
		
		self:UnregisterEvent("ADDON_LOADED")
	end

	if (event == "PLAYER_LOGIN") then
		C_ChatInfo.RegisterAddonMessagePrefix("ECDC_Comm")
	end
	
	if (event == "PLAYER_ENTERING_WORLD") or (event == "PLAYER_TARGET_CHANGED" and not UnitExists("target")) then
		for k, v in pairs(ECDC_UsedSkills) do
			local timeleft = (v.countdown - (GetServerTime() - v.started));
			if (timeleft <= 0) then
				table.remove(ECDC_UsedSkills, k) -- delete old unused data
			end
		end
	end
	
	if (event == "PLAYER_TARGET_CHANGED") then
		for k, v in ipairs(ECDC_ToolTips) do
			ECDC_ToolTips[k] = nil -- clean up the tooltips
		end
		
		for k, v in ipairs(ECDC_ToolTipDetails) do
			ECDC_ToolTipDetails[k] = nil
		end
	end
	
	if (event == "CHAT_MSG_ADDON") and (ECDC_Activated == 1) then
		if (prefix == "ECDC_Comm" and (sender ~= playerFullName)) then
			local getGUID, getSpell, getTime = strsplit("+", message)
			if (ECDC_GetSkillCooldown(getSpell) > 10) then -- in case of cross language conflict, check with (ECDC_GetNameFromList(getSpell))
				if (ECDC_TableContains(getGUID, getSpell, tonumber(getTime)) ~= true) then
				table.insert(ECDC_UsedSkills, {player = getGUID, skill = getSpell, info = ECDC_GetInfo(getSpell), texture = ECDC_GetTexture(getSpell), countdown = ECDC_GetSkillCooldown(getSpell), started = tonumber(getTime)});
					if (getSpell == L["Preparation"] or getSpell == L["Cold Snap"] or spellName == L["Refocus"]) then
						ECDC_FinishCd(getGUID, tonumber(getTime))
					end
				end
			end
		end
	end
	
	if (subevent == "SPELL_CAST_SUCCESS") and (ECDC_Activated == 1) then
		if ((ECDC_GetSkillCooldown(spellName) ~= ECDC_ErrCountdown) and not ECDC_DelayedCd(spellName)) then
			table.insert(ECDC_UsedSkills, {player = sourceGUID, skill = spellName, info = ECDC_GetInfo(spellName), texture = ECDC_GetTexture(spellName), countdown = ECDC_GetSkillCooldown(spellName), started = GetServerTime()});
			if (IsInInstance()) then
				C_ChatInfo.SendAddonMessage("ECDC_Comm", format("%s+%s", sourceGUID, spellName) .. "+" .. GetServerTime(), "INSTANCE_CHAT");
			elseif (not IsInInstance() and not IsResting()) then
				C_ChatInfo.SendAddonMessage("ECDC_Comm", format("%s+%s", sourceGUID, spellName) .. "+" .. GetServerTime(), "RAID");
			end
		end
		
		if (spellName == L["Preparation"] or spellName == L["Cold Snap"] or spellName == L["Refocus"]) then
			ECDC_FinishCd(sourceGUID, GetServerTime())
		end
	end
	
	if (subevent == "SPELL_AURA_REMOVED" or subevent == "SPELL_AURA_BROKEN" or subevent == "SPELL_AURA_BROKEN_SPELL") and (ECDC_Activated == 1) then
		if ((ECDC_GetSkillCooldown(spellName) ~= ECDC_ErrCountdown) and ECDC_DelayedCd(spellName)) then
			if (ECDC_TableContains(sourceGUID, spellName, GetServerTime()) ~= true) then
				table.insert(ECDC_UsedSkills, {player = destGUID, skill = spellName, info = ECDC_GetInfo(spellName), texture = ECDC_GetTexture(spellName), countdown = ECDC_GetSkillCooldown(spellName), started = GetServerTime()});
				if (IsInInstance()) then
					C_ChatInfo.SendAddonMessage("ECDC_Comm", format("%s+%s", sourceGUID, spellName) .. "+" .. GetServerTime(), "INSTANCE_CHAT");
				elseif (not IsInInstance() and not IsResting()) then
					C_ChatInfo.SendAddonMessage("ECDC_Comm", format("%s+%s", sourceGUID, spellName) .. "+" .. GetServerTime(), "RAID");
				end
			end
		end
	end
	
	if (subevent == "SPELL_AURA_APPLIED") and (ECDC_Activated == 1) then
		if ((ECDC_GetSkillCooldown(spellName) ~= ECDC_ErrCountdown) and (spellName == L["Recently Bandaged"] or spellName == L["Forbearance"] or spellName == L["Unstable Power"])) then
			table.insert(ECDC_UsedSkills, {player = destGUID, skill = spellName, info = ECDC_GetInfo(spellName), texture = ECDC_GetTexture(spellName), countdown = ECDC_GetSkillCooldown(spellName), started = GetServerTime()});
			if (IsInInstance()) then
				C_ChatInfo.SendAddonMessage("ECDC_Comm", format("%s+%s", sourceGUID, spellName) .. "+" .. GetServerTime(), "INSTANCE_CHAT");
			elseif (not IsInInstance() and not IsResting()) then
				C_ChatInfo.SendAddonMessage("ECDC_Comm", format("%s+%s", sourceGUID, spellName) .. "+" .. GetServerTime(), "RAID");
			end
		end
	end
end

function ECDC_OnUpdate(elapsed)
	ECDC_TimeSinceLastUpdate = ECDC_TimeSinceLastUpdate + elapsed;
	if (ECDC_TimeSinceLastUpdate > ECDC_UpdateInterval) then
		ECDC_TimeSinceLastUpdate = 0;
		-- Spit out the infoz
		local i = 1;
		for k, v in pairs(ECDC_UsedSkills) do
			--print(k,v)
			local timeleft = (v.countdown - (GetServerTime() - v.started));
			local className, _, classID = UnitClass("target")
			if (ECDC_isSpellEnabled(v.skill)) then
				--	  Only show CD for our target if there is time left on the CD      Loop through Stuff           Warrior enrage isnt a CD, Druid Enrage is!
				if ((v.player == UnitGUID("target")) and (UnitPlayerControlled("target") or UnitIsPlayer("target")) and (timeleft > 0) and (timeleft ~= nil) and (i < 11) and not(classID == 1 and v.skill == L["Enrage"]) and not(classID ~= 2 and v.skill == L["Forbearance"]) and (ECDC_ToolTips[(i-1)] ~= v.skill) and (ECDC_ToolTips[(i-2)] ~= v.skill) and (ECDC_ToolTips[(i-3)] ~= v.skill)) then
					ECDC_ToolTips[i] = v.skill;
					ECDC_ToolTipDetails[i] = v.info;
					if (timeleft > 60) then
						--timeleft = floor((timeleft/60)*10)/10;
						_G[("ECDC_CD"..i)]:SetTextColor(1, 1, 1);
					elseif (timeleft < 6) then
						_G[("ECDC_CD"..i)]:SetTextColor(1, 0, 0);
					else
						_G[("ECDC_CD"..i)]:SetTextColor(1, 1, 0);
					end
					_G[("ECDC_CD"..i)]:SetText((timeleft < 60 and math.floor(timeleft)) or (timeleft < 3600 and math.ceil(timeleft / 60).."m") or math.ceil(timeleft / 3600).."h");
					_G[("ECDC_Tex"..i)]:SetTexture("Interface\\Icons\\"..v.texture);
					if (ECDC_Border == true) then
						_G[("ECDC_Tex"..i)]:SetTexCoord(0.07, 0.93, 0.07, 0.93)
					else
						_G[("ECDC_Tex"..i)]:SetTexCoord(0, 1, 0, 1)
					end
					_G[("ECDC_Frame"..i)]:Show();
					_G[("ECDC_CD"..i)]:Show();
					_G[("ECDC_Tex"..i)]:Show();
					if UnitAffectingCombat("player") and not IsShiftKeyDown() then
						_G[("ECDC_Frame"..i)]:EnableMouse(false)
					else
						_G[("ECDC_Frame"..i)]:EnableMouse(true)
					end
					i = i + 1;
				end
			end
		end
		
		if (ECDC_ShowTestIcons and InCombatLockdown()) then
			ECDC_ShowTestIcons = false
			_G["ECDC_p1_checkbox2"]:SetChecked(false)
		end
		
		while (i < 11 and not ECDC_ShowTestIcons) do
			_G[("ECDC_Frame"..i)]:Hide();
			_G[("ECDC_CD"..i)]:Hide();
			_G[("ECDC_Tex"..i)]:Hide();
			i = i + 1;
		end
	end
end

--[[ was used to fix cross language issue but since we check GetSkillCooldown (which is 0 when spell not found) we dont need it. Outcomment for now in case its needed later for some reason.
function ECDC_GetNameFromList(skill)
	for k, v in pairs(ECDC_Skills) do
		if (v.name == skill) then
			return true;
		end
	end
	return false;
end
]]--

function ECDC_GetTexture(skill)
	for k, v in pairs(ECDC_Skills) do 
		if (v.name == skill) then
			SkillTexture = v.icon;
		end
	end;
	return SkillTexture;	
end

function ECDC_GetInfo(skill)
	for k, v in pairs(ECDC_Skills) do 
		if (v.name == skill) then
			SkillInfo = v.desc;
		end
	end;
	return SkillInfo;	
end

function ECDC_GetSkillCooldown(skill)
	for k, v in pairs(ECDC_Skills) do 
		if (v.name == skill) then
			SkillCountdown = v.cooldown;
			break;
		else
			SkillCountdown = ECDC_ErrCountdown;
		end
	end;
	return SkillCountdown;
end

function ECDC_DelayedCd(spellName)
	for _, spell in ipairs(ECDC_DelayedCds) do
		if (spellName == spell) then
			return true;
		end
	end
	return false;
end

function ECDC_FinishCd(sourceGUID, getTime)
	for k, v in pairs(ECDC_UsedSkills) do
		for _, spell in ipairs(ECDC_FinishCds) do
			if (sourceGUID == v.player and spell == v.skill and getTime >= v.started) then
				v.countdown = 0
			end
		end
	end
end

function ECDC_isSpellEnabled(spellName)
	return savedOptions["Warrior"][spellName] or savedOptions["Warlock"][spellName] or savedOptions["Shaman"][spellName] 
	or savedOptions["Rogue"][spellName] or savedOptions["Priest"][spellName] or savedOptions["Paladin"][spellName] 
	or savedOptions["Mage"][spellName] or savedOptions["Hunter"][spellName] or savedOptions["Druid"][spellName] 
	or savedOptions["Miscellaneous"][spellName] or savedOptions["Racials"][spellName] or savedOptions["Trinkets"][spellName];
end

function ECDC_OnDragStart()
	ECDC:StartMoving()
end

function ECDC_OnDragStop()
	ECDC:StopMovingOrSizing()
end

function ECDC_LoadSkills()
	ECDC_Skills = {
		-- Exclusively Talent Cooldowns
		{name = L["Blade Flurry"], cooldown = 120, desc = "Increases your attack speed by 20%.  In addition, attacks strike an additional nearby opponent.  Lasts 15 sec.", icon = "Ability_Warrior_PunishingBlow"},
		{name = L["Adrenaline Rush"], cooldown = (5*60), desc = "Increases your Energy regeneration rate by 100% for 15 sec.", icon = "Spell_Shadow_ShadowWordDominate"},
		{name = L["Preparation"], cooldown = 600, desc = "Finishes cooldown of all other Rogue abilities", icon = "spell_shadow_antishadow"},
		{name = L["Ghostly Strike"], cooldown = 20, desc = "A strike that deals 125% weapon damage and increases your chance to dodge by 15% for 7 sec.  Awards 1 combo point.", icon = "Spell_Shadow_Curse"},
		{name = L["Premeditation"], cooldown = 120, desc = "Adds 2 combo points to your target", icon = "Spell_Shadow_Possession"},
		{name = L["Cold Blood"], cooldown = 180, desc = "Increases the critical strike chance of your next Sinister Strike, Backstab, Ambush, or Eviscerate by 100%.", icon = "Spell_Ice_Lament"},

		{name = L["Bestial Wrath"], cooldown = 120, desc = "Send your pet into a rage causing 50% additional damage for 18 sec.  While enraged, the beast does not feel pity or remorse or fear and it cannot be stopped unless killed.", icon = "Ability_Druid_FerociousBite"},
		{name = L["Intimidation"], cooldown = 60, desc = "Command your pet to intimidate the target on the next successful melee attack, causing a high amount of threat and stunning the target for 3 sec.", icon = "Ability_Devour"},
		{name = L["Deterrence"], cooldown = (5*60), desc = "When activated, increases your Dodge and Parry chance by 25% for 10 sec.", icon = "Ability_whirlwind"},
		{name = L["Scatter Shot"], cooldown = 30, desc = "A short-range shot that deals 50% weapon damage and disorients the target for 4 sec.  Any damage caused will remove the effect.  Turns off your attack when used.", icon = "Ability_golemstormbolt"},
		{name = L["Aimed Shot"], cooldown = 6, desc = "An aimed shot that increases ranged damage by 600.", icon = "inv_spear_07"},

		{name = L["Last Stand"], cooldown = 600, desc = "This ability temporarily grants you 30% of your maximum hit points for 20 seconds.  After the effect expires, the hit points are lost.", icon = "Spell_Holy_AshesToAshes"},
		{name = L["Sweeping Strikes"], cooldown = 30, desc = "Your next 5 melee attacks strike an additional nearby opponent.", icon = "ability_rogue_slicedice"},
		{name = L["Death Wish"], cooldown = 180, desc = "When activated, increases your physical damage by 20% and makes you immune to Fear effects, but lowers your armor and all resistances by 20%.  Lasts 30 sec.", icon = "spell_shadow_deathpact"},
		{name = L["Concussion Blow"], cooldown = 45, desc = "Stuns the opponent for 5 sec.", icon = "ability_thunderbolt"},

		{name = L["Inner Focus"], cooldown = 180, desc = "Reduces the Mana cost of your next spell by 100% and increases its critical effect chance by 25% if it is capable of a critical effect.", icon = "Spell_Frost_WindWalkOn"},
		{name = L["Power Infusion"], cooldown = 180, desc = "Infuses the target with power, increasing their spell damage and healing by 20%.  Lasts 15 sec.", icon = "Spell_Holy_PowerInfusion"},
		{name = L["Silence"], cooldown = 45, desc = "Silences the target, preventing them from casting spells for 5 sec.", icon = "spell_shadow_impphaseshift"},

		{name = L["Elemental Mastery"], cooldown = 180, desc = "This spell gives your next Fire, Frost, or Nature damage spell a 100% critical strike chance and reduces the mana cost by 100%.", icon = "Spell_Nature_WispHeal"},
		{name = L["Stormstrike"], cooldown = 20, desc = "Gives you an extra attack.  In addition, the next 2 sources of Nature damage dealt to the target are increased by 20%.  Lasts 12 sec.", icon = "Spell_Holy_SealOfMight"},
		{name = L["Nature's Swiftness"], cooldown = 180, desc = "Next NATURE spell is instant cast", icon = "Spell_Nature_RavenForm"},

		{name = L["Fel Domination"], cooldown = (15*60), desc = "Your next Imp, Voidwalker, Succubus, or Felhunter Summon spell has its casting time reduced by 5.5 sec and its Mana cost reduced by 50%.", icon = "Spell_Nature_RemoveCurse"},
		{name = L["Amplify Curse"], cooldown = 180, desc = "Increases the effect of your next Curse of Weakness or Curse of Agony by 50%, or your next Curse of Exhaustion by 20%.  Lasts 30 sec.", icon = "spell_shadow_contagion"},

		{name = L["Divine Favor"], cooldown = 120, desc = "Gives your next Flash of Light, Holy Light, or Holy Shock spell a 100% critical effect chance.", icon = "Spell_Holy_Heal"},
		{name = L["Holy Shock"], cooldown = 30, desc = "Blasts the target with Holy energy, causing 365 to 395 Holy damage to an enemy, or 365 to 395 healing to an ally.", icon = "Spell_Holy_SearingLight"},
		{name = L["Holy Shield"], cooldown = 10, desc = "Increases chance to block by 30% for 10 sec, and deals 130 Holy damage for each attack blocked while active.  Damage caused by Holy Shield causes 20% additional threat.  Each block expends a charge.  4 charges.", icon = "Spell_Holy_BlessingOfProtection"},
		{name = L["Repentance"], cooldown = 60, desc = "Puts the enemy target in a state of meditation, incapacitating them for up to 6 sec.  Any damage caused will awaken the target.  Only works against Humanoids.", icon = "Spell_Holy_PrayerOfHealing"},

		{name = L["Innervate"], cooldown = (6*60), desc = "Increases the target's Mana regeneration by 400% and allows 100% of the target's Mana regeneration to continue while casting.  Lasts 20 sec.", icon = "Spell_Nature_Lightning"},
		{name = L["Faerie Fire (Feral)"], cooldown = 6, desc = "Decrease the armor of the target by 505 for 40 sec.  While affected, the target cannot stealth or turn invisible.", icon = "Spell_Nature_FaerieFire"},
		{name = L["Feral Charge"], cooldown = 15, desc = "Causes you to charge an enemy, immobilizing and interrupting any spell being cast for 4 sec.", icon = "Ability_Hunter_Pet_Bear"},
		{name = L["Swiftmend"], cooldown = 15, desc = "Consumes a Rejuvenation or Regrowth effect on a friendly target to instantly heal them an amount equal to 12 sec. of Rejuvenation or 18 sec. of Regrowth.", icon = "Inv_Relics_IdolOfRejuvenation"},

		{name = L["Presence of Mind"], cooldown = 180, desc = "Your next Mage spell with a casting time less than 10 sec becomes an instant cast spell.", icon = "Spell_Nature_EnchantArmor"},
		{name = L["Arcane Power"], cooldown = 180, desc = "Your spells deal 30% more damage while costing 30% more mana to cast.  This effect lasts 15 sec.", icon = "Spell_Nature_Lightning"},
		{name = L["Combustion"], cooldown = 180, desc = "This spell causes each of your Fire damage spell hits to increase your critical strike chance with Fire damage spells by 10%.  This effect lasts until you have caused 3 critical strikes with Fire spells.", icon = "Spell_Fire_SealOfFire"},
		{name = L["Cold Snap"], cooldown = (10*60), desc = "This spell finishes the cooldown on all of your Frost spells.", icon = "Spell_Frost_WizardMark"},
		{name = L["Ice Block"], cooldown = (5*60), desc = "You become encased in a block of ice, protecting you from all physical attacks and spells for 10 sec, but during that time you cannot attack, move or cast spells.", icon = "Spell_Frost_Frost"},

		-- Trinkets & Racials
		{name = L["Will of the Forsaken"], cooldown = 120, desc = "Provides immunity to Charm, Fear and Sleep while active.  May also be used while already afflicted by Charm, Fear or Sleep.  Lasts 5 sec.", icon = "Spell_Shadow_RaiseDead"},
		{name = L["Perception"], cooldown = 180, desc = "Dramatically increases stealth detection for 20 sec.", icon = "Spell_Nature_Sleep"},
		{name = L["War Stomp"], cooldown = 120, desc = "Stuns up to 5 enemies within 8 yds for 2 sec.", icon = "Ability_WarStomp"},
		{name = L["Stoneform"], cooldown = 180, desc = "While active, grants immunity to Bleed, Poison, and Disease effects.  In addition, Armor increased by 10%.  Lasts 8 sec.", icon = "Spell_Shadow_UnholyStrength"},
		{name = L["Cannibalize"], cooldown = 120, desc = "When activated, regenerates 7% of total health every 2 sec for 10 sec.  Only works on Humanoid or Undead corpses within 5 yds.  Any movement, action, or damage taken while Cannibalizing will cancel the effect.", icon = "ability_racial_cannibalize"},
		{name = L["Blood Fury"], cooldown = 120, desc = "Increases base melee attack power by 25% for 15 sec and reduces healing effects on you by 50% for 25 sec.", icon = "racial_orc_berserkerstrength"},
		{name = L["Berserking"], cooldown = 180, desc = "Increases your attack/casting speed by 10% to 30%.  At full health the speed increase is 10% with a greater effect up to 30% if you are badly hurt when you activate Berserking.  Lasts 10 sec.", icon = "racial_troll_berserk"},
		{name = L["Shadowmeld"], cooldown = 10, desc = "Activate to slip into the shadows, reducing the chance for enemies to detect your presence. Lasts until cancelled or upon moving.", icon = "ability_ambush"},
		{name = L["Escape Artist"], cooldown = 60, desc = "Escape the effects of any immobilization or movement speed reduction effect.", icon = "ability_rogue_trip"},

		{name = L["Brittle Armor"], cooldown = 120, desc = "Increases your armor by 2000 and defense skill by 30 for 20 sec. Every time you take melee or ranged damage, this bonus is reduced by 200 armor and 3 defense.", icon = "inv_jewelry_necklace_13"},
		{name = L["Unstable Power"], cooldown = 120, desc = "Increases your spell damage by up to 204 and your healing by up to 408 for 20 sec. Every time you cast a spell, the bonus is reduced by 17 spell damage and 34 healing.", icon = "inv_jewelry_necklace_13"},
		--{name = L["Restless Strength"], cooldown = 120, desc = "Increases your melee and ranged damage by 40 for 20 sec. Every time you hit a target, this bonus is reduced by 2.", icon = "inv_jewelry_necklace_13"},
		{name = L["Ephemeral Power"], cooldown = 90, desc = "Increases damage and healing done by magical spells and effects by up to 175 for 15 sec.", icon = "inv_misc_stonetablet_11"},
		--{name = L["Massive Destruction"], cooldown = 180, desc = "Increases the critical hit chance of your Destruction spells by 10% for 20 sec.", icon = "inv_jewelry_necklace_19"},
		--{name = L["Arcane Potency"], cooldown = 180, desc = "Increases the critical hit chance of your Arcane spells by 5%, and increases the critical hit damage of your Arcane spells by 50% for 20 sec.", icon = "inv_jewelry_necklace_19"},
		--{name = L["Energized Shield"], cooldown = 180, desc = "Increases the damage dealt by your Lightning Shield spell by 100% for 20 sec.", icon = "inv_jewelry_necklace_19"},
		--{name = L["Brilliant Light"], cooldown = 180, desc = "Increases the critical hit chance of Holy spells by 10% for 15 sec.", icon = "inv_jewelry_necklace_19"},
		--{name = L["Mar'li's Brain Boost"], cooldown = 180, desc = "Restores 60 mana every 5 sec for 30 sec.", icon = "INV_ZulGurubTrinket"},
		{name = L["Burst of Energy"], cooldown = 180, desc = "Instantly increases your energy by 60.", icon = "inv_jewelry_necklace_19"},
		{name = L["Refocus"], cooldown = 180, desc = "Instantly clears the cooldowns of Aimed Shot, Multishot, Volley, and Arcane Shot.", icon = "inv_jewelry_necklace_19"},
		{name = L["Venomous Totem"], cooldown = 300, desc = "Increases the chance to apply Rogue poisons to your target by 30% for 20 sec.", icon = "spell_totem_wardofdraining"},
		{name = L["Mind Quickening"], cooldown = 300, desc = "Quickens the mind, increasing the Mage's casting speed by 33% for 20 sec.", icon = "spell_nature_wispheal"},
		{name = L["Gift of Life"], cooldown = 300, desc = "Heals yourself for 15% of your maximum health, and increases your maximum health by 15% for 20 sec.", icon = "INV_Misc_Gem_Pearl_05"},
		{name = L["Blinding Light"], cooldown = 300, desc = "Energizes a Paladin with light, increasing melee attack speed by 25% and spell casting speed by 33% for 20 sec.", icon = "inv_scroll_08"},
		{name = L["Nature Aligned"], cooldown = 300, desc = "Aligns the Shaman with nature, increasing spell damage by 20%, improving heal effects by 20%, and increasing mana cost of spells by 20% for 20 sec.", icon = "inv_misc_gem_03"},
		{name = L["Earthstrike"], cooldown = 120, desc = "Increases your melee and ranged attack power by 280.  Effect lasts for 20 sec.", icon = "Spell_Nature_AbolishMagic"},
		{name = L["Badge of the Swarmguard"], cooldown = 180, desc = "Gives a chance on melee or ranged attack to apply an armor penetration effect on you for 30 sec, lowering the target's physical armor by 200 to your own attacks. The armor penetration effect can be applied up to 6 times.", icon = "inv_misc_ahnqirajtrinket_04"},
		--{name = L["Speed"], cooldown = 1800, desc = "Increases run speed by 40% for 10 sec.", icon = "inv_misc_pocketwatch_01"}, -- TODO: Fix tracking of nifty/swiftness pot (both auras are called "Speed")
		{name = L["Immune Root/Snare/Stun"], cooldown = 300, desc = "PvP Trinket", icon = "inv_jewelry_trinketpvp_02"},
		{name = L["Immune Fear/Polymorph/Snare"], cooldown = 300, desc = "PvP Trinket", icon = "inv_jewelry_trinketpvp_02"},
		{name = L["Immune Charm/Fear/Stun"], cooldown = 300, desc = "PvP Trinket", icon = "inv_jewelry_trinketpvp_02"},
		{name = L["Immune Charm/Fear/Polymorph"], cooldown = 300, desc = "PvP Trinket", icon = "inv_jewelry_trinketpvp_02"},
		{name = L["Immune Fear/Polymorph/Stun"], cooldown = 300, desc = "PvP Trinket", icon = "inv_jewelry_trinketpvp_02"},
		{name = L["Tidal Charm"], cooldown = 900, desc = "Stuns target for 3 sec.", icon = "inv_misc_rune_01"},
		{name = L["Diamond Flask"], cooldown = 360, desc = "Restores 9 health every 5 sec and increases your Strength by 75.  Lasts 1 min.", icon = "inv_drink_01"},
		{name = L["Fearless"], cooldown = 600, desc = "Increases armor by 50, all resistances by 10 and grants immunity to Fear for 30 sec.", icon = "inv_jewelry_talisman_02"},
		{name = L["Net-o-Matic"], cooldown = 600, desc = "Captures the target in a net for 10 sec.  The net has a lot of hooks however and sometimes gets caught in the user's clothing when fired.", icon = "ability_ensnare"},
		{name = L["The Burrower's Shell"], cooldown = 120, desc = "Absorbs 900 damage.  Lasts 20 sec.", icon = "inv_shield_23"},
		{name = L["Aura of Protection"], cooldown = 1800, desc = "Absorbs 750 to 1250 damage.  Lasts 20 sec.", icon = "inv_misc_armorkit_04"},
		{name = L["The Eye of the Dead"], cooldown = 120, desc = "Increases healing done by the next 5 spells by up to 450 for 30 sec.", icon = "inv_trinket_naxxramas01"},
		{name = L["Essence of Sapphiron"], cooldown = 120, desc = "Increases damage and healing done by magical spells and effects by up to 130 for 20 sec.", icon = "inv_trinket_naxxramas06"},
		{name = L["Persistent Shield"], cooldown = 180, desc = "Your magical heals provide the target with a shield that absorbs damage equal to 15% of the amount healed for 30 sec.", icon = "inv_misc_ahnqirajtrinket_06"},
		{name = L["Slayer's Crest"], cooldown = 120, desc = "Increases Attack Power by 260 for 20 sec.", icon = "inv_trinket_naxxramas03"},
		{name = L["Kiss of the Spider"], cooldown = 120, desc = "Increases your attack speed by 20% for 15 sec.", icon = "inv_trinket_naxxramas04"},
		
		{name = L["Frost Reflector"], cooldown = 300, desc = "Reflects Frost spells back at their caster for 5 sec.", icon = "inv_misc_enggizmos_02"},
		{name = L["Shadow Reflector"], cooldown = 300, desc = "Reflects Shadow spells back at their caster for 5 sec.", icon = "inv_misc_enggizmos_16"},
		{name = L["Fire Reflector"], cooldown = 300, desc = "Reflects Fire spells back at their caster for 5 sec.", icon = "inv_misc_enggizmos_04"},

		{name = L["Healing Potion"], cooldown = 120, desc = "Restores 1050 to 1750 health.", icon = "inv_potion_54"},
		{name = L["Healing Draught"], cooldown = 120, desc = "Restores 1050 to 1750 health.", icon = "inv_potion_54"},
		{name = L["Restore Mana"], cooldown = 120, desc = "Restores 1350 to 2250 mana.", icon = "inv_potion_76"},
		{name = L["Free Action"], cooldown = 120, desc = "Makes you immune to Stun and Movement Impairing effects for the next 30 sec.   Does not remove effects already on the imbiber.", icon = "inv_potion_04"},
		{name = L["Living Free Action"], cooldown = 120, desc = "Makes you immune to Stun and Movement Impairing effects for the next 5 sec.  Also removes existing Stun and Movement Impairing effects.", icon = "inv_potion_07"},
		{name = L["Invulnerability"], cooldown = 120, desc = "Imbiber is immune to physical attacks for the next 6 sec.", icon = "inv_potion_62"},
		{name = L["Restoration"], cooldown = 120, desc = "Removes 1 magic, curse, poison or disease effect on you every 5 seconds for 30 seconds.", icon = "inv_potion_01"},
		{name = L["Restore Energy"], cooldown = 300, desc = "Instantly restores 100 energy.", icon = "inv_drink_milk_05"},
		
		{name = L["Recently Bandaged"], cooldown = 60, desc = "Cannot be bandaged again.", icon = "inv_misc_bandage_08"},
		{name = L["Iron Grenade"], cooldown = 60, desc = "Inflicts 132 to 218 Fire damage and stuns targets for 3 sec in a 3 yard radius.  Any damage will break the effect.", icon = "inv_misc_bomb_08"},
		{name = L["Thorium Grenade"], cooldown = 60, desc = "Inflicts 300 to 500 Fire damage and stuns targets for 3 sec in a 3 yard radius.  Any damage will break the effect.", icon = "inv_misc_bomb_08"},
		{name = L["Goblin Sapper Charge"], cooldown = 300, desc = "Explodes when triggered dealing 450 to 750 Fire damage to all enemies nearby and 375 to 625 damage to you.", icon = "spell_fire_selfdestruct"},
		{name = L["Flash Bomb"], cooldown = 60, desc = "Causes all Beasts in a 5 yard radius to run away for 10 sec.", icon = "inv_misc_ammo_bullet_01"},
		{name = L["Arcane Bomb"], cooldown = 60, desc = "Drains 675 to 1125 mana from those in the blast radius and does 50% of the mana drained in damage to the target.  Also Silences targets in the blast for 5 sec.", icon = "spell_shadow_mindbomb"},
		
		{name = L["Sleep"], cooldown = 60, desc = "Puts the enemy target to sleep for up to 30 sec.  Any damage caused will awaken the target. Only one target can be asleep at a time.", icon = "inv_misc_dust_02"},
		{name = L["Flee"], cooldown = 300, desc = "Increase your run speed by 60% for 10 sec, but deals 100 to 500 damage and drains 100 to 500 mana every 2 seconds.", icon = "inv_misc_bone_elfskull_01"},
		{name = L["Gnomish Rocket Boots"], cooldown = 1800, desc = "These boots significantly increase your run speed for 20 sec.", icon = "inv_boots_02"},
		{name = L["Goblin Rocket Boots"], cooldown = 300, desc = "These dangerous looking boots significantly increase your run speed for 20 sec.", icon = "inv_gizmo_rocketboot_01"},
		{name = L["Running Speed"], cooldown = 3600, desc = "Increases run speed by 40% for 15 sec.", icon = "inv_boots_08"},
		{name = L["Gnomish Mind Control Cap"], cooldown = 1800, desc = "Engage in mental combat with a humanoid target to try and control their mind.  If all works well, you will control the mind of the target for 20 sec.", icon = "inv_helmet_49"},
		{name = L["Reckless Charge"], cooldown = 1200, desc = "Charge an enemy, knocking it silly for 30 seconds. Also knocks you down, stunning you for a short period of time. Any damage caused will revive the target.", icon = "inv_helmet_49"},

		-- Warrior
		{name = L["Charge"], cooldown = 15, desc = "Charge an enemy, generate 15 rage, and stun it for 1 sec. Cannot be used in combat.", icon = "Ability_Warrior_Charge"},
		{name = L["Mocking Blow"], cooldown = 120, desc = "A mocking attack that causes 93 damage, a moderate amount of threat and forces the target to focus attacks on you for 6 sec.", icon = "Ability_Warrior_PunishingBlow"},
		{name = L["Mortal Strike"], cooldown = 6, desc = "A vicious strike that deals weapon damage plus 160 and wounds the target, reducing the effectiveness of any healing by 50% for 10 sec.", icon = "Ability_Warrior_SavageBlow"},
		{name = L["Overpower"], cooldown = 5, desc = "Instantly overpower the enemy, causing weapon damage plus 35. Only useable after the target dodges. The Overpower cannot be blocked, dodged or parried.", icon = "Ability_MeleeDamage"},
		{name = L["Retaliation"], cooldown = (30*60), desc = "Instantly counterattack any enemy that strikes you in melee for 15 sec. Melee attacks made from behind cannot be counterattacked. A maximum of 30 attacks will cause retaliation.", icon = "Ability_Warrior_Challange"},
		{name = L["Thunder Clap"], cooldown = 4, desc = "Blasts nearby enemies with thunder slowing their attack speed by 10% for 30 sec and doing 103 damage to them. Will affect up to 4 targets.", icon = "Spell_Nature_ThunderClap"},
		{name = L["Berserker Rage"], cooldown = 30, desc = "The warrior enters a berserker rage, becoming immune to Fear and Incapacitate effects and generating extra rage when taking damage. Lasts 10 sec.", icon = "Spell_Nature_AncestralGuardian"},
		{name = L["Bloodthirst"], cooldown = 6, desc = "Instantly attack the target causing damage equal to 45% of your attack power. In addition, the next 5 successful melee attacks will restore 20 health. This effect lasts 8 sec.", icon = "Spell_Nature_BloodLust"},
		{name = L["Challenging Shout"], cooldown = 600, desc = "Forces all nearby enemies to focus attacks on you for 6 sec.", icon = "Ability_BullRush"},
		{name = L["Intercept"], cooldown = 25, desc = "Charge an enemy, causing 65 damage and stunning it for 3 sec.", icon = "Ability_Rogue_Sprint"}, -- setting cd to 25 sec because of pvp gear set bonus
		{name = L["Intimidating Shout"], cooldown = 180, desc = "The warrior shouts, causing the targeted enemy to cower in fear. Up to 5 total nearby enemies will flee in fear. Lasts 8 sec.", icon = "Ability_GolemThunderClap"},
		{name = L["Pummel"], cooldown = 10, desc = "Pummel the target for 50 damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 4 sec.", icon = "INV_Gauntlets_04"},
		{name = L["Recklessness"], cooldown = (30*60), desc = "The warrior will cause critical hits with most attacks and will be immune to Fear effects for the next 15 sec, but all damage taken is increased by 20%.", icon = "Ability_CriticalStrike"},
		{name = L["Whirlwind"], cooldown = 10, desc = "In a whirlwind of steel you attack up to 4 enemies within 8 yards, causing weapon damage to each enemy.", icon = "Ability_Whirlwind"},
		{name = L["Bloodrage"], cooldown = 60, desc = "Generates 10 rage at the cost of health, and then generates an additional 10 rage over 10 sec. The warrior is considered in combat for the duration.", icon = "Ability_Racial_BloodRage"},
		{name = L["Disarm"], cooldown = 60, desc = "Disarm the enemy's weapon for 10 sec.", icon = "Ability_Warrior_Disarm"},
		{name = L["Revenge"], cooldown = 5, desc = "Instantly counterattack an enemy for 81 to 99 damage and a high amount of threat. Revenge must follow a block, dodge or parry.", icon = "Ability_Warrior_Revenge"},
		{name = L["Shield Bash"], cooldown = 12, desc = "Bashes the target with your shield for 45 damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 6 sec.", icon = "Ability_Warrior_ShieldBash"},
		{name = L["Shield Block"], cooldown = 5, desc = "Increases chance to block by 75% for 5 sec, but will only block 1 attack.", icon = "Ability_Defend"},
		{name = L["Shield Slam"], cooldown = 6, desc = "Slam the target with your shield, causing 342 to 358 damage, modified by your shield block value, and has a 50% chance of dispelling 1 magic effect on the target. Also causes a high amount of threat.", icon = "INV_Shield_05"},
		{name = L["Shield Wall"], cooldown = (30*60), desc = "Reduces the damage taken from melee attacks, ranged attacks and spells by 75% for 10 sec.", icon = "Ability_Warrior_ShieldWall"},

		-- Paladin
		{name = L["Consecration"], cooldown = 8, desc = "Consecrates the land beneath Paladin, doing 384 Holy damage over 8 sec to enemies who enter the area.", icon = "Spell_Holy_InnerFire"},
		{name = L["Exorcism"], cooldown = 15, desc = "Causes 505 to 563 Holy damage to an Undead or Demon target.", icon = "Spell_Holy_Excorcism_02"},
		{name = L["Hammer of Wrath"], cooldown = 6, desc = "Hurls a hammer that strikes an enemy for 304 to 336 Holy damage. Only usable on enemies that have 20% or less health.", icon = "Ability_ThunderClap"},
		{name = L["Holy Wrath"], cooldown = 60, desc = "Sends bolts of holy power in all directions, causing 490 to 576 Holy damage to all Undead and Demon targets within 20 yds.", icon = "Spell_Holy_Excorcism"},
		{name = L["Lay on Hands"], cooldown = (40*60), desc = "Heals a friendly target for an amount equal to the Paladin's maximum health and restores 550 of their mana. Drains all of the Paladin's remaining mana when used.", icon = "Spell_Holy_LayOnHands"}, --set to 40min because of imp LoH talent
		{name = L["Turn Undead"], cooldown = 30, desc = "The targeted undead enemy will be compelled to flee for up to 20 sec. Damage caused may interrupt the effect. Only one target can be turned at a time.", icon = "Spell_Holy_TurnUndead"},
		{name = L["Blessing of Freedom"], cooldown = 14, desc = "Places a Blessing on the friendly target, granting immunity to movement impairing effects for 10 sec. Players may only have one Blessing on them per Paladin at any one time.", icon = "Spell_Holy_SealOfValor"}, -- set to 14 sec cd because of 2/2 guardians favor talent
		{name = L["Blessing of Protection"], cooldown = 180, desc = "A targeted party member is protected from all physical attacks for 10 sec, but during that time they cannot attack or use physical abilities. Players may only have one Blessing on them per Paladin at any one time. Once protected, the target cannot be made invulnerable by Divine Shield, Divine Protection or Blessing of Protection again for 1 min.", icon = "Spell_Holy_SealOfProtection"}, -- set to 3 min cd because of 2/2 guardians favor talent
		{name = L["Divine Intervention"], cooldown = (60*60), desc = "The paladin sacrifices himself to remove the targeted party member from harms way. Enemies will stop attacking the protected party member, who will be immune to all harmful attacks but cannot take any action for 3 min.", icon = "Spell_Nature_TimeStop"},
		{name = L["Divine Protection"], cooldown = (5*60), desc = "You are protected from all physical attacks and spells for 8 sec, but during that time you cannot attack or use physical abilities yourself. Once protected, the target cannot be made invulnerable by Divine Shield, Divine Protection or Blessing of Protection again for 1 min.", icon = "Spell_Holy_Restoration"},
		{name = L["Divine Shield"], cooldown = (5*60), desc = "Protects the paladin from all damage and spells for 12 sec, but reduces attack speed by 50%. Once protected, the target cannot be made invulnerable by Divine Shield, Divine Protection or Blessing of Protection again for 1 min.", icon = "Spell_Holy_DivineIntervention"},
		{name = L["Hammer of Justice"], cooldown = 45, desc = "Stuns the target for 6 sec.", icon = "Spell_Holy_SealOfMight"}, -- Setting cd to 45 sec because of imp. hammer of justice talent as well as pvp set bonus
		{name = L["Judgement"], cooldown = 8, desc = "Unleashes the energy of a Seal spell upon an enemy. Refer to individual Seals for Judgement effect.", icon = "Spell_Holy_RighteousFury"}, -- set to 8 sec becuase of 2/2 imp. judgement talent
		{name = L["Forbearance"], cooldown = 60, desc = "Cannot be made invulnerable by Divine Shield, Divine Protection or Blessing of Protection.", icon = "spell_holy_removecurse"},

		-- Mage
		{name = L["Blink"], cooldown = 14, desc = "Teleports the caster 20 yards forward, unless something is in the way. Also frees the caster from stuns and bonds.", icon = "Spell_Arcane_Blink"}, -- set to 14 sec cd because of pvp set bonus
		--{name = L["Portal: Darnassus"], cooldown = 60, desc = "Creates a portal, teleporting group members that use it to Darnassus.", icon = "Spell_Arcane_PortalDarnassus"},
		--{name = L["Portal: Ironforge"], cooldown = 60, desc = "Creates a portal, teleporting group members that use it to Ironforge.", icon = "Spell_Arcane_PortalIronForge"},
		--{name = L["Portal: Orgrimmar"], cooldown = 60, desc = "Creates a portal, teleporting group members that use it to Orgrimmar.", icon = "Spell_Arcane_PortalOrgrimmar"},
		--{name = L["Portal: Stormwind"], cooldown = 60, desc = "Creates a portal, teleporting group members that use it to Stormwind.", icon = "Spell_Arcane_PortalStormWind"},
		--{name = L["Portal: Thunder Bluff"], cooldown = 60, desc = "Creates a portal, teleporting group members that use it to Thunder Bluff.", icon = "Spell_Arcane_PortalThunderBluff"},
		--{name = L["Portal: Undercity"], cooldown = 60, desc = "Creates a portal, teleporting group members that use it to Undercity.", icon = "Spell_Arcane_PortalUnderCity"},
		{name = L["Blast Wave"], cooldown = 45, desc = "A wave of flame radiates outward from the caster, damaging all enemies caught within the blast for 462 to 544 Fire damage, and dazing them for 6 sec.", icon = "Spell_Holy_Excorcism_02"},
		{name = L["Fire Blast"], cooldown = 7, desc = "Blasts the enemy for 431 to 509 Fire damage.", icon = "Spell_Fire_Fireball"}, -- set to 7 sec cd because of imp. fire blast talent
		{name = L["Fire Ward"], cooldown = 30, desc = "Absorbs 920 Fire damage. Lasts 30 sec.", icon = "Spell_Fire_FireArmor"},
		{name = L["Cone of Cold"], cooldown = 10, desc = "Targets in a cone in front of the caster take 335 to 365 Frost damage and are slowed by 50% for 8 sec.", icon = "Spell_Frost_Glacier"},
		{name = L["Frost Nova"], cooldown = 21, desc = "Blasts enemies near the caster for 71 to 79 Frost damage and freezes them in place for up to 8 sec. Damage caused may interrupt the effect.", icon = "Spell_Frost_FrostNova"}, -- setting cd to 21 because almost every mage run imp frost nova in pvp.
		{name = L["Frost Ward"], cooldown = 30, desc = "Absorbs 920 Frost damage. Lasts 30 sec.", icon = "Spell_Frost_FrostWard"},
		{name = L["Ice Barrier"], cooldown = 30, desc = "Instantly shields you, absorbing 818 damage. Lasts 1 min. While the shield holds, spells will not be interrupted.", icon = "Spell_Ice_Lament"},
		{name = L["Counterspell"], cooldown = 30, desc = "Counters the enemy's spellcast, preventing any spell from that school of magic from being cast for 10 sec.  Generates a high amount of threat.", icon = "spell_frost_iceshock"},
		{name = L["Evocation"], cooldown = 480, desc = "While channeling this spell, your mana regeneration is active and increased by 1500%.  Lasts 8 sec.", icon = "spell_nature_purge"},

		-- Rogues
		{name = L["Kidney Shot"], cooldown = 20, desc = "Finishing move that stuns the target. Lasts longer per combo point.", icon = "Ability_Rogue_KidneyShot"},
		{name = L["Evasion"], cooldown = 210, desc = "The rogue's dodge chance will increase by 50% for 15 sec.", icon = "Spell_Shadow_ShadowWard"}, -- setting cooldown to 3.5 min because of 2/2 endurance talent
		{name = L["Feint"], cooldown = 10, desc = "Performs a feint, causing no damage but lowering your threat by a large amount, making the enemy less likely to attack you.", icon = "Ability_Rogue_Feint"},
		{name = L["Gouge"], cooldown = 9, desc = "Causes 75 damage, incapacitating the opponent for 4 sec, and turns off your attack. Target must be facing you. Any damage caused will revive the target. Awards 1 combo point.", icon = "Ability_Gouge"}, -- set cooldown to 9 sec because of pvp set bonus
		{name = L["Kick"], cooldown = 10, desc = "A quick kick that injures a single foe for 80 damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 5 sec.", icon = "Ability_Kick"},
		{name = L["Sprint"], cooldown = 210, desc = "Increases the rogue's movement speed by 70% for 15 sec. Does not break stealth.", icon = "Ability_Rogue_Sprint"}, -- setting cooldown to 3.5 min because of 2/2 endurance talent
		{name = L["Blind"], cooldown = 210, desc = "Blinds the target, causing it to wander disoriented for up to 10 sec. Any damage caused will remove the effect.", icon = "Spell_Shadow_MindSteal"}, -- setting cooldown to 3.5 min because of 2/2 Elusiveness talent
		{name = L["Distract"], cooldown = 30, desc = "Throws a distraction, attracting the attention of all nearby monsters for 10 seconds. Does not break stealth.", icon = "Ability_Rogue_Distract"},
		{name = L["Stealth"], cooldown = 6, desc = "Allows the rogue to sneak around, but reduces your speed by 30%. Lasts until cancelled.", icon = "Ability_Stealth"}, -- Setting this to 6 sec cd because of 4/5 Camouflage in pvp
		{name = L["Vanish"], cooldown = 210, desc = "Allows the rogue to vanish from sight, entering an improved stealth mode for 10 sec. Also breaks movement impairing effects. More effective than Vanish (Rank 1).", icon = "Ability_Vanish"}, -- setting cooldown to 3.5 min because of 2/2 Elusiveness talent

		-- Shaman
		{name = L["Reincarnation"], cooldown = (60*40), desc = "Allows you to resurrect yourself upon death with 20% health and mana.", icon = "spell_nature_reincarnation"},
		{name = L["Chain Lightning"], cooldown = 6, desc = "Hurls a lightning bolt at the enemy, dealing 493 to 551 Nature damage and then jumping to additional nearby enemies. Each jump reduces the damage by 30%. Affects 3 total targets.", icon = "Spell_Nature_ChainLightning"},
		{name = L["Earth Shock"], cooldown = 5, desc = "Instantly shocks the target with concussive force, causing 517 to 545 Nature damage. It also interrupts spellcasting and prevents any spell in that school from being cast for 2 sec. Causes a high amount of threat.", icon = "Spell_Nature_EarthShock"}, -- setting cd to 5 sec because of Reverberation talent
		{name = L["Earthbind Totem"], cooldown = 15, desc = "Summons an Earthbind Totem with 5 health at the feet of the caster for 45 sec that slows the movement speed of enemies within 10 yards.", icon = "Spell_Nature_StrengthOfEarthTotem02"},
		{name = L["Fire Nova Totem"], cooldown = 15, desc = "Summons a Fire Nova Totem that has 5 health and lasts 5 sec. Unless it is destroyed within 4 sec., the totem inflicts 396 to 442 fire damage to enemies within 10 yd.", icon = "Spell_Fire_SealOfFire"},
		{name = L["Flame Shock"], cooldown = 5, desc = "Instantly sears the target with fire, causing 292 Fire damage immediately and 320 Fire damage over 12 sec.", icon = "Spell_Fire_FlameShock"}, -- setting cd to 5 sec because of Reverberation talent
		{name = L["Frost Shock"], cooldown = 5, desc = "Instantly shocks the target with frost, causing 486 to 514 Frost damage and slowing movement speed by 50%. Lasts 8 sec.", icon = "Spell_Frost_FrostShock"}, -- setting cd to 5 sec because of Reverberation talent
		{name = L["Stoneclaw Totem"], cooldown = 30, desc = "Summons a Stoneclaw Totem with 480 health at the feet of the caster for 15 sec that taunts creatures within 8 yards to attack it.", icon = "Spell_Nature_StoneClawTotem"},
		{name = L["Astral Recall"], cooldown = (15*60), desc = "Yanks the caster through the twisting nether back to [home]. Speak to an Innkeeper in a different place to change your home location.", icon = "Spell_Nature_AstralRecal"},
		{name = L["Grounding Totem"], cooldown = 13, desc = "Summons a Grounding Totem with 5 health at the feet of the caster that will redirect one harmful spell cast on a nearby party member to itself every 10 seconds. Will not redirect area of effect spells. Lasts 45 sec.", icon = "Spell_Nature_GroundingTotem"}, -- setting cooldown to 13 sec because of 2/2 Guardian Totems talent
		{name = L["Mana Tide Totem"], cooldown = (5*60), desc = "Summons a Mana Tide Totem with 5 health at the feet of the caster for 12 sec that restores 290 mana every 3 seconds to group members within 20 yards.", icon = "Spell_Frost_SummonWaterElemental"},

		-- Hunters
		{name = L["Scare Beast"], cooldown = 30, desc = "Scares a beast, causing it to run in fear for up to 20 sec. Damage caused may interrupt the effect. Only one beast can be feared at a time.", icon = "Ability_Druid_Cower"},
		{name = L["Tranquilizing Shot"], cooldown = 20, desc = "Attempts to remove 1 Frenzy effect from an enemy creature.", icon = "Spell_Nature_Drowsy"},
		{name = L["Arcane Shot"], cooldown = 6, desc = "An instant shot that causes 183 Arcane damage.", icon = "Ability_ImpalingBolt"},
		{name = L["Concussive Shot"], cooldown = 11, desc = "Dazes the target, slowing movement speed by 50% for 4 sec.", icon = "Spell_Frost_Stun"}, -- set cd to 11 sec because of pvp set bonus
		{name = L["Distracting Shot"], cooldown = 8, desc = "Distract the target, causing threat.", icon = "Spell_Arcane_Blink"},
		{name = L["Flare"], cooldown = 15, desc = "Exposes all hidden and invisible enemies within 10 yards of the targeted area for 30 sec.", icon = "Spell_Fire_Flare"},
		{name = L["Multi-Shot"], cooldown = 10, desc = "Fires several missiles, hitting 3 targets for an additional 150 damage.", icon = "Ability_UpgradeMoonGlaive"},
		{name = L["Rapid Fire"], cooldown = (5*60), desc = "Increases ranged attack speed by 40% for 15 sec.", icon = "Ability_Hunter_RunningShot"},
		{name = L["Volley"], cooldown = 60, desc = "Continuously fires a volley of ammo at the target area, causing 80 Arcane damage to enemy targets within 8 yards every second for 6 sec.", icon = "Ability_Marksmanship"},
		{name = L["Counterattack"], cooldown = 5, desc = "A strike that becomes active after parrying an opponent's attack. This attack deals 110 damage and immobilizes the target for 5 sec. Counterattack cannot be blocked, dodged, or parried.", icon = "Ability_Warrior_Challange"},
		{name = L["Disengage"], cooldown = 5, desc = "Attempts to disengage from the target, reducing threat. More effective than Disengage (Rank 2). Character exits combat mode.", icon = "Ability_Rogue_Feint"},
		{name = L["Explosive Trap"], cooldown = 15, desc = "Place a fire trap that explodes when an enemy approaches, causing 201 to 257 Fire damage and 330 additional Fire damage over 20 sec to all within 10 yards. Trap will exist for 1 min. Traps can only be placed when out of combat. Only one trap can be active at a time.", icon = "Spell_Fire_SelfDestruct"},
		{name = L["Feign Death"], cooldown = 30, desc = "Feign death which may trick enemies into ignoring you. Lasts up to 6 min.", icon = "Ability_Rogue_FeignDeath"},
		{name = L["Freezing Trap"], cooldown = 15, desc = "Place a frost trap that freezes the first enemy that approaches, preventing all action for up to 20 sec. Any damage caused will break the ice. Trap will exist for 1 min. Traps can only be placed when out of combat. Only one trap can be active at a time.", icon = "Spell_Frost_ChainsOfIce"},
		{name = L["Frost Trap"], cooldown = 15, desc = "Place a frost trap that creates an ice slick around itself for 30 sec when the first enemy approaches it. All enemies within 10 yards will be slowed by 60% while in the area of effect. Trap will exist for 1 min. Traps can only be placed when out of combat. Only one trap can be active at a time.", icon = "Spell_Frost_FreezingBreath"},
		{name = L["Immolation Trap"], cooldown = 15, desc = "Place a fire trap that will burn the first enemy to approach for 690 Fire damage over 15 sec. Trap will exist for 1 min. Traps can only be placed when out of combat. Only one trap can be active at a time.", icon = "Spell_Fire_FlameShock"},
		{name = L["Mongoose Bite"], cooldown = 5, desc = "Counterattack the enemy for 115 damage. Can only be performed after you dodge.", icon = "Ability_Hunter_SwiftStrike"},
		{name = L["Raptor Strike"], cooldown = 6, desc = "A strong attack that increases melee damage by 140.", icon = "Ability_MeleeDamage"},
		{name = L["Wyvern Sting"], cooldown = 120, desc = "A stinging shot that puts the target to sleep for 12 sec. Any damage will cancel the effect. When the target wakes up, the Sting causes 600 Nature damage over 12 sec. Only usable out of combat. Only one Sting per Hunter can be active on the target at a time.", icon = "INV_Spear_02"},

		-- Warlocks
		{name = L["Soulstone Resurrection"], cooldown = (60*30), desc = "Stores the friendly target's soul. If the target dies while his soul is stored, he will be able to resurrect with 2200 health and 2800 mana.", icon = "spell_shadow_soulgem"},
		{name = L["Curse of Doom"], cooldown = 60, desc = "Curses the target with impending doom, causing 3200 Shadow damage after 1 min. If the target dies from this damage, there is a chance that a Doomguard will be summoned. Cannot be cast on players.", icon = "Spell_Shadow_AuraOfDarkness"},
		{name = L["Death Coil"], cooldown = 120, desc = "Causes the enemy target to run in horror for 3 sec and causes 470 Shadow damage. The caster gains 100% of the damage caused in health.", icon = "Spell_Shadow_DeathCoil"},
		{name = L["Howl of Terror"], cooldown = 40, desc = "Howl, causing 5 enemies within 10 yds to flee in terror for 15 sec. Damage caused may interrupt the effect.", icon = "Spell_Shadow_DeathScream"},
		{name = L["Inferno"], cooldown = (60*60), desc = "Summons a meteor from the Twisting Nether, causing 200 Fire damage and stunning all enemy targets in the area for 2 sec. An Infernal rises from the crater, under the command of the caster for 5 min. Once control is lost, the Infernal must be Enslaved to maintain control. Can only be used outdoors.", icon = "Spell_Shadow_SummonInfernal"},
		{name = L["Ritual of Doom"], cooldown = (60*60), desc = "Begins a ritual that sacrifices a random participant to summon a doomguard. The doomguard must be immediately enslaved or it will attack the ritual participants. Requires the caster and 4 additional party members to complete the ritual. In order to participate, all players must right-click the portal and not move until the ritual is complete.", icon = "Spell_Shadow_AntiMagicShell"},
		{name = L["Shadow Ward"], cooldown = 30, desc = "Absorbs 920 shadow damage. Lasts 30 sec.", icon = "Spell_Shadow_AntiShadow"},
		{name = L["Conflagrate"], cooldown = 10, desc = "Ignites a target that is already afflicted by Immolate, dealing 447 to 557 Fire damage and consuming the Immolate spell.", icon = "Spell_Fire_Fireball"},
		{name = L["Shadowburn"], cooldown = 15, desc = "Instantly blasts the target for 450 to 502 Shadow damage. If the target dies within 5 sec of Shadowburn, and yields experience or honor, the caster gains a Soul Shard.", icon = "Spell_Shadow_ScourgeBuild"},
		{name = L["Soul Fire"], cooldown = 60, desc = "Burn the enemy's soul, causing 703 to 881 Fire damage.", icon = "Spell_Fire_Fireball02"},
		{name = L["Devour Magic"], cooldown = 8, desc = "Purges 1 harmful magic effect from a friend or 1 beneficial magic effect from an enemy. If an effect is devoured, the Felhunter will be healed for 579.", icon = "Spell_Nature_Purge"},
		{name = L["Spell Lock"], cooldown = 30, desc = "Silences the enemy for 3 sec. If used on a casting target, it will counter the enemy's spellcast, preventing any spell from that school of magic from being cast for 8 sec.", icon = "Spell_Shadow_MindRot"},
		{name = L["Lash of Pain"], cooldown = 12, desc = "An instant attack that lashes the target, causing 99 Shadow damage.", icon = "Spell_Shadow_Curse"},
		{name = L["Soothing Kiss"], cooldown = 4, desc = "Soothes the target, increasing the chance that it will attack something else. More effective than Soothing Kiss (Rank 3).", icon = "Spell_Shadow_SoothingKiss"},

		-- Priest
		{name = L["Elune's Grace"], cooldown = (5*60), desc = "Reduces ranged damage taken by 95 and increases chance to dodge by 10% for 15 sec.", icon = "Spell_Holy_ElunesGrace"},
		{name = L["Feedback"], cooldown = (3*60), desc = "The priest becomes surrounded with anti-magic energy. Any successful spell cast against the priest will burn 105 of the attacker's Mana, causing 1 Shadow damage for each point of Mana burned. Lasts 15 sec.", icon = "Spell_Shadow_RitualOfSacrifice"},
		{name = L["Power Word: Shield"], cooldown = 4, desc = "Draws on the soul of the party member to shield them, absorbing 942 damage. Lasts 30 sec. While the shield holds, spellcasting will not be interrupted by damage. Once shielded, the target cannot be shielded again for 15 sec.", icon = "Spell_Holy_PowerWordShield"},
		{name = L["Desperate Prayer"], cooldown = 600, desc = "Instantly heals the caster for 1324 to 1562.", icon = "Spell_Holy_Restoration"},
		{name = L["Fear Ward"], cooldown = 30, desc = "Wards the friendly target against Fear. The next Fear effect used against the target will fail, using up the ward. Lasts 10 min.", icon = "Spell_Holy_Excorcism"},
		{name = L["Devouring Plague"], cooldown = 180, desc = "Afflicts the target with a disease that causes 904 Shadow damage over 24 sec. Damage caused by the Devouring Plague heals the caster.", icon = "Spell_Shadow_BlackPlague"},
		{name = L["Fade"], cooldown = 30, desc = "Fade out, discouraging enemies from attacking you for 10 sec. More effective than Fade (rank 5).", icon = "Spell_Magic_LesserInvisibilty"},
		{name = L["Mind Blast"], cooldown = 6, desc = "Blasts the target for 503 to 531 Shadow damage, but causes a high amount of threat.", icon = "Spell_Shadow_UnholyFrenzy"}, -- setting cd to 6 sec because of 4/5 imp. mind blast talent
		{name = L["Psychic Scream"], cooldown = 26, desc = "The caster lets out a psychic scream, causing 5 enemies within 8 yards to flee for 8 sec. Damage caused may interrupt the effect.", icon = "Spell_Shadow_PsychicScream"}, -- setting cd to 26 sec because of 2/2 imp psychic scream talent
		
		-- Druid
		{name = L["Barkskin"], cooldown = 60, desc = "The druid's skin becomes as tough as bark. Physical damage taken is reduced by 20%. While protected, damaging attacks will not cause spellcasting delays but non-instant spells take 1 sec longer to cast and melee combat is slowed by 20%. Lasts 15 sec.", icon = "Spell_Nature_StoneClawTotem"},
		{name = L["Faerie Fire"], cooldown = 6, desc = "Decrease the armor of the target by 505 for 40 sec. While affected, the target cannot stealth or turn invisible.", icon = "Spell_Nature_FaerieFire"},
		{name = L["Hurricane"], cooldown = 60, desc = "Creates a violent storm in the target area causing 134 Nature damage to enemies every 1 sec, and reducing the attack speed of enemies by 20%. Lasts 10 sec. Druid must channel to maintain the spell.", icon = "Spell_Nature_Cyclone"},
		{name = L["Nature's Grasp"], cooldown = 60, desc = "While active, any time an enemy strikes the caster they have a 35% chance to become afflicted by Entangling Roots (Rank 6). Only useable outdoors. 1 charge. Lasts 45 sec.", icon = "Spell_Nature_NaturesWrath"},
		{name = L["Bash"], cooldown = 60, desc = "Stuns the target for 4 sec.", icon = "Ability_Druid_Bash"},
		{name = L["Challenging Roar"], cooldown = 600, desc = "Forces all nearby enemies to focus attacks on you for 6 sec.", icon = "Ability_Druid_ChallangingRoar"},
		{name = L["Cower"], cooldown = 10, desc = "Cower, causing no damage but lowering your threat a large amount, making the enemy less likely to attack you.", icon = "Ability_Druid_Cower"},
		{name = L["Dash"], cooldown = 300, desc = "Increases movement speed by 60% for 15 sec. Does not break prowling.", icon = "Ability_Druid_Dash"},
		{name = L["Enrage"], cooldown = 60, desc = "Generates 20 rage over 10 sec, but reduces base armor by 27% in Bear Form and 16% in Dire Bear Form. The druid is considered in combat for the duration.", icon = "Ability_Druid_Enrage"},
		{name = L["Frenzied Regeneration"], cooldown = 180, desc = "Converts up to 10 rage per second into health for 10 sec. Each point of rage is converted into 20 health.", icon = "Ability_BullRush"},
		{name = L["Prowl"], cooldown = 10, desc = "Allows the Druid to prowl around, but reduces your movement speed by 30%. Lasts until cancelled.", icon = "Ability_Ambush"},
		{name = L["Tiger's Fury"], cooldown = 1, desc = "Increases damage done by 40 for 6 sec.", icon = "Ability_Mount_JungleTiger"},
		{name = L["Rebirth"], cooldown = (30*60), desc = "Returns the spirit to the body, restoring a dead target to life with 2200 health and 2800 mana.", icon = "Spell_Nature_Reincarnation"},
		{name = L["Tranquility"], cooldown = (5*60), desc = "Regenerates all nearby group members for 294 every 2 seconds for 10 sec. Druid must channel to maintain the spell.", icon = "Spell_Nature_Tranquility"}
	};
	
	-- cd start when buff fades..
	ECDC_DelayedCds = {
		L["Stealth"],
		L["Prowl"],
		L["Shadowmeld"],
		L["Presence of Mind"],
		L["Elemental Mastery"],
		L["Nature's Swiftness"],
		L["Combustion"],
		L["Inner Focus"],
		L["Divine Favor"]
	};
	
	ECDC_FinishCds = {
		-- Rogue
		L["Kidney Shot"],
		L["Evasion"],
		L["Feint"],
		L["Gouge"],
		L["Kick"],
		L["Sprint"],
		L["Blind"],
		L["Distract"],
		L["Vanish"],
		L["Blade Flurry"],
		L["Cold Blood"],
		L["Premeditation"],
		L["Ghostly Strike"],
		
		-- Mage
		L["Cone of Cold"],
		L["Frost Nova"],
		L["Frost Ward"],
		L["Ice Barrier"],
		L["Ice Block"],
		
		-- Hunter
		L["Aimed Shot"],
		L["Multi-Shot"],
		L["Volley"],
		L["Arcane Shot"]
	};
	
end
addon.ECDC_LoadSkills = ECDC_LoadSkills

SLASH_ECDC1 = '/ecdc';
function SlashCmdList.ECDC(param)
	if (param == nil) or (param == "") then
		--InterfaceOptionsFrame_OpenToCategory("ECDC")
		--InterfaceOptionsFrame_OpenToCategory("ECDC") --call twice to work around blizzard bug
		Settings.OpenToCategory("ECDC")
	end
end

-- Message on login
local ECDC_LoginMsg = CreateFrame("FRAME");
ECDC_LoginMsg:SetScript("OnEvent", function()
    C_Timer.After(3, function() 
	print("|cff1a9fc0Enemy Cooldown Count|r loaded!")
	print("Type |cff1a9fc0/ecdc|r to open settings.")
	end);
    ECDC_LoginMsg:UnregisterEvent("PLAYER_ENTERING_WORLD");
end);
ECDC_LoginMsg:RegisterEvent("PLAYER_ENTERING_WORLD");