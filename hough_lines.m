
function y = hough_lines(binary_image, min_line_length, fill_gap_between_lines, rhores, thresh)
a1 = -79:1:-30; a2 = 31:1:80; a = [a1, a2];
[H ,T, R]= hough(binary_image, 'RhoResolution', rhores, 'Theta', a); 
P  = houghpeaks(H, 50, 'Threshold', thresh);
if isempty(P)
    P = [1 1; 1 1];
end
y = houghlines(binary_image, T, R, P, 'MinLength', min_line_length, 'FillGap', fill_gap_between_lines);
end