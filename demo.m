clear all; close all; clc;
dirname='dataset_offline';
dirs=dir([dirname,'/P*']);



for i=1:size(dirs,1)
    pth=[dirname, '/',dirs(i).name];
    
    [output_img,b] = rendering(pth);
    
    for j = 1:size(output_img,1)
        imwrite(output_img{j},[pth,'/test/',num2str(j),'.bmp'])
    end
    fid = fopen(['./dataset_offline/P',num2str(i),'/bx.txt'],'wt');
    for dim = 1:3
        for row = 1:168
            for col = 1:168
                fprintf(fid,'%g\t',b(dim,row,col));
            end
            fprintf(fid,'\n');
        end
        fprintf(fid,'\n');
    end
    fclose(fid);
end
