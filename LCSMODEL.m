%[v_mod] = LCSMODEL(r, d, l, theta, w)
%[theta_exp, w_exp, v_exp, time] = LSCDATA(filename)

function [v_mod] = LCSMODEL(r, d, l, theta, w)
    theta = theta / 180 * pi;
    v_mod = - w .* r .* sin(theta) - r .* tan(asin((d - r * sin(theta))/l)) .* cos(theta) .* w;
end

