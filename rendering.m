function [output_img,b] = rendering(pth)
%RENDERING 此处显示有关此函数的摘要
%   此处显示详细说明
%   z的尺度与x和y相同，大小等同于测试图像大小，位置与测试图像像素点一一对应
%   imgs为渲染结果，大小等同于测试图像大小，位置与测试图像像素点一一对应

train_size = 7;
test_size = 10;
threshold = 50;

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
            tmp = train_label;
            err = 0;
            for label_idx = 1:7
                err_tmp = abs(train_label(label_idx,:) * b{1,x,y} - target(label_idx));
                if err_tmp > err
                    err = err_tmp;
                    abandoned_idx = label_idx;
                end
            end
            if err > threshold
                tmp(abandoned_idx,:) = [];
                target(abandoned_idx) = [];
                b(1,x,y) = {(tmp' * tmp)^(-1) * tmp' * target};
            end
        end
    end
    b = cell2mat(b);
    
    test_label = read_label([pth,'/test.txt']);
    
    test_label = mat2cell(test_label, ones(test_size,1), 3);
    test_label_expand = cellfun(@(x) repmat(reshape(x,1,1,3),size(img,1),size(img,2),1), test_label, 'UniformOutput', false);
    b_trans = permute(b,[2,3,1]);
    output_img = cellfun(@(x) uint8(sum(x .* b_trans, 3)), test_label_expand, 'UniformOutput', false);
end

