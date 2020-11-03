clear all; close all; clc;
dirname='dataset_offline';
dirs=dir([dirname,'/P*']);

train_size = 7;
test_size = 10;

for i=1:size(dirs,1)
    pth=[dirname, '/',dirs(i).name];
    
    img = {};
    for pic_idx = 1:train_size
        img(1,1,pic_idx) = {imread([pth,'/train/',num2str(pic_idx),'.bmp'])};
%         imshow(img[pic_idx])
    end
    img = cell2mat(img);
    
    train_label = read_label([pth,'/train.txt']);
    
    b = {};
    for x = 1:size(img,1)
        for y = 1:size(img,2)
            target = double(reshape(img(x,y,:),[],1));
            b(1,x,y) = {(train_label' * train_label)^(-1) * train_label' * target};
        end
    end
    b = cell2mat(b);
    
    test_label = read_label([pth,'/test.txt']);
    
    test_label = mat2cell(test_label, ones(test_size,1), 3);
    test_label_expand = cellfun(@(x) repmat(reshape(x,1,1,3),size(img,1),size(img,2),1), test_label, 'UniformOutput', false);
    b_trans = permute(b,[2,3,1]);
    output_img = cellfun(@(x) uint8(sum(x .* b_trans, 3)), test_label_expand, 'UniformOutput', false);
    
    for j = 1:size(output_img,1)
        imwrite(output_img{j},[pth,'/test/',num2str(j),'.bmp'])
    end
end
