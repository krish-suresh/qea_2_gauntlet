function filtered_new_data = filterClosePointsKnn(room_data,new_data, d)
    if isempty(room_data)
        filtered_new_data = new_data;
        return;
    end
    idx = knnsearch(room_data, new_data);
    near = room_data(idx, :);
    filtered_new_data = [];
    for i=1:size(near,1)
        if pdist([near(i,:); new_data(i,:)]) > d
            filtered_new_data = [filtered_new_data; new_data(i, :)];
        end
    end
%     filtered_new_data = new_data; % TODO remove points within d range
end

