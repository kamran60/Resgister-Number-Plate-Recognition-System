%% read,resize,convertion into gray,noise remove
close all 
clear all 
[fname,path]=uigetfile('*.*','enter the image');
fname=strcat(path,fname);
im=imread(fname);
%im=imread('10.jpg'); 
figure;
imshow(im)
title('rgb image')
im=imresize(im,[400 NaN]); % Resizing the image keeping aspect ratio same.
g=rgb2gray(im); % Converting the RGB (color) image to gray (intensity).
figure;
imshow(g)
title('gray image')
g=medfilt2(g,[3 3]); % Median filtering to remove noise.
figure 
imshow(g)
title('without noise image')
%% dilation
se=strel('disk',1); % Structural element (disk of radius 1) for morphological processing.
gi=imdilate(g,se); % Dilating the gray image with the structural element.
figure
imshow(gi)
title('dilated gray image')
%% erosion
ge=imerode(g,se); % Eroding the gray image with structural element.
figure
imshow(ge)
title('eroded gray image')
%% edge enhancement 
gdiff=imsubtract(gi,ge);% Morphological Gradient for edges enhancement.
figure
imshow(gdiff)
title('enhance edges')
%% clear edges
gdiff=mat2gray(gdiff); % Converting the class to double.
figure
imshow(gdiff)
title('clear edges')
%% bright edges in image
gdiff=conv2(gdiff,[1 1;1 1]); % Convolution of the double image for brightening the edges.
figure
imshow(gdiff)
title('bright edges in image')
%% increase the intensity of the edges(edges pr intensity barha de white color wali)
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1); % Intensity scaling between the range 0 to 1.
figure
imshow(gdiff)
title('contrast enhaced image')
%% binary image
B=logical(gdiff); % Conversion of the class from double to binary. 
figure;
imshow(B)
title('Binary image');
%% Eliminating the possible horizontal lines and filling holes
er=imerode(B,strel('line',50,0));% remove possible horizontal lines
out1=imsubtract(B,er);
F=imfill(out1,'holes');% Filling all the regions of the image.
figure
imshow(F)
title('removed possible horizontal lines and hole fills')
%% Thinning the image to ensure character isolation.
H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',3,90));
figure
imshow(H)
title('just characters in image')
%% remove the stray pixels and clear the border
final=bwareaopen(H,100);% Selecting all the regions that are of pixel area more than 100.
final=imclearborder(final); % clear border 
figure
imshow(final)
title('clear images')
%% Two properties 'BoundingBox' and binary 'Image' corresponding to these
% Bounding boxes are acquired.
Iprops=regionprops(final,'BoundingBox','Image');
bb = round(reshape([Iprops.BoundingBox], 4, []).'); % reshape function convert the array into 4 by 17 but with the transport(.') it become 17 by 4 then round
figure;
imshow(final);
title('bounding boxes around the objects');
for idx = 1 : numel(Iprops) 
    rectangle('Position', bb(idx,:), 'edgecolor', 'red');
end
%% concantrate the bounding boxes 
NR=cat(1,Iprops.BoundingBox);% Selecting all the bounding boxes in matrix of order numberofboxesX4;
%%
% Calling of FindIndex function.
r=FindIndex(NR); % Function 'FindIndex' outputs the array of indices of boxes required for extraction of characters.

% figure;
% imshow(final);
% title('interested bounding boxes or no box');
%     for j=1:numel(r)
%     rectangle('Position', NR(r(j),:), 'edgecolor', 'green');
%     
%     end
%%
if ~isempty(r) % If succesfully indices of desired boxes are achieved.
    figure;
imshow(final);
title('interested bounding boxes or no box');
    for j=1:numel(r)
    rectangle('Position', NR(r(j),:), 'edgecolor', 'green');
    
    end
    I={Iprops.Image}; % Cell array of 'Image' (one of the properties of regionprops)
    global noPlate;
     noPlate=[]; % Initializing the variable of number plate string.
    number=[];
    alphabet=[];
     for v=1:length(r)
       %if mod(v,2)==1
        N=I{1,r(v)}; % Extracting the binary image corresponding to the indices in 'r'.
        figure;
        imshow(N)
        letter=readLetter(N); % Reading the letter corresponding the binary image 'N'.
%        end
        while letter=='O' || letter=='0' % Since it wouldn't be easy to distinguish
            if v<=3                      % between '0' and 'O' during the extraction of character
                letter='O';              % in binary image. Using the characteristic of plates in Karachi
            else                         % that starting three characters are alphabets, this code will
                letter='0';              % easily decide whether it is '0' or 'O'. The condition for 'if'
            end                          % just need to be changed if the code is to be implemented with some other
            break;                       % cities plates. The condition should be changed accordingly.
        end
        if letter=='0' || letter=='1' ||  letter=='2' ||  letter=='3' ||  letter=='4' ||  letter=='5' ||  letter=='6' ||  letter=='7' ||  letter=='8' ||  letter=='9' 
           number=[number letter];
        else
            alphabet=[alphabet letter];
        end
        %noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
     end
    noPlate=[alphabet number];
%     noplate1=[];
%      for v=1:length(r)
%        if mod(v,2)==0
%         N=I{1,r(v)}; % Extracting the binary image corresponding to the indices in 'r'.
%         figure;
%         imshow(N)
%         letter=readLetter(N); % Reading the letter corresponding the binary image 'N'.
%        end
%         while letter=='O' || letter=='0' % Since it wouldn't be easy to distinguish
%             if v<=3                      % between '0' and 'O' during the extraction of character
%                 letter='O';              % in binary image. Using the characteristic of plates in Karachi
%             else                         % that starting three characters are alphabets, this code will
%                 letter='0';              % easily decide whether it is '0' or 'O'. The condition for 'if'
%             end                          % just need to be changed if the code is to be implemented with some other
%             break;                       % cities plates. The condition should be changed accordingly.
%         end
%         noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
%      end
%disp(noPlate);
    
    fid = fopen('noPlate.txt', 'wt'); % This portion of code writes the number plate
    fprintf(fid,'%s\n',noPlate);      % to the text file, if executed a notepad file with the
    fclose(fid);                      % name noPlate.txt will be open with the number plate written.
    winopen('noPlate.txt')
    

 
    
else % If fail to extract the indexes in 'r' this line of error will be displayed.
    fprintf('Unable to extract the characters from the number plate.\n');
    fprintf('The characters on the number plate might not be clear or touching with each other or boundries.\n');
end