%% LCSMODEL output ideal velocity of Collar (v_b)
function [v_mod] = LCSMODEL(r, d, l, theta, w)
    % convert theta vector from degrees to radian
    theta = theta / 180 * pi;
    % calculate v_mod according to model derivation
    v_mod = - w / 180 * pi .* r .* sin(theta) - r .* tan(asin((d - r * sin(theta))/l)) .* cos(theta) .* w / 180 * pi;
end

