-- cowboy programmer
require "base/internal/ui/reflexcore"
Seeker1 = {
	canPosition = false;
	userData = {};
};
registerWidget("Seeker1");

function Seeker1:initialize()
	self.userData = loadUserData();
	CheckSetDefaultValue(self, "userData", "table", {});
	CheckSetDefaultValue(self.userData, "crosshairStrokeWeight", "number", 2);
	CheckSetDefaultValue(self.userData, "dot", "boolean", false);
	CheckSetDefaultValue(self.userData, "stroke", "table", Color(0,0,0,255));
	CheckSetDefaultValue(self.userData, "fill", "table", Color(0,0,0,255));
end

function Seeker1:finalize()
end

function Seeker1:draw(forceDraw)
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
	nvgCircle(-11, -10, 1);	--top left
	nvgCircle(-12, -9, 1)
	nvgCircle(-12, -8, 1)
	nvgCircle(-13, -8, 1)
	nvgCircle(-13, -7, 1)
	nvgCircle(-13, -6, 1)
	nvgCircle(-14, -6, 1)
	nvgCircle(-14, -5, 1)
	nvgCircle(-14, -4, 1)
	nvgCircle(-14, -3, 1)
	nvgCircle(-14, -2, 1)
	nvgCircle(-15, -2, 1)
	nvgCircle(-15, -1, 1)
	nvgCircle(-15, 0, 1)	-- center bracket
	nvgCircle(-15, 1, 1)
	nvgCircle(-15, 2, 1)
	nvgCircle(-14, 2, 1)
	nvgCircle(-14, 3, 1)
	nvgCircle(-14, 4, 1)
	nvgCircle(-14, 5, 1)
	nvgCircle(-14, 6, 1)
	nvgCircle(-13, 6, 1)
	nvgCircle(-13, 7, 1)
	nvgCircle(-13, 8, 1)
	nvgCircle(-12, 8, 1)
	nvgCircle(-11, 9, 1);
	nvgCircle(-11, 10, 1);	--bottom left
	-- second bracket
	nvgCircle(11, -10, 1);	--top right
	nvgCircle(11, -9, 1);
	nvgCircle(12, -8, 1)
	nvgCircle(13, -8, 1)
	nvgCircle(13, -7, 1)
	nvgCircle(13, -6, 1)
	nvgCircle(14, -6, 1)
	nvgCircle(14, -5, 1)
	nvgCircle(14, -4, 1)
	nvgCircle(14, -3, 1)
	nvgCircle(14, -2, 1)
	nvgCircle(15, -2, 1)
	nvgCircle(15, -1, 1)
	nvgCircle(15, 0, 1)	-- center bracket
	nvgCircle(15, 1, 1)
	nvgCircle(15, 2, 1)
	nvgCircle(14, 2, 1)
	nvgCircle(14, 3, 1)
	nvgCircle(14, 4, 1)
	nvgCircle(14, 6, 1)
	nvgCircle(13, 6, 1)
	nvgCircle(13, 5, 1)
	nvgCircle(13, 7, 1)
	nvgCircle(13, 8, 1)
	nvgCircle(12, 8, 1)
	nvgCircle(12, 9, 1)
	nvgCircle(11, 9, 1);
	nvgCircle(11, 10, 1);	--bottom right
	-- center dot
	nvgCircle(0, 0, 2)
	-- color
	nvgStrokeColor(crosshairStrokeColor);
    nvgStrokeWidth(crosshairStrokeWeight);
    nvgStroke();
    nvgFillColor(crosshairFillColor); 
    nvgFill();
end

function Seeker1:drawOptions(x, y, intensity)
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

function Seeker1:getOptionsHeight()
	return 470;
end