%% Initialization
% Get images and convert it into gray scale
L1 = rgb2gray(imread('L10.jpg'));
L2 = rgb2gray(imread('L2.jpg'));
L3 = rgb2gray(imread('L3.jpg'));
L4 = rgb2gray(imread('L4.jpg'));
L5 = rgb2gray(imread('L5.jpg'));
L6 = rgb2gray(imread('L6.jpg'));
L7 = rgb2gray(imread('L7.jpg'));
L8 = rgb2gray(imread('L8.jpg'));
L9 = rgb2gray(imread('L9.jpg'));
L10 = rgb2gray(imread('L10.jpg'));
L11 = rgb2gray(imread('L11.jpg'));
L12 = rgb2gray(imread('L12.jpg'));
L13 = rgb2gray(imread('L13.jpg'));
L14 = rgb2gray(imread('L14.jpg'));
L15 = rgb2gray(imread('L15.jpg'));
L16 = rgb2gray(imread('L16.jpg'));
L17 = rgb2gray(imread('L17.jpg'));

dataSet = {L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17};

sizeData = size(dataSet,2);


%% Section 1 Thresholding
% Using graythresh() to threshold the images
dataSetBI = {};

figure
for i = 1:sizeData
    subplot(3,6,i);
    subimage(dataSet{i});
end

figure
for i = 1:sizeData
    subplot(3,6,i);
    imhist(dataSet{i});
end

figure
for i = 1:sizeData
    subplot(3,6,i);
    level = graythresh(dataSet{i});
    BW = im2bw(dataSet{i}, level);
    dataSetBI{i} = BW;
    subimage(dataSetBI{i});
end
%% Section 2 Mrophology
% Using bwmorph() to get rid of noise erosion + dilution technique
dataSetMorph = {};
dataSetComp = {};
dataSetGrow = {};
sel = strel('square',7);
sel1 = strel('square',4);
sel2 = strel('square',28);

figure
for i = 1:sizeData
    if  i == 2
        dataSetMorph{i} = imdilate(dataSetBI{i},sel);
        subplot(3,6,i);
        subimage(dataSetMorph{i});
    elseif i == 4
        dataSetMorph{i} = imdilate(dataSetBI{i},sel);
        subplot(3,6,i);
        subimage(dataSetMorph{i});
    else
        dataSetMorph{i} = imdilate(dataSetBI{i},sel1);
        subplot(3,6,i);
        subimage(dataSetMorph{i});
    end
end

figure
for i=1:sizeData
    dataSetComp{i} = imcomplement(dataSetMorph{i});
    subplot(3,6,i);
    subimage(dataSetComp{i});
end

figure
for i=1:sizeData
    dataSetGrow{i} = imdilate(dataSetComp{i},sel2);
    subplot(3,6,i);
    subimage(dataSetGrow{i});
end


%% Ratio of the Leaf
% Get the major x-axis and the major y-axis
dataSetMajor = {};
dataSetMinor= {};
dataSetLeaf = {};


for i=1:sizeData
    major = regionprops(dataSetGrow{i},'MajorAxisLength');
    minor = regionprops(dataSetGrow{i}, 'MinorAxisLength');
    dataSetMajor{i} = [major.MajorAxisLength];
    dataSetMinor{i} = [minor.MinorAxisLength];
    dataSetLeaf{i} = [major.MajorAxisLength / minor.MinorAxisLength];
end

numerator1 = 0;
denominator1 = 0;
for i=1:sizeData
    numerator1 = numerator1 + dataSetMajor{i};
    denominator1 = denominator1 + dataSetMinor{i};
    
end

ratio1 = [(numerator1/sizeData)/(denominator1/sizeData)];

%% Initialization
% Get images and convert it into gray scale
T1 = rgb2gray(imread('T1.jpg'));
T2 = rgb2gray(imread('T2.jpg'));
T3 = rgb2gray(imread('T3.jpg'));
T4 = rgb2gray(imread('T4.jpg'));

testData = {T1, T2, L1, T4};

sizeData = size(testData,2);


%% Section 1 Thresholding
% Using graythresh() to threshold the images
dataSetBI = {};

figure
for i = 1:sizeData
    subplot(3,6,i);
    subimage(testData{i});
end

figure
for i = 1:sizeData
    subplot(3,6,i);
    imhist(testData{i});
end

figure
for i = 1:sizeData
    subplot(3,6,i);
    level = graythresh(testData{i});
    BW = im2bw(testData{i}, level);
    dataSetBI{i} = BW;
    subimage(dataSetBI{i});
end
%% Section 2 Mrophology
% Using bwmorph() to get rid of noise erosion + dilution technique
dataSetMorph = {};
dataSetComp = {};
dataSetGrow = {};
selLast = strel('square',18);
sel1 = strel('square',4);
sel2 = strel('square',25);
selFirst = strel('square',18);
selSec = strel('square',8);
selGrow = strel('square',150);

figure
for i = 1:sizeData
    if  i == 1
        dataSetMorph{i} = imdilate(dataSetBI{i},selFirst);
        subplot(3,6,i);
        subimage(dataSetMorph{i});
    elseif i == 2
        dataSetMorph{i} = imdilate(dataSetBI{i},selSec);
        subplot(3,6,i);
        subimage(dataSetMorph{i});
    elseif i == 4
        dataSetMorph{i} = imdilate(dataSetBI{i},selLast);
        subplot(3,6,i);
        subimage(dataSetMorph{i});
    else
        dataSetMorph{i} = imdilate(dataSetBI{i},sel1);
        subplot(3,6,i);
        subimage(dataSetMorph{i});
    end
end

figure
for i=1:sizeData
    dataSetComp{i} = imcomplement(dataSetMorph{i});
    subplot(3,6,i);
    subimage(dataSetComp{i});
end

figure
for i=1:sizeData
    if i == 3
        dataSetGrow{i} = imdilate(dataSetComp{i},sel2);
        subplot(3,6,i);
        subimage(dataSetGrow{i});
    else
        dataSetGrow{i} = imdilate(dataSetComp{i},selGrow);
        subplot(3,6,i);
        subimage(dataSetGrow{i});
    end
end


%% Ratio of the Leaf
% Get the major x-axis and the major y-axis
dataSetRatio = {};


for i=1:sizeData
    major = regionprops(dataSetGrow{i},'MajorAxisLength');
    minor = regionprops(dataSetGrow{i}, 'MinorAxisLength');
    dataSetRatio{i} = [major.MajorAxisLength / minor.MinorAxisLength];
end

for i = 1:sizeData
    if (dataSetRatio{i} > ratio1 && dataSetRatio{i} < max([dataSetLeaf{:}])) || (dataSetRatio{i} < ratio1 && dataSetRatio{i} > min([dataSetLeaf{:}]))
        figure
        title('we found a match');
    end
end


