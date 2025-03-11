

function [v_mod] = LCSMODEL(r, d, l, theta, w)
    theta = theta / 180 * pi;
    v_mod = - w / 180 * pi .* r .* sin(theta) - r .* tan(asin((d - r * sin(theta))/l)) .* cos(theta) .* w / 180 * pi;
end

