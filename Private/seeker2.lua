-- cowboy programmer
require "base/internal/ui/reflexcore"
Seeker2 = {
	canPosition = false;
	userData = {};
};
registerWidget("Seeker2");

function Seeker2:initialize()
	self.userData = loadUserData();
	CheckSetDefaultValue(self, "userData", "table", {});
	CheckSetDefaultValue(self.userData, "crosshairStrokeWeight", "number", 2);
	CheckSetDefaultValue(self.userData, "dot", "boolean", false);
	CheckSetDefaultValue(self.userData, "stroke", "table", Color(0,255,0,255));
	CheckSetDefaultValue(self.userData, "fill", "table", Color(255,0,255,255));
end

function Seeker2:finalize()
end

function Seeker2:draw(forceDraw)
	local playerHealth = 100;
	if not forceDraw then
		local player = getPlayer();
		local local_player = getLocalPlayer();
		playerHealth = player.health;
		if (player == nil or local_player == nil) then
			return; end
		if (player.state == PLAYER_STATE_SPECTATOR) then
			return; end
		if (player.state == PLAYER_STATE_EDITOR) then
			return; end
		if (world.gameState == GAME_STATE_GAMEOVER) then
			return false; end
		if isInMenu() then
			return; end
		if (replayName == "menu") then
			return false; end
		if (player.health <= 0) then
			return; end
	end
	-- crosshair vars
    local crosshairStrokeWeight = self.userData.crosshairStrokeWeight;
	-- color vars
	local crosshairFillColor = self.userData.fill;
    local crosshairStrokeColor = self.userData.stroke;

	--	drawing seeker xhair manually lol
    nvgBeginPath();
	-- first bracket
	nvgCircle(-9, -8, 1);	--top right
	nvgCircle(-9, -7, 1);
	nvgCircle(-10, -7, 1);
	nvgCircle(-10, -6, 1);
	nvgCircle(-11, -6, 1);
	nvgCircle(-11, -5, 1);
	nvgCircle(-11, -4, 1);
	nvgCircle(-12, -4, 1);
	nvgCircle(-12, -3, 1);
	nvgCircle(-12, -2, 1);
	nvgCircle(-12, -1, 1);
	nvgCircle(-12, 0, 1)	-- center bracket
	nvgCircle(-12, 1, 1);
	nvgCircle(-12, 2, 1);
	nvgCircle(-12, 3, 1);
	nvgCircle(-12, 4, 1);
	nvgCircle(-11, 5, 1);
	nvgCircle(-11, 6, 1);
	nvgCircle(-10, 6, 1);
	nvgCircle(-10, 7, 1);
	nvgCircle(-9, 7, 1);
	nvgCircle(-9, 8, 1);	--bottom right
	nvgRect(-11, -6, 1, 12)
	-- second bracket
	nvgCircle(9, -8, 1);	--top right
	nvgCircle(9, -7, 1);
	nvgCircle(10, -7, 1);
	nvgCircle(10, -6, 1);
	nvgCircle(11, -6, 1);
	nvgCircle(11, -5, 1);
	nvgCircle(12, -4, 1);
	nvgCircle(12, -3, 1);
	nvgCircle(12, -2, 1);
	nvgCircle(12, -1, 1);
	nvgCircle(12, 0, 1)	-- center bracket
	nvgCircle(12, 1, 1);
	nvgCircle(12, 2, 1);
	nvgCircle(12, 3, 1);
	nvgCircle(12, 4, 1);
	nvgCircle(11, 5, 1);
	nvgCircle(11, 6, 1);
	nvgCircle(10, 7, 1);
	nvgCircle(10, 7, 1);
	nvgCircle(9, 7, 1);
	nvgCircle(9, 8, 1);	--bottom right
	nvgRect(10, -4, 1, 12)
	-- center dot
	nvgCircle(0, 0, 2)
	-- color
	nvgStrokeColor(crosshairStrokeColor);
	nvgStrokeWidth(crosshairStrokeWeight);
	nvgStroke();
	nvgFillColor(crosshairFillColor); 
	nvgFill();
end

function Seeker2:drawOptions(x, y, intensity)
	local optargs = {};
	optargs.intensity = intensity;

	nvgSave();
	nvgTranslate(x + WIDGET_PROPERTIES_COL_INDENT + 40, y + 40);
	self:draw(true, x + WIDGET_PROPERTIES_COL_INDENT + 40, y + 40);
	nvgRestore();
	y = y + 70;

	-- vars
	local user = self.userData;
	local sliderWidth = 200;
	local sliderStart = 140;

	fillcol = uiCheckBox(fillcol, "Color", x, y);
	if fillcol then
		y = y + 30;
		user.fill = uiColorPicker(x, y, user.fill, {});
		goto skip
	end
	y = y + 30;
	strokecol = uiCheckBox(strokecol, "OutlineColor", x, y);
	if strokecol then
		y = y + 30;
		user.stroke = uiColorPicker(x, y, user.stroke, {});
		goto skip
	end
	y = y + 30;


	
	user.crosshairStrokeWeight = ui2RowSliderEditBox2Decimals(x, y, WIDGET_PROPERTIES_COL_INDENT, WIDGET_PROPERTIES_COL_WIDTH, 80, "Stroke Weight", user.crosshairStrokeWeight, 1, 2, optargs);
	y = y + 70;

		::skip::
	saveUserData(user);
end

function Seeker2:getOptionsHeight()
	return 470;
end