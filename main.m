clear all;
close all;
clc;

x1 = 100; y1 = 300; x2 = 736; y2 = 224;
lastLline=[0 0 0 0]; lastRline=[0 0 0 0]; pred_left = [0 0 0 0]; pred_right = [0 0 0 0];% Initialize past lines
slopes_l =[]; intercepts_l = [];
slopes_r =[]; intercepts_r = [];
n_predictions = 10;


videofile = VideoReader('solidWhiteRight.mp4');
new_video = VideoWriter('newfile');
open(new_video)
j = 1;
while hasFrame(videofile)
    
    actual_frame = readFrame(videofile);
    binarized = process_image(actual_frame, x1, y1, x2, y2);
    lines = hough_lines(binarized, 40, 300, 1, 50);
    if not(isempty(lines))
        [left_parameters, right_parameters] = clear_lines(binarized, lines); 
        if not(isempty(left_parameters))
            avg_slope = mean(left_parameters(:,1));
            avg_intercept = mean(left_parameters(:,2));
            actual_left = [avg_slope, avg_intercept];
            [slopes_l,intercepts_l,line_l] = estimate_line(slopes_l, intercepts_l, actual_left(1), actual_left(2), n_predictions);
            fitted_left = extrapolate_line(binarized, actual_left);
            resized_left = fitted_left + [x1 y1 x1 y1];
            lastLline = resized_left;
            pred_left = extrapolate_line(binarized, line_l);
            pred_left = pred_left + [x1 y1 x1 y1];
            
        end
        if not(isempty(right_parameters))
            avg_slope = mean(right_parameters(:,1));
            avg_intercept = mean(right_parameters(:,2));
            actual_right = [avg_slope, avg_intercept];
            [slopes_r,intercepts_r,line_r] = estimate_line(slopes_r, intercepts_r, actual_right(1), actual_right(2), n_predictions);
            fitted_right = extrapolate_line(binarized, actual_right);
            resized_right = fitted_right + [x1 y1 x1 y1];
            lastRline = resized_right;
            pred_right = extrapolate_line(binarized, line_r);
            pred_right = pred_right + [x1 y1 x1 y1];
        end        
    end
    
   %Calculating Midpoints,Cross track erros and theta 
    a=((pred_left(1)+pred_right(1))/2);
    b=((pred_left(2)+pred_right(2))/2);
    c=((pred_left(3)+pred_right(3))/2);
    d=((pred_left(4)+pred_right(4))/2);
    
    Xa= a;
    Ya= b;
    Xe = 480;
    Ye = 540;
    Crosstrack_error = sqrt(((Xe-Xa)^2) + ((Ye-Ya)^2));
    real_x_distance = (Xe-Xa)/(960/4.7);
    real_y_distance = (Ye-Ya)/(540/30);
    Crosstrack_error_real = sqrt(((real_x_distance)^2) + ((real_y_distance)^2));
    a_theta = (d-b);
    b_theta = -(c-a);
    Theta = atan(a_theta/b_theta);
    
    actual_frame = draw_lines(actual_frame, pred_left, 0, 0, 5, 'magenta');
    actual_frame = draw_lines(actual_frame, pred_right, 0, 0, 5, 'magenta');
    % Write frame on video
    writeVideo(new_video, actual_frame);
    j = j+1;
end
close(new_video)
disp('final')