function [left_parameters, right_parameters] = clear_lines(image, lines)

left_parameters = [];
right_parameters = [];
if isempty(lines)
    disp('none');
else
    size_image = size(image);
    i = 1; j = 1; number_lines = 2;
    for k = 1:length(lines)
        line = [lines(k).point1, lines(k).point2]; % lines(k,:)
        size_line  = sqrt((line(3)-line(1))^2 + (line(4)-line(2))^2);
        slope = (line(2)-line(4))/(line(1)-line(3)); % (y1-y2)/(x1-x2)
        intercept = line(2)-slope*(line(1)); % b = y-m*x 
        close_y = size_image(1)-10;
        close_x = round((close_y-intercept)/slope);
        far_y = 10;
        far_x = round((far_y-intercept)/slope);
        if size_line > 50
            if (slope > 0.4) & (slope < 3) & (close_x > round(3*size_image(2)/4))  & (close_x < (size_image(2)+200)) & (far_x > round(size_image(2)/3)) & (i <= number_lines)% dcha
                right_parameters = [right_parameters;[slope, intercept, size_line]];
                i = i + 1;
            elseif (slope < -0.4) & (slope > -3) & (close_x < round(size_image(2)/4)) & (close_x > (0-200)) & (far_x < round(2*size_image(2)/3)) & (j <= number_lines)% izq
                left_parameters = [left_parameters;[slope,intercept, size_line]];
                j = j + 1;
            end
        end
    end
end
end