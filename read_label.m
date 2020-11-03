function label = read_label(path)

    label = textread(path,'%s');
    label = cell2mat(label);
    label = [str2num(label(:,3:6)), str2num(label(:,8:10))];
    label = label / 180 * pi;
    label = [cos(label(:,2)) .* sin(label(:,1)),  sin(label(:,2)),  cos(label(:,2)) .* cos(label(:,1))];
