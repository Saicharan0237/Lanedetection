function y = draw_lines(image, lines, x1, y1, size, color_line)
actual_frame = image;
real_lines = lines + [x1 y1 x1 y1];
for k = 1:length(lines(:,1))
    actual_frame = insertShape(actual_frame,'Line',real_lines(k,:),'LineWidth',size,'Color',color_line);
end
y = actual_frame;
end
