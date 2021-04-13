%project 3
close all;
clear all;

% input video as object
v = VideoReader('Bouncing Ball Reference.mp4'); % for input one
% v = VideoReader('Ball bouncing in slow motion Light ball.mp4'); % for input two

% image alone but with frames as the fourth dimension
obj = read(v);

% image for template extraction
Vid = obj(:, :, :, 1); 
I = double(rgb2gray(Vid));
[rlen,clen] = size(I); 

% now let's view it
figure
imshow(I,[])
title('Reference image')

% now the templates
temp = I(116:233, 226:353); % for the first input
% temp = I(172:221,145:194); % for the second input
[rlen1,clen1] = size(temp);
figure
imshow(temp,[])
title('The template')

% number of frames
nfrm = v.NumFrames;

% the location for each frame
xloc = zeros(nfrm,1);
yloc = zeros(nfrm,1);

for m= 1:nfrm 
    img = double(rgb2gray(obj(:, :, :, m)));
    corr = normxcorr2(temp,img);  % function to find the correlation and find the correlation based on match filter
    [ypk,xpk] = find(corr==max(corr(:)));
    xloc(m) = xpk-rlen1;
    yloc(m) = ypk-clen1;
    
end

figure
hold on
final = zeros(size(obj));
% 'testmovie2.mp4' would be the video file. Check in your current folder.
movie_obj = VideoWriter('testmovie2.mp4');
open(movie_obj);
for i=1:nfrm
    img = obj(:, :, :, i); 
    imshow(img,[])
    hold on 
    rectangle('Position',[xloc(i),yloc(i),size(temp,2),size(temp,1)],'EdgeColor','m');
    F(i)=getframe(gcf);
    writeVideo(movie_obj, F(i));
    pause(0.5);
    hold off   
end
close(movie_obj);
































































