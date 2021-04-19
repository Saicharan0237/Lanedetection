function [slp,inter] = get_slope_intercept(line)

slope = (line(2)-line(4))/(line(1)-line(3)); % (y1-y2)/(x1-x2)
intercept = line(2)-slope*(line(1)); % b = y-m*x

slp = slope;
inter = intercept;
end