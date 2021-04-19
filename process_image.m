function y = process_image(image, x1, y1, x2, y2)
ROI_image = imcrop(image, [x1, y1, x2, y2]);
filtered_ROI = imgaussfilt(ROI_image, 1);
gray_filt_ROI = rgb2gray(filtered_ROI);
gray_double = im2double(gray_filt_ROI);
I_filter = Image_filtering(gray_double, 100);
level = graythresh(I_filter); 
binarized = imbinarize(I_filter, level);
treated_image = bwareaopen(binarized,90);
edges = edge(treated_image, 'canny');
y = edges;
end
